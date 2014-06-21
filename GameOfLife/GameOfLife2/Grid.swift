//
//  Grid.swift
//  GameOfLife
//
//  Created by William Fiset on 2014-06-17.
//  Copyright (c) 2014 William Fiset. All rights reserved.
//

import Foundation
import SpriteKit


// All global Varibles
var cells = Tile[]()
var rowCells : Dictionary < Int, Tile[] > = Dictionary()
var columnCells : Dictionary < Int, Tile[] > = Dictionary()
var horizontalTiles = 0, verticalTiles = 0
var currentTileSize : Int = 0


@objc class Grid  {
    
    
    init ( tileSize : Int , scene : SKScene) {
        
        currentTileSize = tileSize
        horizontalTiles = sceneWidth / tileSize
        verticalTiles = (sceneHeight - Int(verticalTileLimit)) / tileSize
        
        Grid.emptyGrid()
        
        let tileDimension = CGSize(width: tileSize, height: tileSize)
        let startX = abs(sceneWidth -  (tileSize * horizontalTiles) ) / 2
        let startY = 0 // abs( (sceneHeight - Int(verticalTileLimit)) - (tileSize * Grid.verticalTiles) ) / 2
        
        
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

                
                
                var tile = Tile(color: nodeColor, size: tileDimension, isAlive: isAlive, row: y, column: x)
                
                // anchorPoint means that the image is relative to the top left
                tile.anchorPoint = CGPoint(x: 0, y: 1)
                tile.position = CGPoint(x: startX + x * tileSize, y:  height - (y * tileSize) - startY) //  - tileSize/2

                
                cells.append(tile)
                row.append(tile)
                
                // Add elements to the columns as they go
                if var column = columnCells[x] {
                    column.append(tile)
                    columnCells[x] = column
                }else{
                    columnCells[x] = [tile]
                }
                
                
            }
            
            rowCells.updateValue( row, forKey: rowIndex)
            rowIndex++

        }
    }
    
    class func getNode( point : CGPoint) -> Tile? {
        
        
        let rowNumber =  verticalTiles - ((Int(point.y) - Int(verticalTileLimit) + currentTileSize/2) / currentTileSize)
        let columnNumber = Int(point.x) / currentTileSize
        
        if let row = rowCells[rowNumber] {
            if let column = columnCells[columnNumber] {

                for rowTile in row {
                    for columnTile in column {
                        if rowTile === columnTile {
                            return rowTile
                        }
                    }
                }
                
            }
        }
        
        println("Could not find Block at: \(rowNumber),\(columnNumber)")

        
        return nil
    }
    
    // Counts all alive cells in a given array of tiles
    class func countAliveCells( tiles : Tile[] ) -> Int {
        
        var aliveCells = 0
        for cell in tiles {
            if cell.isAlive { aliveCells++ }
        }
        return aliveCells
    }
    
    class func emptyGrid() {
        for tile in cells { tile.removeFromParent() }
        cells = []
    }
    
    class func placeGridOnScreen (scene : SKScene) {
        for tile in cells { scene.addChild(tile) }
    }
    
    class func createNewGrid ( scene : SKScene ) {
        
        Grid.emptyGrid()
        Grid(tileSize: Int(WAFViewPlacer.segmentSizeValue()) , scene : scene)
        Grid.placeGridOnScreen(scene)
        
    }
    
    
    
}

class Tile : SKSpriteNode {
    
    var isAlive : Bool = false
    var touched = false
    
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
            if let row = rowCells[rowNumber]{
                
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







































