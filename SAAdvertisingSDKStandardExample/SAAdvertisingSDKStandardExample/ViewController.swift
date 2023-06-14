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

    // MARK: - SINGLE IMPRESSION

    @IBAction func onSingleInlayoutWebBannerClick(_ sender: Any) {
        presentViewControllerBy(name: "SingleInlayoutWebBannerViewController")
    }

    @IBAction func onSingleInlayoutNativeBannerClick(_ sender: Any) {
        presentViewControllerBy(name: "SingleInlayoutNativeBannerViewController")
    }

    @IBAction func onSingleProgrammaticallyWebBannerClick(_ sender: Any) {
        presentViewControllerBy(name: "SingleProgrammaticallyWebBannerViewController")
    }

    @IBAction func onSingleProgrammaticallyNativeBannerClick(_ sender: Any) {
        presentViewControllerBy(name: "SingleProgrammaticallyNativeBannerViewController")
    }

    @IBAction func onSingleCollectionWebBannerClick(_ sender: Any) {
        presentViewControllerBy(name: "SingleCollectionWebBannerViewController")
    }

    @IBAction func onSingleCollectionNativeBannerClick(_ sender: Any) {
        presentViewControllerBy(name: "SingleCollectionNativeBannerViewController")
    }

    @IBAction func onSingleProductCreativeClick(_ sender: Any) {
        presentViewControllerBy(name: "SingleProductCreativeViewController")
    }

    // MARK: - MULTIPLE IMPRESSIONS

    @IBAction func onMultiWebBannerClick(_ sender: Any) {
        presentViewControllerBy(name: "MultiWebBannerViewController")
    }

    @IBAction func onMultiNativeBannerClick(_ sender: Any) {
        presentViewControllerBy(name: "MultiNativeBannerViewController")
    }

    @IBAction func onMultiProductCreativeClick(_ sender: Any) {
        presentViewControllerBy(name: "MultiProductCreativeViewController")
    }

    // MARK: - MEDIA

    @IBAction func onVideoPlayerClick(_ sender: Any) {
        presentViewControllerBy(name: "VideoPlayerViewController")
    }
}
