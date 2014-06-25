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
    
    var touchedNodes : Tile[] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        let skView = self.view as SKView
        //        skView.showsFPS = true
        skView.showsNodeCount = true
        
        let gameScene = GameScene(size: skView.frame.size)
        gameScene.scaleMode = .AspectFill
        skView.presentScene(gameScene)
        
       
    }
    
    override func touchesMoved(touches: NSSet!, withEvent event: UIEvent!) {

        // If the game in not running the user may draw
        if !WAFViewHandler.playButtonIsSelected() {
            
            for anObject : AnyObject in touches! {
                if let touch = anObject as? UITouch {
                    
                    // Gets the correct touch position by flipping the Y-Axis
                    var touchLocation = touch.locationInView(self.view)
                    touchLocation.y = self.view.frame.size.height - touchLocation.y
                    
                    
                    // Swaps Tile color of the tile that was touched
                    if let node : Tile = Grid.getNode(touchLocation) {
                        
                        if !node.touched{
                            node.swapColor()
                            node.touched = true
                            touchedNodes.append(node)
                        }
                    }
                }
            }
        }
    }
    
    override func touchesEnded(touches: NSSet!, withEvent event: UIEvent!)  {

        // Reset all posibility for a block to be converted
        for touchedNode in touchedNodes {
            touchedNode.touched = false
        }
        
        if touchedNodes.count == 0 && !WAFViewHandler.playButtonIsSelected(){

            for anObject : AnyObject in touches! {
                if let touch = anObject as? UITouch {
                    
                    // Gets the correct touch position by flipping the Y-Axis
                    var touchLocation = touch.locationInView(self.view)
                    touchLocation.y = self.view.frame.size.height - touchLocation.y
                    
                    // Swaps Tile color of the tile that was touched
                    if let node : Tile = Grid.getNode(touchLocation) {
                        node.swapColor()
                    }
                    
                }
            }
        }
        
        // Empty touched nodes
        touchedNodes = []
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







