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

class SingleInlayoutCreativeViewController: UIViewController {

    @IBOutlet weak var creativeView: CreativeView!

    private let errorLabel = UILabel()

    private var creative: Creative!

    private let placementIds = ["HTML_BANNER", "IMAGE_BANNER"]

    override func viewDidLoad() {
        super.viewDidLoad()

        TechAdvertising.shared.uid = "MY_AUTHORIZED_USER_ID"

        // Let's init creative views
        creativeView.query = CreativeQuery(
            placementId: placementIds.randomElement() ?? "",
            sizes: [SizeEntity(width: 260, height: 106)],
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
        )

        // Let's init Creative
        self.creative = .init(creativeView: creativeView)
        self.creative.delegate = self

        // Finally, let's load creatives
        self.creative.load()
    }
}

// MARK: - CreativeDelegate

extension SingleInlayoutCreativeViewController: CreativeDelegate {

    public func onLoadDataSuccess(creativeView: CreativeView) {
        let placementId = creativeView.query?.placementId
        log("onLoadDataSuccess[\(placementId ?? "")]")

        hideMessage(in: errorLabel)
    }

    public func onLoadDataFail(creativeView: CreativeView, error: Error) {
        let placementId = creativeView.query?.placementId
        let msg = "onLoadDataFail[\(placementId ?? "")]: \(error.localizedDescription)"
        log(msg)

        showMessage(msg, in: errorLabel, for: creativeView, withColor: .red)
    }

    public func onLoadContentSuccess(creativeView: CreativeView) {
        let placementId = creativeView.query?.placementId
        log("onLoadContentSuccess[\(placementId ?? "")]")

        hideMessage(in: errorLabel)
    }

    public func onLoadContentFail(creativeView: CreativeView, error: Error) {
        let placementId = creativeView.query?.placementId
        let msg = "onLoadContentFail[\(placementId ?? "")]: \(error.localizedDescription)"
        log(msg)

        showMessage(msg, in: errorLabel, for: creativeView, withColor: .red)
    }

    public func onNoAdContent(creativeView: CreativeView) {
        let placementId = creativeView.query?.placementId
        let msg = "onNoAdContent[\(placementId ?? "")]"
        log(msg)

        showMessage(msg, in: errorLabel, for: creativeView, withColor: .red)
    }

    public func onClose(creativeView: CreativeView) {
        let placementId = creativeView.query?.placementId
        log("onClose[\(placementId ?? "")]")

        hideMessage(in: errorLabel)
    }
}
