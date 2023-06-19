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

class SingleProgrammaticallyNativeBannerViewController: UIViewController {

    private var bannerCreative: BannerCreative<NativeBannerView>!

    override func viewDidLoad() {
        super.viewDidLoad()

        TechAdvertising.shared.uid = "MY_AUTHORIZED_USER_ID"

        // Let's init banner views
        let mainScreenScale = UIScreen.main.scale

        let bannerView = addBannerView(
            to: view,
            position: (h: .leading, v: .top),
            aspectRatio: (w: 1 / 1, h: 1 / 1) // (w: 2 / 3, h: 1 / 6)
        )
        bannerView.backgroundColor = .white
        let pxBanner1Width = Int(bannerView.frame.size.width * mainScreenScale)
        let pxBanner1Height = Int(bannerView.frame.size.height * mainScreenScale)
        bannerView.query = BannerCreativeQuery(
            placementId: "YOUR_PLACEMENT_ID",
            closeButtonType: .COUNTDOWN(timeout: 5.0),
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

        // Let's init BannerCreative
        self.bannerCreative = .init(
            bannerView: bannerView,
            refresh: 10.0
        )
        self.bannerCreative.delegate = self

        // Finally, let's load banner creatives
        self.bannerCreative.load()
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

// MARK: - BannerCreativeDelegate

extension SingleProgrammaticallyNativeBannerViewController: BannerCreativeDelegate {

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
