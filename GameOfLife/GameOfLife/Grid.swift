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
        
        assert(horizontalTiles * tileSize < screenWidth, "Grid Does not fit on screen, -- ")
        assert(verticalTiles * tileSize < screenHeight, "Grid Does not fit on screen | ")
        
        Grid.emptyGrid()

        let tileDimension = CGSize(width: tileSize, height: tileSize)
        
        for x in 0..horizontalTiles {
            for y in 0..verticalTiles {
                
                
                var tile = SKSpriteNode(color: UIColor.blackColor(), size: tileDimension)
                tile.position = CGPoint(x: x * tileSize + tileSize/2, y: y * tileSize)
                

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












































