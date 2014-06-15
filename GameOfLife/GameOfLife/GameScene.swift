//
//  GameScene.swift
//  GameOfLife
//
//  Created by William Fiset on 2014-06-14.
//  Copyright (c) 2014 William Fiset. All rights reserved.
//

import SpriteKit
import UIKit

class GameScene : SKScene {
    
    /* Setup your scene here */
    override func didMoveToView(view: SKView) {
        
        self.backgroundColor = UIColor.whiteColor()
        
        WAFViewPlacer.placeMainSceneViews(self.view)
        
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch : AnyObject in touches {
            
        }
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
