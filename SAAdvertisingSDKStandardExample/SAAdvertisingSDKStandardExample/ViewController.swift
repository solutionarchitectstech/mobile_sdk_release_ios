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

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    private func presentViewControllerBy(name: String){
        let storyBoard: UIStoryboard = UIStoryboard(name: name, bundle: nil)
        let vc = storyBoard.instantiateInitialViewController()
        guard let vc = vc else {
            return
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func onBannerStoryboardClick(_ sender: Any) {
        presentViewControllerBy(name: "BannerStoryboardViewController")
    }

    @IBAction func onBannerProgrammaticallyClick(_ sender: Any) {
        presentViewControllerBy(name: "BannerProgrammaticallyViewController")
    }

    @IBAction func onFullScreenClick(_ sender: Any) {
        presentViewControllerBy(name: "FullscreenViewController")
    }

    @IBAction func onBannerScrollableListClick(_ sender: Any) {
        presentViewControllerBy(name: "BannerScrollableListViewController")
    }

    @IBAction func onNativeBannerStoryboardClick(_ sender: Any) {
        presentViewControllerBy(name: "NativeBannerStoryboardViewController")
    }

    @IBAction func onNativeBannerProgrammaticallyClick(_ sender: Any) {
        presentViewControllerBy(name: "NativeBannerProgrammaticallyViewController")
    }

    @IBAction func onNativeFullScreenClick(_ sender: Any) {
        presentViewControllerBy(name: "NativeFullscreenViewController")
    }

    @IBAction func onNativeBannerScrollableListClick(_ sender: Any) {
        presentViewControllerBy(name: "NativeBannerScrollableListViewController")
    }

    @IBAction func onVideoPlayerClick(_ sender: Any) {
        presentViewControllerBy(name: "VideoPlayerViewController")
    }

    @IBAction func onProductCreativeClick(_ sender: Any) {
        presentViewControllerBy(name: "ProductCreativeViewController")
    }
}
