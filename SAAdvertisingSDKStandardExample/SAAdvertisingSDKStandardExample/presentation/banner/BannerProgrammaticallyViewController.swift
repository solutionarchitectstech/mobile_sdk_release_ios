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

class BannerProgrammaticallyViewController: UIViewController {

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
            placementId: "Banner-1 \(pxBanner1Width)x\(pxBanner1Height) (custom params) 1.99 USD",
            closeButtonType: .NONE,
            sizes: [SSPSizeEntity(width: pxBanner1Width, height: pxBanner1Height)],
            floorPrice: 1.99,
            currency: "USD",
            customParams: [
                "skuId": "LG00001",
                "skuName": "Leggo bricks (speed boat)",
                "category": "Kids",
                "subСategory": "Lego"
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
            placementId: "33d1ca62-c186-4c93-8206-5e26d996f353",
            closeButtonType: .VISIBLE,
            sizes: [
                SSPSizeEntity(width: 260, height: 106),
                SSPSizeEntity(width: pxBanner2Width, height: pxBanner2Height)
            ],
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
        bannerView3.isScrollEnabled = true
        bannerView3.scaleToFit = false
        bannerView3.loadData(query: SSPAdvertisementQuery(
            placementId: "33d1ca62-c186-4c93-8206-5e26d996f353",
            closeButtonType: .APPEARING(timeout: 5.0),
            sizes: [
                SSPSizeEntity(width: 260, height: 106)
            ]
        ))

        let bannerView4 = addBannerView(
            to: view,
            position: (h: .trailing, v: .bottom),
            aspectRatio: (w: 2 / 3, h: 1 / 6)
        )
        bannerView4.backgroundColor = .white
        bannerView4.delegate = self
        bannerView4.isScrollEnabled = true
        bannerView4.scaleToFit = false
        bannerView4.loadData(query: SSPAdvertisementQuery(
            placementId: "33d1ca62-c186-4c93-8206-5e26d996f353",
            closeButtonType: .COUNTDOWN(timeout: 5.0),
            sizes: [
                SSPSizeEntity(width: 260, height: 106)
            ]
        ))
    }

    private func addBannerView(
        to superview: UIView,
        position: (h: NSLayoutConstraint.Attribute, v: NSLayoutConstraint.Attribute),
        aspectRatio: (w: CGFloat, h: CGFloat)
    ) -> BannerView {
        // You can also use BannerView(frame: CGRect) constructor to instantiate the view
        // with initial size/position.
        // let bannerView = BannerView(frame: CGRect(x: 0, y: 0, width: 640, height: 480))
        let bannerView = BannerView()

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

extension BannerProgrammaticallyViewController: BannerViewDelegate {

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
