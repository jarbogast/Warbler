//
//  AppDelegate.swift
//  Warbler
//
//  Created by Jonathan Arbogast on 5/8/17.
//  Copyright © 2017 Jonathan Arbogast. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let iTunesDataSource = ProductionITunesDataSource()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        if let rootViewController = window?.rootViewController {
            handoutModelToViewController(rootViewController)
        }
        return true
    }

    func handoutModelToViewController(_ viewController: UIViewController) {
        var warblerViewController = viewController as? WarblerViewController
        warblerViewController?.iTunesDataSource = iTunesDataSource
        
        for childViewController in viewController.childViewControllers {
            handoutModelToViewController(childViewController)
        }
    }
}

