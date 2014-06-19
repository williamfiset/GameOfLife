//
//  GameScene.swift
//  GameOfLife
//
//  Created by William Fiset on 2014-06-14.
//  Copyright (c) 2014 William Fiset. All rights reserved.
//

import SpriteKit
import CoreGraphics
import Foundation


var sceneHeight : Int = 0
var sceneWidth : Int = 0
var verticalTileLimit : Float = 0.0

let screenHeight = 1136
let screenWidth = 640


class GameScene : SKScene {
    
    var oldSizeSliderValue : Int = 0
    
    /* Setup your scene here */
    override func didMoveToView(view: SKView) {
        
        // Is this needed?
        super.didMoveToView(view)
        
        // Define constants
        sceneHeight = Int(self.size.height)
        sceneWidth = Int(self.size.width)
        verticalTileLimit = 90.0 // hardcoding this is the best option because of different screen sizes
        
        // Create background and places buttons on the screen
        self.backgroundColor = UIColor(red: 122/255.0, green: 122/255.0, blue: 122/255.0, alpha: 1)
        WAFViewPlacer.placeMainSceneViews(view)

        let grid = Grid( tileSize : Int(WAFViewPlacer.segmentSizeValue()) , scene : self)
        Grid.placeGridOnScreen(self)
        
        oldSizeSliderValue = Int(WAFViewPlacer.segmentSizeValue())

        
    }
    
    /* Called before each frame is rendered */
    override func update(currentTime: CFTimeInterval) {

        let newSizeSliderValue = (Int(WAFViewPlacer.segmentSizeValue()) / 4 ) * 4
        
        // Change the tileSize every difference of four pixels
        if (newSizeSliderValue % 4 == 0 && oldSizeSliderValue != newSizeSliderValue) {
            
            Grid.emptyGrid()
            Grid(tileSize: Int(WAFViewPlacer.segmentSizeValue()) , scene : self)
            Grid.placeGridOnScreen(self)
            oldSizeSliderValue = newSizeSliderValue
            
        }
        
        if (WAFViewPlacer.isStartButtonSelected()){

            // Changes Loop Speed (determined by slider)
            let pauseTime = NSTimeInterval(NSNumber(double: WAFViewPlacer.segmentLoopSpeed()))
            NSThread.sleepForTimeInterval(pauseTime)
            
        }
        
    }
}












