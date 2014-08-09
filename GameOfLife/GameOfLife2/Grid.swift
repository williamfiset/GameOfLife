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
var gridCells : Tile[][] = []

@objc class Grid  {
    
    init ( tileSize : Int , scene : SKScene) {
        
        currentTileSize = tileSize
        horizontalTiles = (sceneWidth / tileSize)
        verticalTiles = ((sceneHeight - Int(verticalTileLimit)) / tileSize) - 1
                
        Grid.emptyGrid()
        
        let tileDimension = CGSize(width: tileSize, height: tileSize)
        let startX = 0
        let startY = 0
        
        
        var height = sceneHeight
        var rowIndex = 0
        
        for y in 0...verticalTiles {
            
            var row : Tile [] = []
            var column : Tile [] = [] // columns must be added as you go
            
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
                } else {
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
        
        for tiles in gridCells {
            for cell in tiles {

                let aliveNeighbors : Int8 = cell.getNumberOfAliveAdjacentBlocks()
                
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

        
        // This loop is needed to go back and actually change the color of the squares
        for tiles in gridCells {
            for cell in tiles {
                
                if cell.willChangeColor {
                    cell.swapColor()
                    cell.willChangeColor = false
                    
                }
                
            }
        }
        
    }
    

    // Counts all alive cells in a given array of tiles
    class func countAliveCells( tiles : Tile[] ) -> Int {
        
        var aliveCells = 0
        for cell in tiles {
            if cell.isAlive { aliveCells++ }
        }
        return aliveCells
    }
    
    class func countAliveCells () -> Int {
        
        var aliveCells = 0
        for row in gridCells {
            for cell in row {
                if cell.isAlive {
                    aliveCells++
                }
            }
        }
        return aliveCells
    }
    
    /* Removes the grid from the screen */
    class func emptyGrid() {
        
        for tiles in gridCells {
            for tile in tiles {
                tile.removeFromParent()
            }
        }
        
        gridCells = []

    }
    
    /* Makes the grid white */
    class func makeWhiteGrid() {

        for tiles in gridCells {
            for tile in tiles {
                if tile.isAlive {
                    tile.swapColor()
                }
            }
        }
        
    }
    
    class func placeGridOnScreen (scene : SKScene) {
        
        for tiles in gridCells {
            for tile in tiles {
                scene.addChild(tile)
            }
        }
        
    }
    
    class func createNewGrid ( scene : SKScene , emptyGrid : Bool = false ) {
        
        // Removes old Grid completely (removes parent node)
        Grid.emptyGrid()
        
        Grid(tileSize: Int(WAFViewHandler.segmentSizeValue()) , scene : scene)
        Grid.placeGridOnScreen(scene)

        if emptyGrid {
            Grid.makeWhiteGrid()
        }
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
        
        switch isAlive {
            
            // Black
            case true:
                isAlive = false
                color = UIColor.whiteColor()
            
            //White
            case false:
                    isAlive = true
                    color = UIColor.blackColor()
            
            default: break
        }
        
    }
    
    /* Counts the amount of black blocks surrounding the tile */
    func getNumberOfAliveAdjacentBlocks() -> Int8  {
        
        var blocks : Int8 = 0
        
        // Checks the blocks NSEW (better performance for sides)
        if let sblk = Grid.getNode( self.column + 1, self.row) { if sblk.isAlive { blocks++ } }
        if let nblk = Grid.getNode( self.column - 1, self.row) { if nblk.isAlive { blocks++ } }
        if let wblk = Grid.getNode( self.column, self.row - 1) { if wblk.isAlive { blocks++ } }
        if let eblk = Grid.getNode( self.column, self.row + 1) { if eblk.isAlive { blocks++ } }
        
       /*
        * Because of the rule:
        * "Any live cell with more than three live neighbours dies, as if by overcrowding."
        * You can return when blocks is more than three
        */
        if blocks > 3 {return blocks}
        if let seblk = Grid.getNode(self.column + 1, self.row + 1) { if seblk.isAlive { blocks++ } }
        if blocks > 3 {return blocks}
        if let swblk = Grid.getNode(self.column + 1, self.row - 1) { if swblk.isAlive { blocks++ } }
        if blocks > 3 {return blocks}
        if let nwblk = Grid.getNode(self.column - 1, self.row - 1) { if nwblk.isAlive { blocks++ } }
        if blocks > 3 {return blocks}
        if let neblk = Grid.getNode(self.column - 1, self.row + 1) { if neblk.isAlive { blocks++ } }
        
        return blocks
    }

    
}







































