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

import Foundation
import UIKit
import SAAdvertisingSDKStandard

class MediaCreativeViewController: UIViewController {
    
    @IBOutlet weak var creativeView: CreativeView!

    private var creative: Creative!

    public override func viewDidLoad() {
        super.viewDidLoad()

        TechAdvertising.shared.uid = "MY_AUTHORIZED_USER_ID"

        creativeView.query = CreativeQuery(
            placementId: "YOUR_PLACEMENT_ID",
            sizes: [SizeEntity(width: 260, height: 106)],
            floorPrice: 1.99,
            currency: "USD",
            customParams: [:]
        )

        // Let's init MediaCreative
        self.creative = .init(creativeView: creativeView)
        self.creative.delegate = self

        // Finally, let's load media creatives
        self.creative.load()
    }
}

// MARK: - CreativeDelegate

extension MediaCreativeViewController: CreativeDelegate {

    public func onLoadDataSuccess(creativeView: CreativeView) {
        let placementId = creativeView.query?.placementId
        print("Creative.onLoadDataSuccess[\(String(describing: placementId))]")
    }

    public func onLoadDataFail(creativeView: CreativeView, error: Error) {
        let placementId = creativeView.query?.placementId
        print("Creative.onLoadDataFail[\(String(describing: placementId))]: \(error.localizedDescription)")
    }

    public func onLoadContentSuccess(creativeView: CreativeView) {
        let placementId = creativeView.query?.placementId
        print("Creative.onLoadContentSuccess[\(String(describing: placementId))]")
    }

    public func onLoadContentFail(creativeView: CreativeView, error: Error) {
        let placementId = creativeView.query?.placementId
        print("Creative.onLoadContentFail[\(String(describing: placementId))]: \(error.localizedDescription)")
    }

    public func onNoAdContent(creativeView: CreativeView) {
        let placementId = creativeView.query?.placementId
        print("Creative.onNoAdContent[\(String(describing: placementId))]")
    }

    public func onClose(creativeView: CreativeView) {
        let placementId = creativeView.query?.placementId
        print("Creative.onClose[\(String(describing: placementId))]")
    }
}
