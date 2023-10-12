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


class MultiNativeBannerViewController: UIViewController {

    @IBOutlet weak var bannerView1: NativeBannerView!

    @IBOutlet weak var bannerView2: NativeBannerView!

    @IBOutlet weak var bannerView3: NativeBannerView!

    @IBOutlet weak var bannerView4: NativeBannerView!

    private var bannerCreative: BannerCreative<NativeBannerView>!

    override func viewDidLoad() {
        super.viewDidLoad()

        TechAdvertising.shared.uid = "MY_AUTHORIZED_USER_ID"

        // Let's init banner views
        let mainScreenScale = UIScreen.main.scale

        let pxBanner1Width = Int(bannerView1.frame.size.width * mainScreenScale)
        let pxBanner1Height = Int(bannerView1.frame.size.height * mainScreenScale)
        bannerView1.query = BannerCreativeQuery(
            placementId: "YOUR_PLACEMENT_ID",
            closeButtonType: .NONE,
            sizes: [
                SizeEntity(width: 260, height: 106),
                SizeEntity(width: pxBanner1Width, height: pxBanner1Height)
            ],
            floorPrice: 1.99,
            currency: "USD",
            customParams: [
                "skuId": "LG00001",
                "skuName": "Leggo bricks (speed boat)",
                "category": "Kids",
                "subСategory": "Lego"
            ]
        )

        let pxBanner2Width = Int(bannerView2.frame.size.width * mainScreenScale)
        let pxBanner2Height = Int(bannerView2.frame.size.height * mainScreenScale)
        bannerView2.query = BannerCreativeQuery(
            placementId: "YOUR_PLACEMENT_ID",
            closeButtonType: .VISIBLE,
            sizes: [
                SizeEntity(width: 260, height: 106),
                SizeEntity(width: pxBanner2Width, height: pxBanner2Height)
            ],
            floorPrice: 2.84,
            currency: "RUB"
        )

        bannerView3.scaleToFit = false
        bannerView3.query = BannerCreativeQuery(
            placementId: "YOUR_PLACEMENT_ID",
            closeButtonType: .APPEARING(timeout: 5.0),
            sizes: [
                SizeEntity(width: 260, height: 106)
            ]
        )

        bannerView4.scaleToFit = false
        bannerView4.query = BannerCreativeQuery(
            placementId: "YOUR_PLACEMENT_ID",
            closeButtonType: .COUNTDOWN(timeout: 5.0),
            sizes: [
                SizeEntity(width: 260, height: 106)
            ]
        )

        // Let's init BannerCreative
        self.bannerCreative = .init(
            bannerViews: [
                bannerView1,
                bannerView2,
                bannerView3,
                bannerView4
            ]
        )
        self.bannerCreative.delegate = self

        // Finally, let's load banner creatives
        self.bannerCreative.load()
    }
}

// MARK: - BannerCreativeDelegate

extension MultiNativeBannerViewController: BannerCreativeDelegate {

    public func onLoadDataSuccess(bannerView: BaseBannerView) {
        let placementId = bannerView.query?.placementId
        print("Banner.onLoadDataSuccess[\(String(describing: placementId))]")
    }

    public func onLoadDataFail(bannerView: BaseBannerView, error: Error) {
        let placementId = bannerView.query?.placementId
        print("Banner.onLoadDataFail[\(String(describing: placementId))]: \(error.localizedDescription)")
    }

    public func onLoadContentSuccess(bannerView: BaseBannerView) {
        let placementId = bannerView.query?.placementId
        print("Banner.onLoadContentSuccess[\(String(describing: placementId))]")
    }

    public func onLoadContentFail(bannerView: BaseBannerView, error: Error) {
        let placementId = bannerView.query?.placementId
        print("Banner.onLoadContentFail[\(String(describing: placementId))]: \(error.localizedDescription)")
    }

    public func onNoAdContent(bannerView: BaseBannerView) {
        let placementId = bannerView.query?.placementId
        print("Banner.onNoAdContent[\(String(describing: placementId))]")
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
