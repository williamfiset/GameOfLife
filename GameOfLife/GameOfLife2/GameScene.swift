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

// Gets the current Date in the main loop to track time passed
var pauseDate = NSDate();

var loopPauseInfo = (executePause : false, executionTime : 0.0)

class GameScene : SKScene {
    
    var emptyGridHasBeenDrawn = false;
    var oldTileSize : Int = 0
    
    /* Setup your scene here */
    override func didMoveToView(view: SKView) {
        
        // Is this needed?
        super.didMoveToView(view)
        
        // Define constants
        sceneHeight = Int(self.size.height)
        sceneWidth = Int(self.size.width)
//        println("\nw: \(sceneWidth) h: \(sceneHeight)\n")
        
        verticalTileLimit = 90.0 // hardcoding this is the best option because of different screen sizes
        clickedToChangeMode = false;
        
        // Create background and places buttons on the screen
        self.backgroundColor =  UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 0.75)
        WAFViewHandler.placeMainSceneViews(view , withVerticalLimit: &verticalTileLimit)

        
        let grid = Grid( tileSize : Int(WAFViewHandler.segmentSizeValue()) , scene : self)
        Grid.placeGridOnScreen(self)
        
        oldTileSize = Int(WAFViewHandler.segmentSizeValue())
        
    }
    
    /* Makes the choice of choosing between drawing an empty grid and drawing a randomized grid */
    func drawGrid( #drawRandomGrid : Bool , newTileSize : Int ) -> () {
        
        // draw empty grid
        if ( !drawRandomGrid && (!emptyGridHasBeenDrawn || oldTileSize != newTileSize) ) {

            Grid.createNewGrid(self, emptyGrid: true)
            WAFViewHandler.setPlayModeToStop(true)
            emptyGridHasBeenDrawn = true;
            oldTileSize = newTileSize
            
        // Draw random blocks on the screen
        } else if ( (oldTileSize != newTileSize || Bool(clickedToChangeMode))  && drawRandomGrid ) {
            
            Grid.createNewGrid(self, emptyGrid: false)
            oldTileSize = newTileSize
            emptyGridHasBeenDrawn = false;
            
        }
        
    }
    
    /* Pauses loop speed depending on if the play button is pressed and how long the pause needs to be */
    func pauseLoop () -> () {
        
        // Changes Loop Speed (determined by slider)
        var loopSpeed : Double = loopPauseInfo.executionTime
        let sliderLoopSpeed = WAFViewHandler.segmentLoopSpeed()
        
        // If the execution speed is less than the loopSpeedRate get the difference to find the pause speed,
        // other wise the execution time is the loop pause speed
        if loopPauseInfo.executionTime < sliderLoopSpeed {
            loopSpeed = sliderLoopSpeed - loopPauseInfo.executionTime
        }
        
        let pauseTime = NSTimeInterval( NSNumber(double: loopSpeed  ))
        NSThread.sleepForTimeInterval(pauseTime)
        
        
    }
    
    
    /* Called before each frame is rendered */
    override func update( currentTime: CFTimeInterval) {

        
        let loopPauseTime : Double = WAFViewHandler.segmentLoopSpeed()
        
        
        // If the game is not being paused, do not execute loop body
        if ( NSDate().timeIntervalSinceDate(pauseDate) > loopPauseTime ) {
            
            if (loopPauseInfo.executePause) {
                loopPauseInfo.executePause = false
                pauseLoop()
            }
            
            pauseDate = NSDate()
           
            // Starts timer for loop
            let methodStartTime = NSDate()
            
            
            let newTileSize = (Int(WAFViewHandler.segmentSizeValue()))
            let drawRandomGrid : Bool = WAFViewHandler.randomButtonIsSelected()
            let playButtonSelected : Bool = WAFViewHandler.playButtonIsSelected()
            
            
            drawGrid(drawRandomGrid: drawRandomGrid, newTileSize: newTileSize)
            
            
            // Play Mode is active, time to shuffle critters
            if (playButtonSelected) {
                Grid.applyGameRules()
            }
            
            // Create a new time instance at the current time and compare it to the start of the loop
            loopPauseInfo.executionTime = NSDate().timeIntervalSinceDate(methodStartTime)
            
            if (playButtonSelected) {
                
                loopPauseInfo.executePause = true
//                pauseLoop(loopExecutionTime: executionTime)
            }
            
            clickedToChangeMode = false;
           
        }
    }
}
















































