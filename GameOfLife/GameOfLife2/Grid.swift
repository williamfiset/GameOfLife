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

    static var cells = Tile[]()
    static var rowCells : Dictionary < Int, Tile[] > = Dictionary()
    static var columnCells : Dictionary < Int, Tile[] > = Dictionary()
    
    init ( tileSize : Int , scene : SKScene) {
        
        let horizontalTiles = sceneWidth / tileSize
        let verticalTiles = (sceneHeight - Int(verticalTileLimit)) / tileSize
 
        Grid.emptyGrid()
        
        let tileDimension = CGSize(width: tileSize, height: tileSize)
        let startX = abs(sceneWidth -  (tileSize * horizontalTiles) ) / 2
        let startY = abs( (sceneHeight - Int(verticalTileLimit)) - (tileSize * verticalTiles) ) / 2
        
        
        var height = sceneHeight
        var rowIndex = 0
        
        for y in 0...verticalTiles {
            
            var row : Tile[] = []
            var column : Tile[] = [] // columns must be added as you go
            
            for x in 0...horizontalTiles {
                
                // Stops row
                if ( (startX + (x * tileSize) + tileSize) > sceneWidth ) {
                    break
                }
                
                // Stops Columns from forming
                if Float((height - (y * tileSize) - tileSize - startY )) < verticalTileLimit {
                    return
                }
                
                
                // Randomly Selects a Color for the Tile
                var nodeColor = UIColor.blackColor()
                var isAlive = true
                if arc4random() % 2 == 0 {
                    nodeColor = UIColor.whiteColor()
                    isAlive = false
                }

                
                
                var tile = Tile(color: nodeColor, size: tileDimension, isAlive: isAlive, row: x, column: y)
                
                // anchorPoint means that the image is relative to the top left
                tile.anchorPoint = CGPoint(x: 0, y: 1)
                tile.position = CGPoint(x: startX + x * tileSize, y:  height - (y * tileSize) - startY) //  - tileSize/2

                
                Grid.cells.append(tile)
                
                row.append(tile)
                
                // Add elements to the columns as they go
                if var column = Grid.columnCells[x] {
                    column.append(tile)
                    Grid.columnCells[x] = column
                }else{
                    Grid.columnCells[x] = [tile]
                }
                
                
            }
            
            Grid.rowCells.updateValue( row, forKey: rowIndex)
            rowIndex++

            
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
        for tile in Grid.cells { tile.removeFromParent() }
        Grid.cells = []
    }
    
    static func placeGridOnScreen (scene : SKScene) {
        for tile in cells { scene.addChild(tile) }
    }
    
}

class Tile : SKSpriteNode {
    
    var isAlive : Bool = false
    let row, column : Int
    
    init(color: UIColor!, size: CGSize, isAlive : Bool, row : Int, column : Int) {

        self.row = row
        self.column = column
        self.isAlive = isAlive
        
        // Superclass designated constructor
        super.init(texture: nil, color: color, size: size)

        
    }
    
    func swapColor(){
        
        // Black
        if isAlive {
            isAlive = false
            color = UIColor.whiteColor()
        
        // White
        }else{
            isAlive = true
            color = UIColor.blackColor()
        }
        
    }
    
    
    func getAdjacentBlocks() {
        
        var blocks : Tile[] = []

    }
    
    
    
}










































