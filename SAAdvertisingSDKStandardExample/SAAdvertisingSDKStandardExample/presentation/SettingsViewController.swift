//
// Copyright © Gusev Andrew, Emelianov Andrew, Spinov Dmitry [collectively referred as the Authors], 2017 - All Rights Reserved.
// [NOTICE: All information contained herein is, and remains the property of the Authors.]
// The intellectual and technical concepts contained herein are proprietary to the Authors
// and may be covered by any existing patents of any country in the world, patents in
// process, and are protected by trade secret or copyright law.
//
// Dissemination of this information or reproduction of this material is strictly forbidden unless prior
// written permission is obtained from the Authors. Access to the source code contained herein is hereby forbidden
// to anyone except persons (natural person, corporate or unincorporated body, whether or not having a separate
// legal personality, and that person’s personal representatives, and successors)
// the Authors have granted permission and who have executed Confidentiality and Non-disclosure agreements
// explicitly covering such access.
//
// The copyright notice above does not provide evidence of any actual or intended publication or disclosure
// of this source code, which in
//

import UIKit
import SAAdvertisingSDKStandard

class SettingsViewController: UIViewController {

    @IBOutlet weak var transactionProtoPickerView: UIPickerView!

    @IBOutlet weak var publisherIdLabel: UILabel!

    @IBOutlet weak var publisherIdTextField: UITextField!

    @IBOutlet weak var endpointPickerView: UIPickerView!

    @IBOutlet weak var bannerUrlLabel: UILabel!

    @IBOutlet weak var bannerUrlTextField: UITextField!

    @IBOutlet weak var productUrlLabel: UILabel!
    
    @IBOutlet weak var productUrlTextField: UITextField!

    private var isHiddenPublisherFields: Bool {
        get {
            publisherIdTextField.isHidden
        }
        set {
            publisherIdLabel.isHidden = newValue
            publisherIdTextField.isHidden = newValue
        }
    }

    private var isHiddenEndpointFields: Bool {
        get {
            bannerUrlTextField.isHidden
        }
        set {
            bannerUrlLabel.isHidden = newValue
            bannerUrlTextField.isHidden = newValue
            productUrlLabel.isHidden = newValue
            productUrlTextField.isHidden = newValue
        }
    }

    private var transactionProtocols: [TransactionProtocol] = []

    private var selectedTransactionProtocol: TransactionProtocol = .CUSTOM

    private var endpoints: [AppSettings.InitConfigSettings] = []

    private var selectedEndpoint: AppSettings.InitConfigSettings = .MOCK()

    override func viewDidLoad() {
        super.viewDidLoad()

        let appDelegate = UIApplication.shared.delegate as! AppDelegate

        // Setup transation proto fields
        var rtbItem: TransactionProtocol = .OPEN_RTB(publisherId: "YOUR_PUBLISHER_ID")
        if case .OPEN_RTB(let publisherId, _, _, _) = appDelegate.appSettings.transactionProtocol {
            rtbItem = .OPEN_RTB(publisherId: publisherId)
        }
        transactionProtocols = [ .CUSTOM, rtbItem]
        selectedTransactionProtocol = appDelegate.appSettings.transactionProtocol
        transactionProtoPickerView.delegate = self
        transactionProtoPickerView.dataSource = self

        // Setup endpoint fields
        endpoints = [.MOCK(), .REAL()]
        selectedEndpoint = appDelegate.appSettings.initConfigSettings
        endpointPickerView.delegate = self
        endpointPickerView.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        // Transaction proto fields
        var tpRow = 0
        switch selectedTransactionProtocol {
        case .CUSTOM:
            isHiddenPublisherFields = true
        case .OPEN_RTB(let publisherId, _, _, _):
            tpRow = 1
            publisherIdTextField.text = publisherId
            isHiddenPublisherFields = false
        }
        self.transactionProtoPickerView.selectRow(tpRow, inComponent: 0, animated: false)

        // Endpoint fields
        var eRow = 0
        switch selectedEndpoint {
        case .MOCK(_):
            isHiddenEndpointFields = true
        case .REAL(let initConfigCore):
            eRow = 1
            bannerUrlTextField.text = initConfigCore.bannerUrl
            productUrlTextField.text = initConfigCore.productUrl
            isHiddenEndpointFields = false
        }
        self.endpointPickerView.selectRow(eRow, inComponent: 0, animated: false)
    }

    @IBAction func onUpdateButtonClick(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate

        // Let's validate form first
        switch selectedTransactionProtocol {
        case .OPEN_RTB(_, _, _, _):
            let publisherId = publisherIdTextField.text ?? ""
            selectedTransactionProtocol = .OPEN_RTB(publisherId: publisherId)
            transactionProtocols[1] = selectedTransactionProtocol
            if publisherId.isEmpty {
                showError("'publisherId' must not be blank.")
                return
            }
        default:
            break
        }

        switch selectedEndpoint {
        case .REAL(_):
            let bannerUrl = bannerUrlTextField.text ?? ""
            let productUrl = productUrlTextField.text ?? ""
            selectedEndpoint = .REAL(initConfigCore: .init(
                bannerUrl: bannerUrl,
                productUrl: productUrl
            ))
            endpoints[1] = selectedEndpoint

            if bannerUrl.isEmpty {
                showError("'bannerUrl' must not be blank.")
                return
            }
            if productUrl.isEmpty {
                showError("'productUrl' must not be blank.")
                return
            }
        default:
            break
        }

        // Validation passed, let's re-inint SDK
        appDelegate.appSettings = AppSettings(
            transactionProtocol: selectedTransactionProtocol,
            initConfigSettings: selectedEndpoint
        )

        self.navigationController?.popViewController(animated: true)
    }

    private func showError(_ message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}

// MARK: - PickerView

extension SettingsViewController: UIPickerViewDelegate, UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case transactionProtoPickerView:
            return transactionProtocols.count
        case endpointPickerView:
            return endpoints.count
        default:
            return 0
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case transactionProtoPickerView:
            switch transactionProtocols[row] {
            case .CUSTOM:
                return "SA CUSTOM"
            case .OPEN_RTB(_, _, _, _):
                return "OpenRTB"
            }
        case endpointPickerView:
            switch endpoints[row] {
            case .MOCK(_):
                return "MOCK server"
            case .REAL(_):
                return "REAL server"
            }
        default:
            return nil
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case transactionProtoPickerView:
            let newValue = transactionProtocols[row]
            switch newValue {
            case .CUSTOM:
                isHiddenPublisherFields = true
                transactionProtocols[1] = .OPEN_RTB(publisherId: publisherIdTextField.text)
            case .OPEN_RTB(let publisherId, _, _, _):
                publisherIdTextField.text = publisherId
                isHiddenPublisherFields = false
            }
            selectedTransactionProtocol = newValue

        case endpointPickerView:
            let newValue = endpoints[row]
            switch newValue {
            case .MOCK(_):
                isHiddenEndpointFields = true
                endpoints[1] = .REAL(initConfigCore: .init(
                    bannerUrl: bannerUrlTextField.text ?? "",
                    productUrl: productUrlTextField.text ?? ""
                ))
            case .REAL(let initConfigCore):
                bannerUrlTextField.text = initConfigCore.bannerUrl
                productUrlTextField.text = initConfigCore.productUrl
                isHiddenEndpointFields = false
            }
            selectedEndpoint = newValue

        default:
            break
        }
    }

}
