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

class SingleFullscreenWebBannerViewController: UIViewController {

    private var fullscreenVC: FullscreenBannerViewController!

    override func viewDidLoad() {
        let vc = FullscreenBannerViewController()
        vc.query = BannerCreativeQuery(
            placementId: "YOUR_PLACEMENT_ID",
            closeButtonType: .COUNTDOWN(timeout: 5.0),
            sizes: [SizeEntity(width: 260, height: 106)],
            customParams: [
                "skuId": "LG00001",
                "skuName": "Leggo bricks (speed boat)",
                "category": "Kids",
                "subСategory": "Lego",
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
        self.present(fullscreenVC, animated: true)
    }
}

// MARK: - BannerCreativeDelegate

extension SingleFullscreenWebBannerViewController: BannerCreativeDelegate {

    public func onLoadDataSuccess(bannerView: BaseBannerView) {
        let placementId = bannerView.query?.placementId
        print("Banner.onLoadDataSuccess[\(String(describing: placementId))]")
    }

    public func onLoadDataFail(bannerView: BaseBannerView, error: Error) {
        let placementId = bannerView.query?.placementId
        print("Banner.onLoadDataFail[\(String(describing: placementId))]: \(error.localizedDescription)")

        fullscreenVC.dismiss(animated: true)
    }

    public func onLoadContentSuccess(bannerView: BaseBannerView) {
        let placementId = bannerView.query?.placementId
        print("Banner.onLoadContentSuccess[\(String(describing: placementId))]")
    }

    public func onLoadContentFail(bannerView: BaseBannerView, error: Error) {
        let placementId = bannerView.query?.placementId
        print("Banner.onLoadContentFail[\(String(describing: placementId))]: \(error.localizedDescription)")

        fullscreenVC.dismiss(animated: true)
    }

    public func onNoAdContent(bannerView: BaseBannerView) {
        let placementId = bannerView.query?.placementId
        print("Banner.onNoAdContent[\(String(describing: placementId))]")

        fullscreenVC.dismiss(animated: true)
    }

    public func onClose(bannerView: BaseBannerView) {
        let placementId = bannerView.query?.placementId
        print("Banner.onClose[\(String(describing: placementId))]")

        fullscreenVC.dismiss(animated: true)
    }

    public func onTap(bannerView: BaseBannerView, redirectUrl: URL?) {
        let placementId = bannerView.query?.placementId
        print("Banner.onTap[\(String(describing: placementId))]: \(String(describing: redirectUrl))")

        fullscreenVC.dismiss(animated: true)
        // You can also use another variant to close banner, like:
        // bannerView.closeBanner(notify: true)
    }
}
