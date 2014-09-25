//
//  AppDelegate.swift
//  GameOfLife2
//
//  Created by William Fiset on 2014-06-17.
//  Copyright (c) 2014 William Fiset. All rights reserved.
//

import UIKit
import SpriteKit

//#define IS_IPHONE       UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad
//#define IS_IPHONE4      ([[UIScreen mainScreen] bounds].size.width == 320 && [[UIScreen mainScreen] bounds].size.height == 480)
//#define IS_IPHONE5      ([[UIScreen mainScreen] bounds].size.width == 320 && [[UIScreen mainScreen] bounds].size.height == 568)
//#define IS_IPHONE6      ([[UIScreen mainScreen] bounds].size.width == 375 && [[UIScreen mainScreen] bounds].size.height == 667)
//#define IS_IPHONE6_PLUS ([[UIScreen mainScreen] bounds].size.width == 414 && [[UIScreen mainScreen] bounds].size.height == 736)
//#define IS_IPAD         UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad
//

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
                            
    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: NSDictionary?) -> Bool {
        
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds )
        
        let viewController = GameViewController(nibName: "GameViewController_ipad", bundle: nil)
        window!.rootViewController = viewController;
//        window!.hidden = false;

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

