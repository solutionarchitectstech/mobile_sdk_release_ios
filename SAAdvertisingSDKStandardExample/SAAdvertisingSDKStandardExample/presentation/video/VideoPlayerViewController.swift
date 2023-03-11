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

class VideoPlayerViewController: UIViewController {
    
    @IBOutlet weak var videoPlayerView: VideoPlayerView!

    public override func viewDidLoad() {
        super.viewDidLoad()

        videoPlayerView.delegate = self
        videoPlayerView.loadData(placementId: "TestVideo")
    }
}

extension VideoPlayerViewController: PlayerViewDelegate {
    func onLoadDataSuccess(placementId: String) {
        print("VideoPlayer.onLoadDataSuccess[\(placementId)]")
    }
    
    func onLoadDataFail(placementId: String, error: Error) {
        print("VideoPlayer.onLoadDataFail[\(placementId)]: \(error.localizedDescription)")
    }
    
    func onLoadContentSuccess(placementId: String) {
        print("VideoPlayer.onLoadContentSuccess[\(placementId)]")
    }
    
    func onLoadContentFail(placementId: String, error: Error) {
        print("VideoPlayer.onLoadContentFail[\(placementId)]: \(error.localizedDescription)")
    }
    
    func onClose(placementId: String) {
        print("VideoPlayer.onClose[\(placementId)]")
    }
}

