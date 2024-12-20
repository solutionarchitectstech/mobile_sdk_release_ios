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

class SingleProductCreativeViewController: UIViewController {

    @IBOutlet weak var outputLabel: UILabel!

    @IBOutlet weak var spinner: UIActivityIndicatorView!

    private var productCreative: ProductCreative!

    override func viewDidLoad() {
        self.productCreative = ProductCreative(query: ProductCreativeQuery(
            placementId: "PRODUCT_01",
            customParams: [
                "object": [
                    "id": "ID00001",
                    "name": "MyObjectName"
                ],
                "string": "MyString",
                "int": 199,
                "float": 3.14,
                "objectList": [
                    [
                        "property": "item",
                        "value": "lego bricks"
                    ],
                    [
                        "property": "amount",
                        "value": 3001
                    ],
                    [
                        "property": "price",
                        "value": 12.99
                    ]
                ],
                "integerList": [11, 12, -13, -14],
                "nonTypicalList": ["some string", 3.14, 199],
                "emptyList": []
            ]
        ))
        self.productCreative.delegate = self
    }

    @IBAction func onRequestButtonClick(_ sender: Any) {
        self.outputLabel.text = nil
        self.outputLabel.isHidden = true
        self.outputLabel.textColor = .none
        self.spinner.isHidden = false

        self.productCreative.load()
    }
}

extension SingleProductCreativeViewController: ProductCreativeDelegate {

    func onLoadDataSuccess() {
        self.spinner.isHidden = true
        self.outputLabel.isHidden = false
    }

    func onLoadDataFail(error: Error) {
        self.spinner.isHidden = true
        self.outputLabel.isHidden = false

        self.outputLabel.textColor = .red
        self.outputLabel.text = "ERROR: Unable to load product creative data due error: \(error.localizedDescription)"
    }

    func onLoadContentSuccess(entity: ProductCreativeEntity) {
        self.spinner.isHidden = true
        self.outputLabel.isHidden = false

        self.outputLabel.textColor = .none
        self.outputLabel.text = "\(String(describing: entity))"
    }

    func onLoadContentFail(query: ProductCreativeQuery, error: Error) {
        self.spinner.isHidden = true
        self.outputLabel.isHidden = false

        self.outputLabel.textColor = .red
        self.outputLabel.text = "ERROR: Unable to load product creative content by '\(query.placementId)' placementId due error: \(error.localizedDescription)"
    }

    public func onNoAdContent(query: ProductCreativeQuery) {
        self.spinner.isHidden = true
        self.outputLabel.isHidden = false

        self.outputLabel.textColor = .brown
        self.outputLabel.text = "WARNING: NoAdContent placementId: \(query.placementId)"
    }
}
