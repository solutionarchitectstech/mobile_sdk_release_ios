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

class SingleProgrammaticallyCreativeViewController: UIViewController {

    private let errorLabel = UILabel()

    private var creative: Creative!

    private let placementIds = ["HTML_BANNER", "IMAGE_BANNER"]

    override func viewDidLoad() {
        super.viewDidLoad()

        TechAdvertising.shared.uid = "MY_AUTHORIZED_USER_ID"

        // Let's init creative views
        let creativeView = addCreativeView(
            to: view,
            position: (h: .leading, v: .top),
            aspectRatio: (w: 1 / 1, h: 1 / 1) // (w: 2 / 3, h: 1 / 6)
        )

        let mainScreenScale = UIScreen.main.scale
        let pxCreativeWidth = Int(creativeView.frame.size.width * mainScreenScale)
        let pxCreativeHeight = Int(creativeView.frame.size.height * mainScreenScale)
        creativeView.query = CreativeQuery(
            placementId: placementIds.randomElement() ?? "",
            sizes: [
                SizeEntity(width: 260, height: 106),
                SizeEntity(width: pxCreativeWidth, height: pxCreativeHeight)
            ],
            floorPrice: 1.99,
            currency: "USD",
            customParams: [
                "skuId": "LG00001",
                "skuName": "Lego bricks (speed boat)",
                "category": "Kids",
                "subCategory": "Lego"
            ]
        )

        // Let's init Creative
        self.creative = .init(creativeView: creativeView)
        self.creative.delegate = self

        // Finally, let's load creative
        self.creative.load()
    }

    private func addCreativeView(
        to superview: UIView,
        position: (h: NSLayoutConstraint.Attribute, v: NSLayoutConstraint.Attribute),
        aspectRatio: (w: CGFloat, h: CGFloat)
    ) -> CreativeView {
        // You can also use CreativeView(frame: CGRect) constructor to instantiate the view
        // with initial size/position.
        // let creativeView = CreativeView(frame: CGRect(x: 0, y: 0, width: 640, height: 480))
        let creativeView = CreativeView()

        superview.addSubview(creativeView)

        creativeView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint(
            item: creativeView,
            attribute: position.v,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: superview.safeAreaLayoutGuide,
            attribute: position.v,
            multiplier: 1,
            constant: 0
        ).isActive = true

        NSLayoutConstraint(
            item: creativeView,
            attribute: position.h,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: superview.safeAreaLayoutGuide,
            attribute: position.h,
            multiplier: 1,
            constant: 0
        ).isActive = true

        NSLayoutConstraint(
            item: creativeView,
            attribute: NSLayoutConstraint.Attribute.width,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: superview.safeAreaLayoutGuide,
            attribute: NSLayoutConstraint.Attribute.width,
            multiplier: aspectRatio.w,
            constant: 0
        ).isActive = true

        NSLayoutConstraint(
            item: creativeView,
            attribute: NSLayoutConstraint.Attribute.height,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: superview.safeAreaLayoutGuide,
            attribute: NSLayoutConstraint.Attribute.height,
            multiplier: aspectRatio.h,
            constant: 0
        ).isActive = true

        return creativeView
    }
}

// MARK: - CreativeDelegate

extension SingleProgrammaticallyCreativeViewController: CreativeDelegate {

    public func onLoadDataSuccess(creativeView: CreativeView) {
        let placementId = creativeView.query?.placementId
        log("onLoadDataSuccess[\(placementId ?? "")]")

        hideMessage(in: errorLabel)
    }

    public func onLoadDataFail(creativeView: CreativeView, error: Error) {
        let placementId = creativeView.query?.placementId
        let msg = "onLoadDataFail[\(placementId ?? "")]: \(error.localizedDescription)"
        log(msg)

        showMessage(msg, in: errorLabel, for: creativeView, withColor: .red)
    }

    public func onLoadContentSuccess(creativeView: CreativeView) {
        let placementId = creativeView.query?.placementId
        log("onLoadContentSuccess[\(placementId ?? "")]")

        hideMessage(in: errorLabel)
    }

    public func onLoadContentFail(creativeView: CreativeView, error: Error) {
        let placementId = creativeView.query?.placementId
        let msg = "onLoadContentFail[\(placementId ?? "")]: \(error.localizedDescription)"
        log(msg)

        showMessage(msg, in: errorLabel, for: creativeView, withColor: .red)
    }

    public func onNoAdContent(creativeView: CreativeView) {
        let placementId = creativeView.query?.placementId
        let msg = "onNoAdContent[\(placementId ?? "")]"
        log(msg)

        showMessage(msg, in: errorLabel, for: creativeView, withColor: .red)
    }

    public func onClose(creativeView: CreativeView) {
        let placementId = creativeView.query?.placementId
        log("onClose[\(placementId ?? "")]")

        hideMessage(in: errorLabel)
    }
}
