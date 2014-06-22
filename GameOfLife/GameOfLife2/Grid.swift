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

var rowCells : Dictionary < Int, Tile[] > = Dictionary()
var columnCells : Dictionary < Int, Tile[] > = Dictionary()
var horizontalTiles = 0, verticalTiles = 0
var currentTileSize : Int = 0
var gridCells : Array< Array <Tile> > = []

@objc class Grid  {
    
    
    init ( tileSize : Int , scene : SKScene) {
        
        currentTileSize = tileSize
        horizontalTiles = (sceneWidth / tileSize)
        verticalTiles = ((sceneHeight - Int(verticalTileLimit)) / tileSize) - 1
        
        Grid.emptyGrid()
        
        let tileDimension = CGSize(width: tileSize, height: tileSize)
        let startX = 0 //  abs(sceneWidth -  (tileSize * horizontalTiles) ) / 2
        let startY = 0 // abs( (sceneHeight - Int(verticalTileLimit)) - (tileSize * Grid.verticalTiles) ) / 2
        
        
        var height = sceneHeight
        var rowIndex = 0
        
        for y in 0...verticalTiles {
            
            var row : Tile [] = []
            var column : Tile [] = [] // columns must be added as you go
            
            
            
            // Stops Columns from forming
//            if Float((height - (y * tileSize) - tileSize)) < verticalTileLimit { // - tileSize
//                return
//            }
            
            for x in 0..horizontalTiles {
                
                // Stops row
                if ( (startX + (x * tileSize) + tileSize) > sceneWidth ) {
                    break
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
                tile.position = CGPoint(x: startX + (x * tileSize), y:  height - (y * tileSize) - startY) //  - tileSize/2
                
                
                // Add elements to the columns as they go
                if var column = columnCells[x] {
                    column.append(tile)
                    columnCells[x] = column
                }else{
                    columnCells[x] = [tile]
                }
                
                
                row.append(tile)
                
            }
            
            rowCells.updateValue( row, forKey: rowIndex)
            gridCells.append(row)
            rowIndex++

        }
       
    }
    
    class func getNode ( row : Int, _ column : Int) -> Tile? {
        
        // println("Column: \(column) VerticalTiles: \(verticalTiles) Row: \(row) HorizontalTiles: \(horizontalTiles)")
        if row >= 0 && row < horizontalTiles {
            // Vertical Tiles is <= because when creating cells there's a ... 'for y in 0...verticalTiles'
            if column >= 0 && column <= verticalTiles {
                return gridCells[column][row]
            }
        }

        return nil

    }
    
    class func getNode( point : CGPoint) -> Tile? {
        
        let rowNumber : Int =  abs(((( Int(point.y) - sceneHeight) / currentTileSize ) * currentTileSize) / currentTileSize)
        let columnNumber : Int = Int(point.x) / currentTileSize
       
        return Grid.getNode(columnNumber, rowNumber)

    }
    

    
    
    /*

    Game rules are as follows:
    
    Any live cell with fewer than two live neighbours dies, as if caused by under-population.
    Any live cell with two or three live neighbours lives on to the next generation.
    Any live cell with more than three live neighbours dies, as if by overcrowding.
    Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.
    
    If The cell is white and it has less than 2 neighbors or has more than 3 neighbors the cell dies
    of over population. However, if the critter as exactly three live neighbors then it respawns.
    
    
    */
    class func applyGameRules() {

        let methodStart = NSDate()
        
        for tiles in gridCells {
            for cell in tiles {
                
                
                let aliveNeighbors = Grid.countAliveCells(cell.getAdjacentBlocks())
                
                if cell.isAlive {
                    
                    // under-population or overcrowding
                    if aliveNeighbors < 2 || aliveNeighbors > 3 {
                        cell.willChangeColor = true
                    }
                    
                    // Cell is dead
                } else {
                    
                    // Reproduction
                    if aliveNeighbors == 3 {
                        cell.willChangeColor = true
                    }
                }
                
                
            }
        }
        

        for tiles in gridCells {
            for cell in tiles {
                
                if cell.willChangeColor {
                    cell.swapColor()
                    cell.willChangeColor = false
                }
                
            }
        }
        

        
        let methodFinish = NSDate()
        let execuationTime = methodFinish.timeIntervalSinceDate(methodStart)
        println("executionTime: \(execuationTime)")
        
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
        
        for tiles in gridCells {
            for tile in tiles {
                tile.removeFromParent()
            }
        }
        
        gridCells = []

    }
    
    class func placeGridOnScreen (scene : SKScene) {
        
        for tiles in gridCells {
            for tile in tiles {
                scene.addChild(tile)
            }
        }
        
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
    var willChangeColor = false
    
    let row, column : Int
    
    init(color: UIColor!, size: CGSize, isAlive : Bool, row : Int, column : Int) {

        self.row = row
        self.column = column
        self.isAlive = isAlive
        
        // Superclass designated constructor
        super.init(texture: nil, color: color, size: size)

        
    }
    
    /* Swaps the color of the cell */
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
        
        
        var blocks : Tile[] = []
        
        if let nwblk = Grid.getNode(self.row - 1, self.column - 1) {
            blocks.append(nwblk)
        }
        
        if let nblk = Grid.getNode(self.row, self.column - 1) {
            blocks.append(nblk)
        }
        
        if let neblk = Grid.getNode(self.row + 1, self.column - 1) {
            blocks.append(neblk)
        }
        
//        if blocks.count > 3 { return blocks }
        if let eblk = Grid.getNode(self.row + 1, self.column) {
            blocks.append(eblk)
        }
        
//        if blocks.count > 3 { return blocks }
        if let seblk = Grid.getNode(self.row + 1, self.column + 1) {
            blocks.append(seblk)
        }
        
//        if blocks.count > 3 { return blocks }
        if let sblk = Grid.getNode(self.row, self.column + 1) {
            blocks.append(sblk)
        }
        
//        if blocks.count > 3 { return blocks }
        if let swblk = Grid.getNode(self.row - 1, self.column + 1) {
            blocks.append(swblk)
        }
        
//        if blocks.count > 3 { return blocks }
        if let eblk = Grid.getNode(self.row - 1, self.column) {
            blocks.append(eblk)
        }
        
        return blocks
    }
    

    
}







































