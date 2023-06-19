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
import Toaster

class SingleInlayoutWebBannerViewController: UIViewController {

    @IBOutlet weak var bannerView: BannerView!

    private var bannerCreative: BannerCreative<BannerView>!

    override func viewDidLoad() {
        super.viewDidLoad()

        TechAdvertising.shared.uid = "MY_AUTHORIZED_USER_ID"

        // Let's init banner views
        bannerView.query = BannerCreativeQuery(
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

        // Let's init BannerCreative
        self.bannerCreative = .init(
            bannerView: bannerView,
            refresh: 10.0
        )
        self.bannerCreative.delegate = self

        // Finally, let's load banner creatives
        self.bannerCreative.load()
    }
}

// MARK: - BannerCreativeDelegate

extension SingleInlayoutWebBannerViewController: BannerCreativeDelegate {

    public func onNoAdContent() {
        print("Banner.onNoAdContent")
    }

    public func onLoadDataSuccess() {
        print("Banner.onLoadDataSuccess")
    }

    public func onLoadDataFail(error: Error) {
        print("Banner.onLoadDataFail: \(error.localizedDescription)")
    }

    public func onLoadContentSuccess(bannerView: BaseBannerView) {
        let placementId = bannerView.query?.placementId
        print("Banner.onLoadContentSuccess[\(String(describing: placementId))]")
    }

    public func onLoadContentFail(bannerView: BaseBannerView, error: Error) {
        let placementId = bannerView.query?.placementId
        print("Banner.onLoadContentFail[\(String(describing: placementId))]: \(error.localizedDescription)")
    }

    public func onClose(bannerView: BaseBannerView) {
        let placementId = bannerView.query?.placementId
        print("Banner.onClose[\(String(describing: placementId))]")
    }

    public func onDebugSentLoadStatistic(bannerView: BaseBannerView) {
        let placementId = bannerView.query?.placementId
        Toast(text: "LOAD statistic[\(String(describing: placementId))]", duration: Delay.short).show()
    }

    public func onDebugSentViewStatistic(bannerView: BaseBannerView) {
        let placementId = bannerView.query?.placementId
        Toast(text: "VIEW statistic[\(String(describing: placementId))]", duration: Delay.short).show()
    }

    public func onDebugSentClickStatistic(bannerView: BaseBannerView) {
        let placementId = bannerView.query?.placementId
        Toast(text: "CLICK statistic[\(String(describing: placementId))]", duration: Delay.short).show()
    }
}
