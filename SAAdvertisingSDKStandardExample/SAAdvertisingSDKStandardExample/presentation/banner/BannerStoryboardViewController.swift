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


class BannerStoryboardViewController: UIViewController {

    @IBOutlet weak var bannerView1: BannerView!

    @IBOutlet weak var bannerView2: BannerView!

    @IBOutlet weak var bannerView3: BannerView!

    @IBOutlet weak var bannerView4: BannerView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let mainScreenScale = UIScreen.main.scale

        bannerView1.delegate = self
        let pxBanner1Width = Int(bannerView1.frame.size.width * mainScreenScale)
        let pxBanner1Height = Int(bannerView1.frame.size.height * mainScreenScale)
        bannerView1.loadData(query: SSPAdvertisementQuery(
            placementId: "Banner-1 \(pxBanner1Width)x\(pxBanner1Height) (custom params) 1.99 USD",
            closeButtonType: .NONE,
            sizes: [SSPSizeEntity(width: pxBanner1Width, height: pxBanner1Height)],
            floorPrice: 1.99,
            currency: "USD",
            customParams: [
                "custom_param_01": "Banner-1 (value01)",
                "custom_param_02": "Banner-1 (value02)"
            ]
        ))

        bannerView2.delegate = self
        let pxBanner2Width = Int(bannerView2.frame.size.width * mainScreenScale)
        let pxBanner2Height = Int(bannerView2.frame.size.height * mainScreenScale)
        bannerView2.loadData(query: SSPAdvertisementQuery(
            placementId: "Banner-2 \(pxBanner2Width)x\(pxBanner2Height) 2.84 RUB",
            closeButtonType: .VISIBLE,
            sizes: [SSPSizeEntity(width: pxBanner2Width, height: pxBanner2Height)],
            floorPrice: 2.84,
            currency: "RUB"
        ))

        bannerView3.delegate = self
        bannerView3.isScrollEnabled = true
        bannerView3.scaleToFit = false
        let pxBanner3Width = 1200
        let pxBanner3Height = 470
        bannerView3.loadData(query: SSPAdvertisementQuery(
            placementId: "Banner-3 \(pxBanner3Width)x\(pxBanner3Height) (scrollable)",
            closeButtonType: .APPEARING(timeout: 5.0),
            sizes: [SSPSizeEntity(width: pxBanner3Width, height: pxBanner3Height)]
        ))

        bannerView4.delegate = self
        bannerView4.isScrollEnabled = true
        bannerView4.scaleToFit = false
        let pxBanner4Width = 1200
        let pxBanner4Height = 470
        bannerView4.loadData(query: SSPAdvertisementQuery(
            placementId: "Banner-4 \(pxBanner4Width)x\(pxBanner4Height) (scrollable)",
            closeButtonType: .COUNTDOWN(timeout: 5.0),
            sizes: [SSPSizeEntity(width: pxBanner4Width, height: pxBanner4Height)]
        ))
    }
}

// MARK: - BannerViewDelegate

extension BannerStoryboardViewController: BannerViewDelegate {

    public func onLoadDataSuccess(placementId: String) {
        print("Banner.onLoadDataSuccess[\(placementId)]")
    }

    public func onLoadDataFail(placementId: String, reason: String) {
        print("Banner.onLoadDataFail[\(placementId)]: \(reason)")
    }

    public func onLoadContentSuccess(placementId: String) {
        print("Banner.onLoadContentSuccess[\(placementId)]")
    }

    public func onLoadContentFail(placementId: String, reason: String) {
        print("Banner.onLoadContentFail[\(placementId)]: \(reason)")
    }

    public func onClose(placementId: String) {
        print("Banner.onClose[\(placementId)]")
    }

    public func onDebugSentLoadStatistic(placementId: String) {
        Toast(text: "LOAD statistic: \(placementId)", duration: Delay.short).show()
    }

    public func onDebugSentViewStatistic(placementId: String) {
        Toast(text: "VIEW statistic: \(placementId)", duration: Delay.short).show()
    }

    public func onDebugSentClickStatistic(placementId: String) {
        Toast(text: "CLICK statistic: \(placementId)", duration: Delay.short).show()
    }
}
