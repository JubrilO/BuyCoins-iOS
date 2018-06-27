//
//  OverviewViewController.swift
//  BuyCoins
//
//  Created by Jubril on 5/29/18.
//  Copyright © 2018 bitkoin. All rights reserved.
//

import UIKit
import Apollo
import Locksmith
import Charts

class OverviewViewController: UIViewController {
    
    @IBOutlet weak var priceChart: LineChartView!
    @IBOutlet weak var currentPriceLabel: UILabel!
    @IBOutlet weak var cryptoCurrencyLabel: UILabel!
    @IBOutlet weak var btcWalletBalanceLabel: UILabel!
    @IBOutlet weak var btcWalletBalanceNaira: UILabel!
    @IBOutlet weak var ethWalletBalanceLabel: UILabel!
    @IBOutlet weak var ethWalletBalanceNairaLabel: UILabel!
    @IBOutlet weak var ltcWalletBalanceLabel: UILabel!
    @IBOutlet weak var ltcWalletBalanceNairaLabel: UILabel!
    @IBOutlet weak var bchWalletBalanceLabel: UILabel!
    @IBOutlet weak var bchWalletBalanceNairaLabel: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var arrowImageView: UIImageView!
    @IBOutlet weak var monthDataButton: UIButton!
    @IBOutlet weak var weekDataButton: UIButton!
    @IBOutlet weak var dayDataButton: UIButton!
    
    weak var axisFormatDelegate: IAxisValueFormatter?
    var graphTimePeriod = CryptoPeriodTypes.month
    
    let apollo: ApolloClient = {
        let configuration = URLSessionConfiguration.default
        let url = URL(string: APIConstants.GraphqlUrl)!
        if let auth = Locksmith.loadDataForUserAccount(userAccount: Constants.BCUser)?["token"] as? String {
            configuration.httpAdditionalHeaders = ["Authorization": auth]
            return ApolloClient(networkTransport: HTTPNetworkTransport(url: url, configuration: configuration))
        }
        else {
            print("Sign in user")
            return ApolloClient(url: url)
        }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBarImage()
        updatePrices()
        fetchWalletData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        axisFormatDelegate = self
        priceChart.delegate = self
        updatePrices()
        fetchWalletData()
    }
    
    @IBAction func onBuyCoinsButtonTap(_ sender: UIButton) {
    }
    
    @IBAction func onSellCoinsButtonTap(_ sender: UIButton) {
    }
    
    @IBAction func onGetStartedButtonTap(_ sender: UIButton) {
    }
    
    @IBAction func onWalletDetailsButtonTap(_ sender: UIButton) {
    }
    
    @IBAction func onMonthButtonTap(_ sender: UIButton) {
        deselectAllDataButtons()
        setupPeriodButtonSelectedState(sender)
    }
    
    @IBAction func onWeekButtonTap(_ sender: UIButton) {
        deselectAllDataButtons()
        setupPeriodButtonSelectedState(sender)
    }
    
    @IBAction func onDayButtonTap(_ sender: UIButton) {
        deselectAllDataButtons()
        setupPeriodButtonSelectedState(sender)
    }
    
    @IBAction func onSegmentedControlValueChanged(_ sender: UISegmentedControl, forEvent event: UIEvent) {
            updatePrices()
    }
    
    func deselectAllDataButtons() {
        dayDataButton.backgroundColor = UIColor.clear
        weekDataButton.backgroundColor = UIColor.clear
        monthDataButton.backgroundColor = UIColor.clear
        dayDataButton.titleLabel?.font = UIFont.bcFontRegular(size: 13)
        weekDataButton.titleLabel?.font = UIFont.bcFontRegular(size: 13)
        monthDataButton.titleLabel?.font = UIFont.bcFontRegular(size: 13)
    }
    
    func setupPeriodButtonSelectedState(_ sender: UIButton) {
        sender.backgroundColor = UIColor.bcLightGrey
        sender.titleLabel?.font = UIFont.bcFontMedium(size: 13)
    }
    
