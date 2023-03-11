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

class NativeBannerProgrammaticallyViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let mainScreenScale = UIScreen.main.scale

        let bannerView1 = addBannerView(
            to: view,
            position: (h: .leading, v: .top),
            aspectRatio: (w: 2 / 3, h: 1 / 6)
        )
        bannerView1.backgroundColor = .white
        bannerView1.delegate = self
        let pxBanner1Width = Int(bannerView1.frame.size.width * mainScreenScale)
        let pxBanner1Height = Int(bannerView1.frame.size.height * mainScreenScale)
        bannerView1.loadData(query: SSPAdvertisementQuery(
            placementId: "NativeBanner-1 \(pxBanner1Width)x\(pxBanner1Height) (custom params) 1.99 USD",
            refresh: 0,
            timeout: 0,
            closeButtonType: CloseButtonType.VISIBLE,
            sizes: [SSPSizeEntity(width: pxBanner1Width, height: pxBanner1Height)],
            floorPrice: 1.99,
            currency: "USD",
            customParams: [
                "custom_param_01": "NativeBanner-1 (value01)",
                "custom_param_02": "NativeBanner-1 (value02)"
            ]
        ))

        let bannerView2 = addBannerView(
            to: view,
            position: (h: .trailing, v: .top),
            aspectRatio: (w: 1 / 4, h: 1 / 4)
        )
        bannerView2.backgroundColor = .white
        bannerView2.delegate = self
        let pxBanner2Width = Int(bannerView2.frame.size.width * mainScreenScale)
        let pxBanner2Height = Int(bannerView2.frame.size.height * mainScreenScale)
        bannerView2.loadData(query: SSPAdvertisementQuery(
            placementId: "NativeBanner-2 \(pxBanner2Width)x\(pxBanner2Height) 2.84 RUB",
            refresh: 0,
            timeout: 0,
            closeButtonType: CloseButtonType.VISIBLE,
            sizes: [SSPSizeEntity(width: pxBanner2Width, height: pxBanner2Height)],
            floorPrice: 2.84,
            currency: "RUB"
        ))

        let bannerView3 = addBannerView(
            to: view,
            position: (h: .leading, v: .bottom),
            aspectRatio: (w: 1 / 4, h: 1 / 4)
        )
        bannerView3.backgroundColor = .white
        bannerView3.delegate = self
        let pxBanner3Width = 1200
        let pxBanner3Height = 470
        bannerView3.loadData(query: SSPAdvertisementQuery(
            placementId: "NativeBanner-3 \(pxBanner3Width)x\(pxBanner3Height)",
            refresh: 0,
            timeout: 0,
            closeButtonType: CloseButtonType.VISIBLE,
            sizes: [SSPSizeEntity(width: pxBanner3Width, height: pxBanner3Height)]
        ))

        let bannerView4 = addBannerView(
            to: view,
            position: (h: .trailing, v: .bottom),
            aspectRatio: (w: 2 / 3, h: 1 / 6)
        )
        bannerView4.backgroundColor = .white
        bannerView4.delegate = self
        let pxBanner4Width = 1200
        let pxBanner4Height = 470
        bannerView4.loadData(query: SSPAdvertisementQuery(
            placementId: "NativeBanner-4 \(pxBanner4Width)x\(pxBanner4Height)",
            refresh: 0,
            timeout: 0,
            closeButtonType: CloseButtonType.VISIBLE,
            sizes: [SSPSizeEntity(width: pxBanner4Width, height: pxBanner4Height)]
        ))
    }

    private func addBannerView(
        to superview: UIView,
        position: (h: NSLayoutConstraint.Attribute, v: NSLayoutConstraint.Attribute),
        aspectRatio: (w: CGFloat, h: CGFloat)
    ) -> NativeBannerView {
        // You can also use NativeBannerView(frame: CGRect) constructor to instantiate the view
        // with initial size/position.
        // let bannerView = NativeBannerView(frame: CGRect(x: 0, y: 0, width: 640, height: 480))
        let bannerView = NativeBannerView()

        superview.addSubview(bannerView)

        bannerView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint(
            item: bannerView,
            attribute: position.v,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: superview.safeAreaLayoutGuide,
            attribute: position.v,
            multiplier: 1,
            constant: 0
        ).isActive = true

        NSLayoutConstraint(
            item: bannerView,
            attribute: position.h,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: superview.safeAreaLayoutGuide,
            attribute: position.h,
            multiplier: 1,
            constant: 0
        ).isActive = true

        NSLayoutConstraint(
            item: bannerView,
            attribute: NSLayoutConstraint.Attribute.width,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: superview.safeAreaLayoutGuide,
            attribute: NSLayoutConstraint.Attribute.width,
            multiplier: aspectRatio.w,
            constant: 0
        ).isActive = true

        NSLayoutConstraint(
            item: bannerView,
            attribute: NSLayoutConstraint.Attribute.height,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: superview.safeAreaLayoutGuide,
            attribute: NSLayoutConstraint.Attribute.height,
            multiplier: aspectRatio.h,
            constant: 0
        ).isActive = true

        return bannerView
    }
}

// MARK: - BannerViewDelegate

extension NativeBannerProgrammaticallyViewController: BannerViewDelegate {

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