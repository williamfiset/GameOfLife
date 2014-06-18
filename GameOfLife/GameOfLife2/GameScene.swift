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
        
        // Define constants
        sceneHeight = Int(self.size.height)
        sceneWidth = Int(self.size.width)
        verticalTileLimit = Float(sceneHeight) * 0.20

        
        self.backgroundColor = UIColor.grayColor()
        WAFViewPlacer.placeMainSceneViews(view)

        let grid = Grid( tileSize : Int(sizeSlider.value) , scene : self)
        Grid.placeGridOnScreen(self)
        
        oldSizeSliderValue = 10
        
        // temporary red bar
        let redBar = SKSpriteNode(color: UIColor.redColor(), size: CGSize(width: screenWidth, height: 2))
        redBar.position = CGPoint(x: 0.0, y: verticalTileLimit )
        self.addChild(redBar)
        
    }
    
    /* Called before each frame is rendered */
    override func update(currentTime: CFTimeInterval) {
        
        // Loop Speed (determined by slider)
        NSThread.sleepForTimeInterval(0.1)
        
        let newSizeSliderValue = Int(sizeSlider.value)
        

        if newSizeSliderValue < oldSizeSliderValue - 2 || newSizeSliderValue > oldSizeSliderValue + 2  {
            println("EXE")
            Grid.emptyGrid()
            Grid(tileSize: Int(sizeSlider.value), scene : self)
            Grid.placeGridOnScreen(self)
            oldSizeSliderValue = newSizeSliderValue
        }




        
        
    }
}












