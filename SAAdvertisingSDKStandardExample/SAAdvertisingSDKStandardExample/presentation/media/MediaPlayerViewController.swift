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

class MediaPlayerViewController: UIViewController {
    
    @IBOutlet weak var mediaPlayerView: MediaPlayerView!

    private var mediaCreative: MediaCreative!

    public override func viewDidLoad() {
        super.viewDidLoad()

        TechAdvertising.shared.uid = "MY_AUTHORIZED_USER_ID"

        mediaPlayerView.query = MediaCreativeQuery(
            placementId: "YOUR_PLACEMENT_ID",
            sizes: [SizeEntity(width: 260, height: 106)],
            floorPrice: 1.99,
            currency: "USD",
            customParams: [:]
        )

        // Let's init MediaCreative
        self.mediaCreative = .init(
            mediaView: mediaPlayerView,
            refresh: true
        )
        self.mediaCreative.delegate = self

        // Finally, let's load media creatives
        self.mediaCreative.load()
    }
}

extension MediaPlayerViewController: MediaCreativeDelegate {

    func onLoadDataSuccess(mediaView: MediaPlayerView) {
        let placementId = mediaView.query?.placementId
        print("Media.onLoadDataSuccess[\(String(describing: placementId))]")
    }

    func onLoadDataFail(mediaView: MediaPlayerView, error: Error) {
        let placementId = mediaView.query?.placementId
        print("Media.onLoadDataFail[\(String(describing: placementId))]: \(error.localizedDescription)")
    }

    func onLoadContentSuccess(mediaView: MediaPlayerView) {
        let placementId = mediaView.query?.placementId
        print("Media.onLoadContentSuccess[\(String(describing: placementId))]")
    }

    func onLoadContentFail(mediaView: MediaPlayerView, error: Error) {
        let placementId = mediaView.query?.placementId
        print("Media.onLoadContentFail[\(String(describing: placementId))]: \(error.localizedDescription)")
    }

    func onNoAdContent(mediaView: MediaPlayerView) {
        let placementId = mediaView.query?.placementId
        print("Media.onNoAdContent[\(String(describing: placementId))]")
    }

    func onTap(mediaView: MediaPlayerView, redirectUrl: URL?) {
        let placementId = mediaView.query?.placementId
        print("Media.onTap[\(String(describing: placementId))]: \(String(describing: redirectUrl))")
    }

    func onClose(mediaView: MediaPlayerView) {
        let placementId = mediaView.query?.placementId
        print("Media.onClose[\(String(describing: placementId))]")
    }
}

