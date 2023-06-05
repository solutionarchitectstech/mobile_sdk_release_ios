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

class ProductCreativeViewController: UIViewController {

    @IBOutlet weak var outputLabel: UILabel!

    @IBOutlet weak var spinner: UIActivityIndicatorView!

    private var productCreative: ProductCreative!

    override func viewDidLoad() {
        self.productCreative = ProductCreative(query: ProductCreativeQuery(
            placementId: "YOUR_PLACEMENT_ID",
            customParams: [
                "skuId": "LG00001",
                "skuName": "Leggo bricks (speed boat)",
                "category": "Kids",
                "subСategory": "Lego"
            ]
        ))
        self.productCreative.delegate = self
    }

    @IBAction func onRequestButtonClick(_ sender: Any) {
        self.outputLabel.text = nil
        self.outputLabel.isHidden = true
        self.outputLabel.textColor = .black
        self.spinner.isHidden = false

        self.productCreative.load()
    }
}

extension ProductCreativeViewController: ProductCreativeDelegate {

    func onLoadDataSuccess(entity: ProductCreativeEntity?) {
        self.spinner.isHidden = true
        self.outputLabel.isHidden = false

        self.outputLabel.text = "\(String(describing: entity))"
    }

    func onLoadDataFail(query: ProductCreativeQuery, error: Error) {
        self.spinner.isHidden = true
        self.outputLabel.isHidden = false

        self.outputLabel.textColor = .red
        self.outputLabel.text = "ERROR: \(error.localizedDescription)"
    }
}
