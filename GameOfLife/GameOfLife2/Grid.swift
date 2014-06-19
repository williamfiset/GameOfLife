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
    static var horizontalTiles = 0, verticalTiles = 0
    
    init ( tileSize : Int , scene : SKScene) {
        
        Grid.horizontalTiles = sceneWidth / tileSize
        Grid.verticalTiles = (sceneHeight - Int(verticalTileLimit)) / tileSize
 
        Grid.emptyGrid()
        
        let tileDimension = CGSize(width: tileSize, height: tileSize)
        let startX = abs(sceneWidth -  (tileSize * Grid.horizontalTiles) ) / 2
        let startY = abs( (sceneHeight - Int(verticalTileLimit)) - (tileSize * Grid.verticalTiles) ) / 2
        
        
        var height = sceneHeight
        var rowIndex = 0
        
        for y in 0...Grid.verticalTiles {
            
            var row : Tile[] = []
            var column : Tile[] = [] // columns must be added as you go
            
            for x in 0...Grid.horizontalTiles {
                
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

                
                
                var tile = Tile(color: nodeColor, size: tileDimension, isAlive: isAlive, row: y, column: x)
                
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
    
    // Counts all alive cells in a given array of tiles
    static func countAliveCells( tiles : Tile[] ) -> Int {
        
        var aliveCells = 0
        for cell in tiles {
            if cell.isAlive { aliveCells++ }
        }
        return aliveCells
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
        } else {
            isAlive = true
            color = UIColor.blackColor()
        }
        
    }
    
    // Gets all the blocks around
    func getAdjacentBlocks() -> Tile[]  {
        
        // Performs as check on the row to put the right blocks in the blockList
        func addBlock (inout blockList : Tile[], tile: Tile) -> Bool {
            
            if tile.column + 1 == column || tile.column == column || tile.column - 1 == column {
                blockList.append(tile)
                return true
            }
            return false
        }
        
        var blocks : Tile[] = []
        
        // Searches for the three blocks in the row, those left, middle and right of the current block
        for rowNumber in [row - 1, row, row + 1]{
            if let row = Grid.rowCells[rowNumber]{
                
                var itemsAdded = 0
                for tile : Tile in row {
                    
                    if tile === self { continue }
                    if addBlock(&blocks, tile) { itemsAdded++ }
                    if itemsAdded == 3 { break; }
                    
                }
            }
        }
        return blocks
    }
    

    
}


/*

Any live cell with fewer than two live neighbours dies, as if caused by under-population.
Any live cell with two or three live neighbours lives on to the next generation.
Any live cell with more than three live neighbours dies, as if by overcrowding.
Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.

If The cell is white and it has less than 2 neighbors or has more than 3 neighbors the cell dies
of over population. However, if the critter as exactly three live neighbors then it respawns.


*/







































