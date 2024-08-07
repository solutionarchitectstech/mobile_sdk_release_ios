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

class MultiCreativeViewController: UIViewController {

    @IBOutlet weak var creativeView1: CreativeView!

    @IBOutlet weak var creativeView2: CreativeView!

    @IBOutlet weak var creativeView3: CreativeView!

    @IBOutlet weak var creativeView4: CreativeView!

    @IBOutlet weak var creativeView5: CreativeView!

    private lazy var errorLabels: [CreativeView: UILabel] = [
        creativeView1: UILabel(),
        creativeView2: UILabel(),
        creativeView3: UILabel(),
        creativeView4: UILabel(),
        creativeView5: UILabel(),
    ]

    private var creative: Creative!

    override func viewDidLoad() {
        super.viewDidLoad()

        TechAdvertising.shared.uid = "MY_AUTHORIZED_USER_ID"

        // Let's init creative views
        let mainScreenScale = UIScreen.main.scale

        let pxCreative1Width = Int(creativeView1.frame.size.width * mainScreenScale)
        let pxCreative1Height = Int(creativeView1.frame.size.height * mainScreenScale)
        creativeView1.query = CreativeQuery(
            placementId: "VAST_Inline_Simple",
            sizes: [
                SizeEntity(width: 260, height: 106),
                SizeEntity(width: pxCreative1Width, height: pxCreative1Height)
            ],
            floorPrice: 1.99,
            currency: "USD",
            customParams: [
                "skuId": "LG00001",
                "skuName": "Lego bricks (speed boat)",
                "category": "Kids",
                "subCategory": "Lego"
            ]
        )

        let pxCreative2Width = Int(creativeView2.frame.size.width * mainScreenScale)
        let pxCreative2Height = Int(creativeView2.frame.size.height * mainScreenScale)
        creativeView2.query = CreativeQuery(
            placementId: "VAST_Wrapper_Compound",
            sizes: [
                SizeEntity(width: 260, height: 106),
                SizeEntity(width: pxCreative2Width, height: pxCreative2Height)
            ],
            floorPrice: 2.84,
            currency: "USD"
        )

        creativeView3.isScrollEnabled = true
        creativeView3.scaleToFit = false
        creativeView3.query = CreativeQuery(
            placementId: "IMAGE_BANNER",
            sizes: [
                SizeEntity(width: 260, height: 106)
            ]
        )

        creativeView4.isScrollEnabled = true
        creativeView4.scaleToFit = false
        creativeView4.query = CreativeQuery(
            placementId: "HTML_BANNER",
            sizes: [
                SizeEntity(width: 260, height: 106)
            ]
        )

        let pxCreative5Width = Int(creativeView5.frame.size.width * mainScreenScale)
        let pxCreative5Height = Int(creativeView5.frame.size.height * mainScreenScale)
        creativeView5.query = CreativeQuery(
            placementId: "MY_CREATIVE",
            sizes: [
                SizeEntity(width: pxCreative5Width, height: pxCreative5Height)
            ]
        )

        // Let's init Creative
        self.creative = .init(
            creativeViews: [
                creativeView1,
                creativeView2,
                creativeView3,
                creativeView4,
                creativeView5
            ]
        )
        self.creative.delegate = self

        // Finally, let's load creatives
        self.creative.load()
    }
}

// MARK: - CreativeDelegate

extension MultiCreativeViewController: CreativeDelegate {

    public func onLoadDataSuccess(creativeView: CreativeView) {
        let placementId = creativeView.query?.placementId
        log("onLoadDataSuccess[\(placementId ?? "")]")

        if let label = errorLabels[creativeView] {
            hideMessage(in: label)
        }
    }

    public func onLoadDataFail(creativeView: CreativeView, error: Error) {
        let placementId = creativeView.query?.placementId
        let msg = "onLoadDataFail[\(placementId ?? "")]: \(error.localizedDescription)"
        log(msg)

        if let label = errorLabels[creativeView] {
            showMessage(msg, in: label, for: creativeView, withColor: .red)
        }
    }

    public func onLoadContentSuccess(creativeView: CreativeView) {
        let placementId = creativeView.query?.placementId
        log("onLoadContentSuccess[\(placementId ?? "")]")

        if let label = errorLabels[creativeView] {
            hideMessage(in: label)
        }
    }

    public func onLoadContentFail(creativeView: CreativeView, error: Error) {
        let placementId = creativeView.query?.placementId
        let msg = "onLoadContentFail[\(placementId ?? "")]: \(error.localizedDescription)"
        log(msg)

        if let label = errorLabels[creativeView] {
            showMessage(msg, in: label, for: creativeView, withColor: .red)
        }
    }

    public func onNoAdContent(creativeView: CreativeView) {
        let placementId = creativeView.query?.placementId
        let msg = "onNoAdContent[\(placementId ?? "")]"
        log(msg)

        if let label = errorLabels[creativeView] {
            showMessage(msg, in: label, for: creativeView, withColor: .red)
        }
    }

    public func onClose(creativeView: CreativeView) {
        let placementId = creativeView.query?.placementId
        log("onClose[\(placementId ?? "")]")

        if let label = errorLabels[creativeView] {
            hideMessage(in: label)
        }
    }
}
