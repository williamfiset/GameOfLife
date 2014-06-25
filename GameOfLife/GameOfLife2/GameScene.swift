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
    
    
    var oldTileSize : Int = 0
    
    /* Setup your scene here */
    override func didMoveToView(view: SKView) {
        
        // Is this needed?
        super.didMoveToView(view)
        
        // Define constants
        sceneHeight = Int(self.size.height)
        sceneWidth = Int(self.size.width)
        verticalTileLimit = 90.0 // hardcoding this is the best option because of different screen sizes
        currentlyOnEmptyGrid = false;
        
        
        // Create background and places buttons on the screen
        self.backgroundColor = UIColor(red: 122/255.0, green: 122/255.0, blue: 122/255.0, alpha: 1)
        WAFViewHandler.placeMainSceneViews(view)

        let grid = Grid( tileSize : Int(WAFViewHandler.segmentSizeValue()) , scene : self)
        Grid.placeGridOnScreen(self)
        
        oldTileSize = Int(WAFViewHandler.segmentSizeValue())
        
    }
    
    
    /* Called before each frame is rendered */
    override func update( currentTime: CFTimeInterval) {

        
        
        // Starts timer for loop
        let methodStart = NSDate()
        let newTileSize = (Int(WAFViewHandler.segmentSizeValue()))
        let drawRandomizedGrid : Bool = WAFViewHandler.randomGridIsSelected()
        let playButtonSelected : Bool = WAFViewHandler.isStartButtonSelected()

        
        if (drawRandomizedGrid) {
            currentlyOnEmptyGrid = false;
        }
        
        // Change the tileSize every difference of four pixels
        if (oldTileSize != newTileSize) {
            
            Grid.createNewGrid(self)
            oldTileSize = newTileSize
        
            
        // Grid needs to be white
        } else if ( !drawRandomizedGrid && !Bool(currentlyOnEmptyGrid) ) { // and not currently on empty grid
            
            Grid.makeWhiteGrid()
            WAFViewHandler.setPlayModeToStop(true)
            currentlyOnEmptyGrid = true;

        }
        


        
        // Play Mode is active, time to shuffle critters
        if (playButtonSelected) {
            Grid.applyGameRules()
        }
        
        
        // Stop timer for loop to
        let methodFinish = NSDate()
        let execuationTime : Double = methodFinish.timeIntervalSinceDate(methodStart)
        
        
        
        
        if (playButtonSelected) { //  && Bool(justChangedTileSize)

            // Changes Loop Speed (determined by slider)
            
            var loopSpeed : Double = execuationTime
            let sliderLoopSpeed = WAFViewHandler.segmentLoopSpeed()
            
            // If the execution speed is less than the loopSpeedRate get the difference to find the pause speed,
            // other wise the execution time is the loop pause speed
            if execuationTime < sliderLoopSpeed {
                loopSpeed = sliderLoopSpeed - execuationTime
            }

            let pauseTime = NSTimeInterval( NSNumber(double: loopSpeed  ))
            NSThread.sleepForTimeInterval(pauseTime)
            
        } else {
            justChangedTileSize = false
        }
        
        
        
    }
}
















































