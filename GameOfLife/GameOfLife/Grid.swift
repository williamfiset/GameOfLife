//
//  Grid.swift
//  GameOfLife
//
//  Created by William Fiset on 2014-06-17.
//  Copyright (c) 2014 William Fiset. All rights reserved.
//

import Foundation
import SpriteKit



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
        
        // Checks if 
        assert( (horizontalTiles * tileSize) < sceneWidth, "Grid Does not fit on screen, -- ")
        assert( (verticalTiles * tileSize) < sceneHeight, "Grid Does not fit on screen | ")
        
        Grid.emptyGrid()

        let tileDimension = CGSize(width: tileSize, height: tileSize)
        let startX = abs(sceneWidth -  (tileSize * horizontalTiles) ) / 2
        let startY = abs( (sceneHeight - Int(verticalTileLimit)) - (tileSize * verticalTiles) ) / 2
        
        
        var height = sceneHeight
        
        println("startX: \(startX) startY: \(startY)")
        
        
        for y in 0...verticalTiles {
            for x in 0...horizontalTiles {
                
                // Too many vertical tiles
                if Float((height - (y * tileSize) - tileSize - startY )) < verticalTileLimit {
                    return
                }
                
                let nodeColor = arc4random() % 2 == 0 ? UIColor.blackColor() : UIColor.whiteColor()
                
                var tile = SKSpriteNode(color: nodeColor, size: tileDimension)
                
                // anchorPoint means that the image is relative to the top left
                tile.anchorPoint = CGPoint(x: 0, y: 1)
                tile.position = CGPoint(x: startX + x * tileSize - tileSize/2 , y:  height - (y * tileSize) - startY)
                
                
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












































