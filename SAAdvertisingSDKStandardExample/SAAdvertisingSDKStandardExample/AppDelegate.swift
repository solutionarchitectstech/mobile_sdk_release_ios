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

func log(_ msg: String, display: Bool = true) {
    print(msg)
    if display {
        Toast(text: msg).show()
    }
}

func showMessage(_ msg: String, in label: UILabel, for creativeView: CreativeView, withColor color: UIColor? = nil) {
    hideMessage(in: label)

    label.text = msg
    label.textColor = color
    label.textAlignment = .center
    label.numberOfLines = 0

    creativeView.addSubview(label)

    label.translatesAutoresizingMaskIntoConstraints = false
    label.leadingAnchor.constraint(equalTo: creativeView.leadingAnchor, constant: 0).isActive = true
    label.trailingAnchor.constraint(equalTo: creativeView.trailingAnchor, constant: 0).isActive = true
    label.topAnchor.constraint(equalTo: creativeView.topAnchor, constant: 0).isActive = true
    label.bottomAnchor.constraint(equalTo: creativeView.bottomAnchor, constant: 0).isActive = true

    // Here is the trick to store visibility state of creativeView
    // We temporarily store it in the `textView.tag` to restore it later
    // in the `hideMessage()` (see below).
    label.tag = creativeView.isHidden ? 1 : 0
    creativeView.isHidden = false
}

func hideMessage(in label: UILabel) {
    label.text = nil
    label.textColor = nil

    let isHidden = label.tag > 0 ? true : false
    label.superview?.isHidden = isHidden
    label.tag = 0

    label.removeFromSuperview()
}

struct AppSettings {

    var transactionProtocol: TransactionProtocol = .CUSTOM
    
    var initConfigCore: InitConfigCoreEntity {
        switch initConfigSettings {
        case .MOCK(let initConfigCore):
            return initConfigCore
        case .REAL(let initConfigCore):
            return initConfigCore
        }
    }
    
    var initConfigSettings: InitConfigSettings = .MOCK()

    enum InitConfigSettings {
        case MOCK(
            initConfigCore: InitConfigCoreEntity = .init(
                bannerUrl: "https://YOUR_MOCK_BANNER_ENDPOINT",
                productUrl: "https://YOUR_MOCK_PRODUCT_ENDPOINT"
            )

        )

        case REAL(
            initConfigCore: InitConfigCoreEntity = .init(
                bannerUrl: "https://YOUR_REAL_BANNER_ENDPOINT", // ?debug=978617222
                productUrl: "https://YOUR_REAL_PRODUCT_ENDPOINT"
            )
        )
    }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var appSettings = AppSettings() {
        didSet {
            initSdk()
        }
    }

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        initSdk()

        // Override point for customization after application launch.
        return true
    }

    func initSdk() {
        TechAdvertising.initialize(options: TechAdvertisingOptions(
            storeUrl: "https://apps.apple.com/us/app/myapp/id12345678",
            transactionProtocol: appSettings.transactionProtocol,
            initConfig: .init(core: appSettings.initConfigCore),
            debugMode: true,
            httpHeaders: [
                "Authorization": "Bearer YOUR_TOKEN",
                "User-Agent": "YOUR_CUSTOM_USER_AGENT"
            ]
        ))
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}
