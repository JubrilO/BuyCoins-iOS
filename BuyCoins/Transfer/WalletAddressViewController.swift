//
//  WalletAddressViewController.swift
//  BuyCoins
//
//  Created by Jubril on 29/06/2018.
//  Copyright © 2018 bitkoin. All rights reserved.
//

import UIKit
import Apollo
import QRCode

class WalletAddressViewController: UIViewController {

    @IBOutlet weak var barcodeImageView: UIImageView!
    @IBOutlet weak var walletAddressLabel: UILabel!
    @IBOutlet weak var toggleAddressDisplayButton: UIButton!
    @IBOutlet weak var walletAddressBackgroundView: UIView!
    @IBOutlet weak var cardView: UIView!
    
    var cryptocurrency: Cryptocurrency!
    var walletData: WalletAddressQuery.Data? {
        didSet {
            displayBarCode()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchWalletAddress() 

    }

    @IBAction func onCancelButtonTap(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func onShowAddressButtonTap(_ sender: UIButton) {
        
    }
    
    func displayBarCode() {
        if let walletAddress = walletData?.getAddress?.address {
            var qrCode = QRCode(walletAddress)
            qrCode?.color = CIColor(rgba: "000")
            qrCode?.backgroundColor = CIColor(rgba: "fff")
            barcodeImageView.image = qrCode?.image
            walletAddressLabel.text = walletAddress
        }
    }
    
    func fetchWalletAddress() {
        let walletAddressQuery = WalletAddressQuery(cryptocurrency: cryptocurrency)
        ApolloManager.shared.apolloClient.fetch(query: walletAddressQuery, cachePolicy: .returnCacheDataAndFetch) {
            result, error in
            if let error = error {
                print(error)
                self.displayErrorModal(error: error.localizedDescription)
            }
            
            guard let walletData = result?.data else { print ("could not retreive wallet address"); return}
            self.walletData = walletData
        }
    }
}
