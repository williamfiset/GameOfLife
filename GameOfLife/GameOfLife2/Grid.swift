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
    
    
    static var activeCells = Tile[]()
    static var deadCells = Tile[]()
    static var cells = Tile[]()
    
   
    
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
                
                
                var nodeColor = UIColor.blackColor()
                var isAlive = false
                if arc4random() % 2 == 0 {
                    nodeColor = UIColor.whiteColor()
                    isAlive = true
                }
                
                
                
                
                var tile = Tile(color: nodeColor, size: tileDimension, isAlive: isAlive)
                
                // anchorPoint means that the image is relative to the top left
                tile.anchorPoint = CGPoint(x: 0, y: 1)
                tile.position = CGPoint(x: startX + x * tileSize, y:  height - (y * tileSize) - startY) //  - tileSize/2
                
                
                // Place each tile in thier respective groups
                if tile.isAlive { Grid.activeCells.append(tile) }
                else { Grid.deadCells.append(tile) }
                
                Grid.cells.append(tile)
            }
        }
    }
    
    static func getNode( point : CGPoint) -> Tile? {
        
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
    
    var isAlive : Bool = false
    
    init(color: UIColor!, size: CGSize, isAlive : Bool) {
        
        // Superclass designated constructor
        super.init(texture: nil, color: color, size: size)
        self.isAlive = isAlive

    }
    
}










































