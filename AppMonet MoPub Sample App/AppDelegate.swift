//
//  AppDelegate.swift
//  AppMonet MoPub Sample App
//
//  Created by Jose Portocarrero on 3/11/20.
//  Copyright © 2020 Monet. All rights reserved.
//

import UIKit
import CoreData
import MoPub
import AppMonet_Mopub

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let sdkConfig = MPMoPubConfiguration(adUnitIdForAppInitialization: "b03e6dccfe9e4abab02470a39c88d5dc")
        MoPub.sharedInstance().initializeSdk(with: sdkConfig) {
            NSLog("SDK initialization complete")
        }

        //AppMonet Setup
        let appMonetConfiguration = AppMonetConfigurations.configuration { (AppMonetConfigurations) in
            AppMonetConfigurations?.applicationId = "3zeuyua"
        }
        AppMonet.initialize(appMonetConfiguration)

        //Use this only during testing in order to get test ads.
        AppMonet.testMode()
        return true
    }
}

