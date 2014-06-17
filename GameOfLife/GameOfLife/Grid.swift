//
//  Grid.swift
//  GameOfLife
//
//  Created by William Fiset on 2014-06-17.
//  Copyright (c) 2014 William Fiset. All rights reserved.
//

import Foundation
import SpriteKit


let screenHeight = 1136
let screenWidth = 640



struct Grid {
    
    static var tilesOnGrid = 0
    
    static var activeCells = SKSpriteNode[]()
    static var deadCells = SKSpriteNode[]()
    static var cells = SKSpriteNode[]()
    
    // Defines whether a tile is Black or White
    let isAlive : (SKSpriteNode) -> Bool = {
        (node : SKSpriteNode) -> Bool in
        node.color == UIColor.blackColor()
    }
    
    
    init ( horizontalTiles : Int , verticalTiles : Int , tileSize : Int ) {
        
        println("SceneWidth: \(sceneWidth) & \((horizontalTiles * tileSize))")
        println("SceneHeight: \(sceneHeight) & \((verticalTiles * tileSize))")
        
        assert( (horizontalTiles * tileSize) < sceneWidth, "Grid Does not fit on screen, -- ")
        assert( (verticalTiles * tileSize) < sceneHeight, "Grid Does not fit on screen | ")
        
        Grid.emptyGrid()

        let tileDimension = CGSize(width: tileSize, height: tileSize)
        
        var height = sceneHeight
        
        let startX = abs(sceneWidth - (tileSize * horizontalTiles)) / 8
        
        
        println("startX: \(startX)")
        
        for y in 0...verticalTiles {
            for x in 0...horizontalTiles {
                
                var tile = SKSpriteNode(color: UIColor.blackColor(), size: tileDimension)
                
                // anchorPoint means that the image is relative to the top left
                tile.anchorPoint = CGPoint(x: 0, y: 1)
                tile.position = CGPoint(x: startX + x * tileSize , y: height - (y * tileSize))
                
                
                // Place each tile in thier respective groups
                if isAlive(tile) { Grid.activeCells.append(tile) }
                else { Grid.deadCells.append(tile) }
                
                Grid.cells.append(tile)
            }
        }
        

        
    }
    
    static func emptyGrid() {

        Grid.tilesOnGrid = 0
        Grid.activeCells = []
        Grid.deadCells = []
        
    }
    
    static func placeGridOnScreen (scene : SKScene) {
        
        println("Cells: \(cells.count)")
        for tile in cells {
            scene.addChild(tile)
        }
        
    }
    
}












































