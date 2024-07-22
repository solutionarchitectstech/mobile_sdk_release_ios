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

class MainViewController: UIViewController {

    @IBOutlet weak var customContainer: UIView!

    @IBOutlet weak var rtbContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initMenu()
    }

    override func viewWillAppear(_ animated: Bool) {
        refreshTitle()
        refreshContent()
    }

    private func initMenu() {
        let actionSettings = UIAction(title: "Settings") { _ in
            self.showSettings()
        }
        let menu = UIMenu(title: "", children: [actionSettings])
        let menuButton = UIBarButtonItem(
            title: nil,
            image: UIImage(systemName: "ellipsis.circle"),
            primaryAction: nil,
            menu: menu
        )
        self.navigationItem.rightBarButtonItem = menuButton
    }

    private func refreshTitle() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        var isMock = false
        if case .MOCK(_) = appDelegate.appSettings.initConfigSettings {
            isMock = true
        }

        var description: String?
        switch TechAdvertising.shared.options?.transactionProtocol {
        case .CUSTOM:
            description = "SA CUSTOM (\(isMock ? "mock" : "real"))"
        case .OPEN_RTB(_, _, _, _):
            description = "OpenRTB (\(isMock ? "mock" : "real"))"
        case .none:
            break
        }

        self.navigationItem.title = description
    }

    private func refreshContent() {
        switch TechAdvertising.shared.options?.transactionProtocol {
        case .CUSTOM:
            customContainer.isHidden = false
            rtbContainer.isHidden = true
        case .OPEN_RTB(_, _, _, _):
            customContainer.isHidden = true
            rtbContainer.isHidden = false
        case .none:
            break
        }
    }

    private func showSettings() {
        presentViewControllerBy(name: "SettingsViewController")
    }

    private func presentViewControllerBy(name: String) {
        let storyBoard: UIStoryboard = UIStoryboard(name: name, bundle: nil)
        let vc = storyBoard.instantiateInitialViewController()
        guard let vc = vc else {
            return
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }

    // MARK: - SINGLE IMPRESSION

    @IBAction func onSingleInlayoutCreativeClick(_ sender: Any) {
        presentViewControllerBy(name: "SingleInlayoutCreativeViewController")
    }

    @IBAction func onSingleProgrammaticallyCreativeClick(_ sender: Any) {
        presentViewControllerBy(name: "SingleProgrammaticallyCreativeViewController")
    }

    @IBAction func onSingleCollectionCreativeClick(_ sender: Any) {
        presentViewControllerBy(name: "SingleCollectionCreativeViewController")
    }

    @IBAction func onSingleFullscreenCreativeClick(_ sender: Any) {
        presentViewControllerBy(name: "SingleFullscreenCreativeViewController")
    }

    @IBAction func onSingleProductCreativeClick(_ sender: Any) {
        presentViewControllerBy(name: "SingleProductCreativeViewController")
    }

    // MARK: - MULTIPLE IMPRESSIONS

    @IBAction func onMultiCreativeClick(_ sender: Any) {
        presentViewControllerBy(name: "MultiCreativeViewController")
    }

    @IBAction func onMultiProductCreativeClick(_ sender: Any) {
        presentViewControllerBy(name: "MultiProductCreativeViewController")
    }

    // MARK: - MEDIA

    @IBAction func onMediaCreativeClick(_ sender: Any) {
        presentViewControllerBy(name: "MediaCreativeViewController")
    }

    // MARK: - OPEN RTB

    @IBAction func onRTBBannerCreativeClick(_ sender: Any) {
        presentViewControllerBy(name: "RTBBannerCreativeViewController")
    }

    @IBAction func onRTBMediaCreativeClick(_ sender: Any) {
        presentViewControllerBy(name: "RTBMediaCreativeViewController")
    }

    @IBAction func onRTBCollectionCreativeClick(_ sender: Any) {
        presentViewControllerBy(name: "RTBCollectionCreativeViewController")
    }
}
