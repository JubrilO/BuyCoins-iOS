//
//  WalletViewController.swift
//  BuyCoins
//
//  Created by Jubril on 6/13/18.
//  Copyright © 2018 bitkoin. All rights reserved.
//

import UIKit
import FSPagerView
import Apollo
import Locksmith

class WalletViewController: UIViewController {
    
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var recieveButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cryptoTypeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var pagerView: FSPagerView! {
        didSet {
            let walletPagerCell = UINib(nibName: Constants.CellIdentifiers.WalletPagerCell, bundle: nil)
            self.pagerView.register(walletPagerCell, forCellWithReuseIdentifier: Constants.CellIdentifiers.WalletPagerCell)
        }
    }
    
    var wallets = [WalletBalanceQuery.Data.CurrentUser.Wallet]() {
        didSet {
           //pagerView.reloadData()
        }
    }
    var walletData: WalletTransactionsQuery.Data? {
        didSet {
            pagerView.reloadData()
            cryptoTransactions = walletData!.currentUser!.cryptoTransactions!.edges! as! [WalletTransactionsQuery.Data.CurrentUser.CryptoTransaction.Edge]
            //tableView.reloadData()
        }
    }
    var cryptoTransactions = [WalletTransactionsQuery.Data.CurrentUser.CryptoTransaction.Edge]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    var currentWalletType = Cryptocurrency.bitcoin
    
    var topSafeArea = CGFloat()
    var bottomSafeArea = CGFloat()
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
        pagerView.isUserInteractionEnabled = false
        fetchWalletDetails(cryptoCurrency: .bitcoin)
        setupNavBarImage()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if #available(iOS 11.0, *) {
            topSafeArea = view.safeAreaInsets.top
            bottomSafeArea = view.safeAreaInsets.bottom
        } else {
            topSafeArea = topLayoutGuide.length
            bottomSafeArea = bottomLayoutGuide.length
        }
    }
    
    @IBAction func onSegmentSelection(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            currentWalletType = .bitcoin
            fetchWalletDetails(cryptoCurrency: .bitcoin)
        case 1:
            currentWalletType = .ethereum
            fetchWalletDetails(cryptoCurrency: .ethereum)
        case 2:
            currentWalletType = .litecoin
            fetchWalletDetails(cryptoCurrency: .litecoin)
        case 3:
            currentWalletType = .bitcoinCash
            fetchWalletDetails(cryptoCurrency: .bitcoinCash)
        default:
            break
        }
                pagerView.scrollToItem(at: sender.selectedSegmentIndex, animated: true)

    }
    
    @IBAction func onRecieveButtonTap(_ sender: UIButton) {
        let transferStoryboard = UIStoryboard(name: Constants.StoryboardNames.Transfer, bundle: nil)
        if let walletAddressVC = transferStoryboard.instantiateViewController(withIdentifier: Constants.StoryboardIDs.WalletAddressScene) as? WalletAddressViewController {
            walletAddressVC.cryptocurrency = currentWalletType
            present(walletAddressVC, animated: true)
        }
    }
    
    @IBAction func onSendButtonTap(_ sender: UIButton) {
        let transferStoryboard = UIStoryboard(name: Constants.StoryboardNames.Transfer, bundle: nil)
        if let sendCoinVC = transferStoryboard.instantiateViewController(withIdentifier: Constants.StoryboardIDs.SendCoinScene) as? SendCoinViewController {
            sendCoinVC.cryptocurrency = currentWalletType
            guard let cryptoNairaPrice = Double(walletData?.cryptoPriceIndex?.values?.first??.rate ?? "0") else { return }
            sendCoinVC.cryptoNairaPrice = cryptoNairaPrice
            present(sendCoinVC, animated: true)
        }
    }
    
    func fetchWalletDetails(cryptoCurrency: Cryptocurrency) {
        let walletDetailsQuery = WalletTransactionsQuery(cryptocurrency: cryptoCurrency)
        apollo.fetch(query: walletDetailsQuery) {
            result, error in
            if let error = error {
                print(error)
                self.displayErrorModal(error: error.localizedDescription)
            }
            
            guard let walletData = result?.data else {print("could not retrieve wallet"); return}
            self.walletData = walletData
        }
    }
}

extension WalletViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cryptoTransactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.WalletTransactionCell) as! WalletTransactionCell
        let cryptoTransaction =  cryptoTransactions[indexPath.row]
        cell.btcAmountLabel.text = cryptoTransaction.node!.amount! + cryptoTransaction.cryptoTypeString
        let nairaAmount = Float(cryptoTransaction.node!.amount!)! * walletData!.cryptoPriceIndex!.currentCryptoPrice
        cell.nairaAmountLabel.text = String(nairaAmount) + " NGN"
        cell.transactionTypeLabel.text = cryptoTransaction.node?.direction
        let dateCreated = Date(timeIntervalSince1970: TimeInterval(cryptoTransaction.node!.createdAt))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a - MMM dd, yyyy"
        cell.transactionBeneficiaryLabel.text = dateFormatter.string(from: dateCreated)
        return cell
    }
}

extension WalletViewController: FSPagerViewDataSource, FSPagerViewDelegate {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return 4
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let page = pagerView.dequeueReusableCell(withReuseIdentifier: Constants.CellIdentifiers.WalletPagerCell, at: index) as! WalletPagerCell
        if cryptoTypeSegmentedControl != nil {
            page.topConstraint.constant = cryptoTypeSegmentedControl.frame.origin.y + cryptoTypeSegmentedControl.bounds.height + 40 - topSafeArea
            view.layoutIfNeeded()
        }
        guard let walletData = walletData else {
            return page
        }
        page.loadData(walletData)
        return page
    }
    
    
    func pagerViewDidScroll(_ pagerView: FSPagerView) {
        
        cryptoTypeSegmentedControl.selectedSegmentIndex = pagerView.currentIndex


    }
}

extension WalletTransactionsQuery.Data.CurrentUser.CryptoTransaction.Edge {
    var cryptoTypeString: String {
        switch self.node!.cryptocurrency! {
        case .bitcoin:
            return " BTC"
        case .ethereum:
            return " ETH"
        case .litecoin:
            return " LTC"
        case .bitcoinCash:
            return " BCH"
        default:
            return ""
        }
    }
}

extension WalletTransactionsQuery.Data.CryptoPriceIndex {
    var currentCryptoPrice: Float {
        return Float(self.values!.first!!.rate!)!
    }
}