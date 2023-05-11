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

class NativeFullscreenViewController: UIViewController {

    @IBOutlet weak var bannerView: NativeBannerView!

    override func viewDidLoad() {
        super.viewDidLoad()

        bannerView.delegate = self

        TechAdvertising.shared.uid = "MY_AUTHORIZED_USER_ID"

        bannerView.loadData(refresh: 7.0, query: SSPAdvertisementQuery(
            placementId: "1",
            closeButtonType: .COUNTDOWN(timeout: 30.0),
            sizes: [SSPSizeEntity(width: 1200, height: 470)],
            customParams: [
                "skuId": "LG00001",
                "skuName": "Leggo bricks (speed boat)",
                "category": "Kids",
                "subСategory": "Lego"
            ]
        ))
    }
}

// MARK: - BannerViewDelegate

extension NativeFullscreenViewController: BannerViewDelegate {

    public func onLoadDataSuccess(placementId: String) {
        print("NativeBanner.onLoadDataSuccess[\(placementId)]")
    }

    public func onLoadDataFail(placementId: String, reason: String) {
        print("NativeBanner.onLoadDataFail[\(placementId)]: \(reason)")
    }

    public func onLoadContentSuccess(placementId: String) {
        print("NativeBanner.onLoadContentSuccess[\(placementId)]")
    }

    public func onLoadContentFail(placementId: String, reason: String) {
        print("NativeBanner.onLoadContentFail[\(placementId)]: \(reason)")
    }

    public func onClose(placementId: String) {
        print("NativeBanner.onClose[\(placementId)]")
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
