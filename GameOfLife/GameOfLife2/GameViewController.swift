//
//  GameViewController.swift
//  GameOfLife
//
//  Created by William Fiset on 2014-06-14.
//  Copyright (c) 2014 William Fiset. All rights reserved.
//

import UIKit
import SpriteKit


class GameViewController: UIViewController {
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let skView = self.view as SKView
        //        skView.showsFPS = true
        skView.showsNodeCount = true
        
        let gameScene = GameScene(size: skView.frame.size)
        gameScene.scaleMode = .AspectFill
        println("Size: \(gameScene.size)")
        skView.presentScene(gameScene)
        
       
    }
    
    // Prevent the screen from turning when iPhone is tilted
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    // Hides the status bar at the top of the screen
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> Int {
        
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return Int(UIInterfaceOrientationMask.AllButUpsideDown.toRaw())
        } else {
            return Int(UIInterfaceOrientationMask.All.toRaw())
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
}







