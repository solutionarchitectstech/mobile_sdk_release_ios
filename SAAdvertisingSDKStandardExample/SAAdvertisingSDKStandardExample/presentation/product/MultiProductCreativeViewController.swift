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

class MultiProductCreativeViewController: UIViewController {

    @IBOutlet weak var outputLabel1: UILabel!

    @IBOutlet weak var outputLabel2: UILabel!

    @IBOutlet weak var spinner: UIActivityIndicatorView!

    private var productCreative: ProductCreative!

    override func viewDidLoad() {
        let queries = [
            ProductCreativeQuery(
                placementId: "PRODUCT_01",
                customParams: [
                    "skuId": "LG00001",
                    "skuName": "Lego bricks (speed boat)",
                    "category": "Kids",
                    "subCategory": "Lego"
                ]
            ),
            ProductCreativeQuery(
                placementId: "PRODUCT_02",
                customParams: [
                    "skuId": "SW00014",
                    "skuName": "Swing Mirage 2 RS",
                    "category": "Sport",
                    "subCategory": "Speedwings"
                ]
            )
        ]

        self.productCreative = ProductCreative(queries: queries)
        self.productCreative.delegate = self
    }

    @IBAction func onRequestButtonClick(_ sender: Any) {
        self.outputLabel1.text = nil
        self.outputLabel1.isHidden = true
        self.outputLabel1.textColor = .none

        self.outputLabel2.text = nil
        self.outputLabel2.isHidden = true
        self.outputLabel2.textColor = .none

        self.spinner.isHidden = false

        self.productCreative.load()
    }
}

extension MultiProductCreativeViewController: ProductCreativeDelegate {

    func onLoadDataSuccess() {
        self.spinner.isHidden = true
        self.outputLabel1.isHidden = false
        self.outputLabel2.isHidden = false
    }

    func onLoadDataFail(error: Error) {
        let value = "ERROR: Unable to load product creative data due error: \(error.localizedDescription)"
        self.spinner.isHidden = true
        if self.outputLabel1.text == nil {
            self.outputLabel1.isHidden = false
            self.outputLabel1.textColor = .red
            self.outputLabel1.text = value
        } else {
            self.outputLabel2.isHidden = false
            self.outputLabel2.textColor = .red
            self.outputLabel2.text = value
        }
    }

    func onLoadContentSuccess(entity: ProductCreativeEntity) {
        self.spinner.isHidden = true
        let value = "\(String(describing: entity))"
        if self.outputLabel1.text == nil {
            self.outputLabel1.isHidden = false
            self.outputLabel1.textColor = .none
            self.outputLabel1.text = value
        } else {
            self.outputLabel2.isHidden = false
            self.outputLabel2.textColor = .none
            self.outputLabel2.text = value
        }
    }

    func onLoadContentFail(query: ProductCreativeQuery, error: Error) {
        let value = "ERROR: Unable to load product creative content by '\(query.placementId)' placementId due error: \(error.localizedDescription)"
        self.spinner.isHidden = true
        if self.outputLabel1.text == nil {
            self.outputLabel1.isHidden = false
            self.outputLabel1.textColor = .red
            self.outputLabel1.text = value
        } else {
            self.outputLabel2.isHidden = false
            self.outputLabel2.textColor = .red
            self.outputLabel2.text = value
        }
    }

    public func onNoAdContent(query: ProductCreativeQuery) {
        self.spinner.isHidden = true
        self.outputLabel1.isHidden = false
        self.outputLabel2.isHidden = false

        self.outputLabel1.textColor = .brown
        self.outputLabel1.text = "WARNING: NoAdContent placementId: \(query.placementId)"
        self.outputLabel2.text = nil
    }
}
