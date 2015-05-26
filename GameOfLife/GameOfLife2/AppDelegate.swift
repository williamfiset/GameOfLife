//
//  AppDelegate.swift
//  GameOfLife2
//
//  Created by William Fiset on 2014-06-17.
//  Copyright (c) 2014 William Fiset. All rights reserved.
//

import UIKit
import SpriteKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
                            
    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {

        
        let IS_IPHONE4 = (UIScreen.mainScreen().bounds.width == 320 && UIScreen.mainScreen().bounds.height == 480)
        let IS_IPHONE5 = (UIScreen.mainScreen().bounds.width == 320 && UIScreen.mainScreen().bounds.height == 568)
        let IS_IPHONE6 = (UIScreen.mainScreen().bounds.width == 375 && UIScreen.mainScreen().bounds.height == 667)
        let IS_IPHONE6_PLUS = (UIScreen.mainScreen().bounds.width == 414 && UIScreen.mainScreen().bounds.height == 736)
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds )
        var viewController : GameViewController? = nil;
        
        // Selects a xib file to start with
        // Doesn't seem to execute IS_IPHONE6 or IS_IPHONE6_PLUS (is this still true??)
        if IS_IPHONE4 {
            viewController = GameViewController(nibName: "GameViewController_iphone4", bundle: nil)
            
        } else if IS_IPHONE5 {
            viewController = GameViewController(nibName: "GameViewController_iphone5", bundle: nil)
        
        } else if IS_IPHONE6 {
            viewController = GameViewController(nibName: "GameViewController_iphone6", bundle: nil)
            
        } else if IS_IPHONE6_PLUS {
            viewController = GameViewController(nibName: "GameViewController_iphone6+", bundle: nil)
            
        } else {
             viewController = GameViewController(nibName: "GameViewController_ipad", bundle: nil)
        }

        
        window!.rootViewController = viewController;
        window!.makeKeyAndVisible()

        
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

