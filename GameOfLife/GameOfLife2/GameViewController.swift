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
//        skView.showsNodeCount = true
        
        let gameScene = GameScene(size: skView.frame.size)
        gameScene.scaleMode = .AspectFill
        skView.presentScene(gameScene)
        
       
    }

    override func touchesEnded(touches: NSSet!, withEvent event: UIEvent!) {
        
        for anObject : AnyObject in touches! {
            
            if let touch = anObject as? UITouch {
                
                var touchLocation = touch.locationInView(self.view)
                touchLocation.y = self.view.frame.size.height - touchLocation.y
                
                if let node = Grid.getNode(touchLocation) {
                    print("\nColor: \(node.color) \n Black: \(UIColor.blackColor()) \n White: \(UIColor.whiteColor())\n")
                    if Grid.isAlive(node) {
                        node.color = UIColor.whiteColor()
                        println("White?")
                    }else{
                        node.color = UIColor.blackColor()
                        println("Black")
                    }
                    
                }
            }
        }
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







