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

class FullscreenViewController: UIViewController {

    @IBOutlet weak var bannerView: BannerView!

    override func viewDidLoad() {
        super.viewDidLoad()

        bannerView.delegate = self

        bannerView.loadData(query: SSPAdvertisementQuery(
            placementId: "1",
            refresh: 0,
            timeout: 0,
            closeButtonType: CloseButtonType.VISIBLE,
            sizes: [SSPSizeEntity(width: 1200, height: 470)],
            customParams: ["example": "fullscreenBanner"]
        ))
    }
}

extension FullscreenViewController: BannerViewDelegate {
    public func onLoadDataSuccess(placementId: String) {
        print("Banner.onLoadDataSuccess[\(placementId)]")
    }

    public func onLoadDataFail(placementId: String, reason: String) {
        print("Banner.onLoadDataFail[\(placementId)]: \(reason)")
    }

    public func onLoadWebContentSuccess(placementId: String) {
        print("Banner.onLoadWebContentSuccess[\(placementId)]")
    }

    public func onLoadWebContentFail(placementId: String, reason: String) {
        print("Banner.onLoadWebContentFail[\(placementId)]: \(reason)")
    }

    public func onClose(placementId: String) {
        print("Banner.onClose[\(placementId)]")
        dismiss(animated: true)
    }
}
