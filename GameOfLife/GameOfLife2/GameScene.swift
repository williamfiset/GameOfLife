//
//  GameScene.swift
//  GameOfLife
//
//  Created by William Fiset on 2014-06-14.
//  Copyright (c) 2014 William Fiset. All rights reserved.
//

import SpriteKit
import CoreGraphics

var sceneHeight : Int = 0
var sceneWidth : Int = 0
var verticalTileLimit : Float = 0.0

let screenHeight = 1136
let screenWidth = 640


class GameScene : SKScene {
    
    /* Setup your scene here */
    override func didMoveToView(view: SKView) {
        
        sceneHeight = Int(self.size.height)
        sceneWidth = Int(self.size.width)
        verticalTileLimit = Float(sceneHeight) * 0.20
        println( "VerticalTileLimit: \(verticalTileLimit)" )
        
        self.backgroundColor = UIColor.grayColor()
        
        WAFViewPlacer.placeMainSceneViews(view)
        
        let grid = Grid(horizontalTiles: 10 , verticalTiles: 15 , tileSize: 20)
        Grid.placeGridOnScreen(self)
        
        let redBar = SKSpriteNode(color: UIColor.redColor(), size: CGSize(width: screenWidth, height: 2))
        redBar.position = CGPoint(x: 0.0, y: verticalTileLimit )
        self.addChild(redBar)
        
    }
    
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}












