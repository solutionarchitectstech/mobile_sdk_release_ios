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

class SingleFullscreenCreativeViewController: UIViewController {

    private var fullscreenVC: FullscreenCreativeViewController!

    private let placementIds = ["HTML_BANNER", "IMAGE_BANNER"]

    override func viewDidLoad() {
        let vc = FullscreenCreativeViewController()
        vc.query = CreativeQuery(
            placementId: "",
            sizes: [SizeEntity(width: 260, height: 106)],
            customParams: [
                "skuId": "LG00001",
                "skuName": "Leggo bricks (speed boat)",
                "category": "Kids",
                "subCategory": "Lego",
                "gdprConsent": "CPsmEWIPsmEWIABAMBFRACBsABEAAAAgEIYgACJAAYiAAA.QRXwAgAAgivA",
                "ccpa": "1YNN",
                "coppa": "1"
            ]
        )
        vc.delegate = self
        vc.refresh = 10.0
        self.fullscreenVC = vc
    }

    @IBAction func onRequestButtonClick(_ sender: Any) {
        self.fullscreenVC.query?.placementId = placementIds.randomElement() ?? ""
        self.present(fullscreenVC, animated: true)
    }
}

// MARK: - CreativeDelegate

extension SingleFullscreenCreativeViewController: CreativeDelegate {

    public func onLoadDataSuccess(creativeView: CreativeView) {
        let placementId = creativeView.query?.placementId
        log("onLoadDataSuccess[\(placementId ?? "")]")
    }

    public func onLoadDataFail(creativeView: CreativeView, error: Error) {
        let placementId = creativeView.query?.placementId
        log("onLoadDataFail[\(placementId ?? "")]: \(error.localizedDescription)")
    }

    public func onLoadContentSuccess(creativeView: CreativeView) {
        let placementId = creativeView.query?.placementId
        log("onLoadContentSuccess[\(placementId ?? "")]")
    }

    public func onLoadContentFail(creativeView: CreativeView, error: Error) {
        let placementId = creativeView.query?.placementId
        log("onLoadContentFail[\(placementId ?? "")]: \(error.localizedDescription)")

        fullscreenVC.dismiss(animated: true)
    }

    public func onNoAdContent(creativeView: CreativeView) {
        let placementId = creativeView.query?.placementId
        log("onNoAdContent[\(placementId ?? "")]")

        fullscreenVC.dismiss(animated: true)
    }

    public func onClose(creativeView: CreativeView) {
        let placementId = creativeView.query?.placementId
        log("onClose[\(placementId ?? "")]")

        fullscreenVC.dismiss(animated: true)
    }
}