    func updatePrices() {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            fetchGraphPrices(cryptoCurrency: .bitcoin)
            updateCurrentPrice(.bitcoin)
        case 1:
            fetchGraphPrices(cryptoCurrency: .ethereum)
            updateCurrentPrice(.ethereum)
        case 2:
            fetchGraphPrices(cryptoCurrency: .litecoin)
            updateCurrentPrice(.litecoin)
        case 3:
            fetchGraphPrices(cryptoCurrency: .bitcoinCash)
            updateCurrentPrice(.bitcoinCash)
        default:
            break
        }
    }
    

    
    func fetchGraphPrices(period: CryptoPeriodTypes = .month, cryptoCurrency: Cryptocurrency) {
        let priceQuery = CryptoPriceIndexQuery(period: period, cryptocurrency: cryptoCurrency)
        apollo.fetch(query: priceQuery, cachePolicy: .returnCacheDataAndFetch) { result, error in
            if let error = error {
                print(error)
                self.displayErrorModal(error: error.localizedDescription)
            }
            guard let prices = result?.data?.cryptoPriceIndex?.values else {
                print("Error: Could not retrieve prices")
                return
                
            }
            self.updateGraph(prices: prices, period: period)
        }
    }
    
    
    
    func updateCurrentPrice(_ cryptoCurrency: Cryptocurrency = Cryptocurrency.bitcoin) {
        let priceQuery = CryptoPriceIndexQuery(period: CryptoPeriodTypes.current, cryptocurrency: cryptoCurrency)
        apollo.fetch(query: priceQuery, cachePolicy: .returnCacheDataAndFetch) { result, error in
            if let error = error {
                print(error)
                self.displayErrorModal(error: error.localizedDescription)
            }
            guard let prices = result?.data?.cryptoPriceIndex?.values else {
                print("Error: Could not retrieve prices")
                return
                
            }
            self.currentPriceLabel.text = Double(prices.first!!.rate!)!.withCommas() + " NGN"
            switch cryptoCurrency {
            case .bitcoin:
                self.cryptoCurrencyLabel.text = " / BTC"
            case .ethereum:
                self.cryptoCurrencyLabel.text = " / ETH"
            case .litecoin:
                self.cryptoCurrencyLabel.text = " / LTC"
            case .bitcoinCash:
                self.cryptoCurrencyLabel.text = " / BCH"
            default:
                break
            }
        }
    }
    
    func fetchWalletData() {
        let walletQuery = WalletQuery()
        apollo.fetch(query: walletQuery, cachePolicy: .returnCacheDataAndFetch) { result, error in
            if let error = error {
                print(error)
                self.displayErrorModal(error: error.localizedDescription)
            }
            guard let wallets = result?.data?.currentUser?.wallets else {
                print("Error: Could not retrieve wallets")
                return
            }
            
            for wallet in wallets {
                switch wallet!.cryptocurrency! {
                case .bitcoin:
                    self.getCurrentCryptoPrice(coin: .bitcoin) {
                        price, error in
                        if let price = price {
                            self.btcWalletBalanceNaira.text = " ~ " + (Double(wallet!.confirmedBalance!)! * price).withCommas() + " NGN"
                        }
                    }
                    self.btcWalletBalanceLabel.text = wallet?.confirmedBalance
                case .litecoin:
                    self.getCurrentCryptoPrice(coin: .litecoin) {
                        price, error in
                        if let price = price {
                            self.ltcWalletBalanceNairaLabel.text = " ~ " + (Double(wallet!.confirmedBalance!)! * price).withCommas() + " NGN"
                        }
                    }
                    self.ltcWalletBalanceLabel.text = wallet?.confirmedBalance
                case .ethereum:
                    self.getCurrentCryptoPrice(coin: .ethereum) {
                        price, error in
                        if let price = price {
                            self.ethWalletBalanceNairaLabel.text = " ~ " + (Double(wallet!.confirmedBalance!)! * price).withCommas() + " NGN"
                        }
                    }
                    self.ethWalletBalanceLabel.text = wallet?.confirmedBalance
                case .bitcoinCash:
                    self.getCurrentCryptoPrice(coin: .bitcoinCash) {
                        price, error in
                        if let price = price {
                            self.bchWalletBalanceNairaLabel.text = " ~ " + (Double(wallet!.confirmedBalance!)! * price).withCommas() + " NGN"
                        }
                    }
                    self.bchWalletBalanceLabel.text = wallet?.confirmedBalance
                default:
                    break
                }
            }
        }
    }
    
    func getCurrentCryptoPrice(coin: Cryptocurrency, completionHandler: @escaping (Double?, Error?) -> ()) {
        let priceQuery = CryptoPriceIndexQuery(period: CryptoPeriodTypes.current, cryptocurrency: .bitcoin)
        apollo.fetch(query: priceQuery, cachePolicy: .returnCacheDataAndFetch) { result, error in
            if let error = error {
                print(error)
                self.displayErrorModal(error: error.localizedDescription)
            }
            guard let prices = result?.data?.cryptoPriceIndex?.values else {
                print("Error: Could not retrieve prices")
                return
            }
            completionHandler(Double(prices.first!!.rate!)!, nil)
        }
    }
    
    func updateGraph(prices: [CryptoPriceIndexQuery.Data.CryptoPriceIndex.Value?], period: CryptoPeriodTypes) {
        priceChart.leftAxis.enabled = false
        priceChart.rightAxis.enabled = false
        priceChart.xAxis.drawGridLinesEnabled = false
        priceChart.xAxis.drawAxisLineEnabled = false
        //priceChart.xAxis.enabled = false
        priceChart.xAxis.labelPosition = .bottom
        priceChart.xAxis.labelFont = UIFont.graphLabelFont
        priceChart.xAxis.labelTextColor = UIColor.coolGrey
        switch period {
        case .day:
            print("Day label")
            priceChart.xAxis.labelCount = 5
        case .week:
            print("week label")
            priceChart.xAxis.labelCount = 3
        case .month:
            print("Month label")
            priceChart.xAxis.labelCount = 5
        default:
            print("Default")
            break
        }
        let xAxis = priceChart.xAxis
        xAxis.valueFormatter = axisFormatDelegate
        priceChart.chartDescription?.text = ""
        priceChart.legend.enabled = false
        var lineChartEntry = [ChartDataEntry]()
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd HH:mm:ss zzz"
        
        for price in prices {
            let date = dateformatter.date(from: price!.date)!
            let dateDouble = Double(date.timeIntervalSince1970)
            let value = ChartDataEntry(x: Double(dateDouble), y:  Double(price!.rate!)!)
            lineChartEntry.append(value)
        }
        
        let line1 = LineChartDataSet(values: lineChartEntry, label: nil)
        line1.drawCirclesEnabled = false
        line1.drawFilledEnabled = true
        line1.drawValuesEnabled = true
        line1.colors = [UIColor.bcPurple]
        line1.fillAlpha = 0.5
        line1.fillColor = UIColor.bcPurple
        line1.mode = .horizontalBezier
        
        let data = LineChartData()
        data.addDataSet(line1)
        priceChart.data = data
        priceChart.animate(yAxisDuration: 1)
    }
}

extension OverviewViewController: IAxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let dateFormatter = DateFormatter()
        switch graphTimePeriod {
        case .day:
            dateFormatter.dateFormat = "HH:mm"
        case .week:
            dateFormatter.dateFormat = "dd.MMM"
        case .month:
            dateFormatter.dateFormat = "dd.MMM"
        default:
            break
        }
        return dateFormatter.string(from: Date(timeIntervalSince1970: value))
    }
}

extension OverviewViewController: ChartViewDelegate {
    
}
