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
    
//    var isAlive = false
    
    static var activeCells = SKSpriteNode[]()
    static var deadCells = SKSpriteNode[]()
    static var cells = SKSpriteNode[]()
    
    // Defines whether a tile is Black or White
    static let isAlive : (SKSpriteNode) -> Bool = {
        (node : SKSpriteNode) -> Bool in
        node.color == UIColor.blackColor()
    }
    
    
    init ( tileSize : Int , scene : SKScene) {
        
        let horizontalTiles = sceneWidth / tileSize
        let verticalTiles = (sceneHeight - Int(verticalTileLimit)) / tileSize
 
        Grid.emptyGrid()
        
        let tileDimension = CGSize(width: tileSize, height: tileSize)
        let startX = abs(sceneWidth -  (tileSize * horizontalTiles) ) / 2
        let startY = abs( (sceneHeight - Int(verticalTileLimit)) - (tileSize * verticalTiles) ) / 2
        
        
        var height = sceneHeight
        
        
        for y in 0...verticalTiles {
            for x in 0...horizontalTiles {
                
                // Stops row
                if ( (startX + (x * tileSize) + tileSize) > sceneWidth ) {
                    break
                }
                
                // Stops Columns from forming
                if Float((height - (y * tileSize) - tileSize - startY )) < verticalTileLimit {
                    return
                }
                
                let nodeColor = arc4random() % 2 == 0 ? UIColor.blackColor() : UIColor.whiteColor()
                
                var tile = SKSpriteNode(color: nodeColor, size: tileDimension)
                
                // anchorPoint means that the image is relative to the top left
                tile.anchorPoint = CGPoint(x: 0, y: 1)
                tile.position = CGPoint(x: startX + x * tileSize, y:  height - (y * tileSize) - startY) //  - tileSize/2
                
                
                // Place each tile in thier respective groups
                if Grid.isAlive(tile) { Grid.activeCells.append(tile) }
                else { Grid.deadCells.append(tile) }
                
                Grid.cells.append(tile)
            }
        }
        
    }
    
    static func getNode( point : CGPoint) -> SKSpriteNode? {
        
        for aNode in cells {
            if aNode.frame.contains(point) {
                return aNode
            }
        }
        return nil
    }
    
    
    static func emptyGrid() {
        
        for tile in Grid.activeCells {
            tile.removeFromParent()
        }

        for tile in Grid.deadCells {
            tile.removeFromParent()
        }
        
        for tile in Grid.cells {
            tile.removeFromParent()
        }
        
        Grid.activeCells = []
        Grid.deadCells = []
        Grid.cells = []
        
    }
    
    static func placeGridOnScreen (scene : SKScene) {

        for tile in cells {
            scene.addChild(tile)
        }
        
    }
    
}

class Tile : SKSpriteNode {
    
    
    
}










































