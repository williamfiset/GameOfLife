//
//  Tile.swift
//  GameOfLife
//
//  Created by William Fiset on 2014-06-14.
//  Copyright (c) 2014 William Fiset. All rights reserved.
//

import Foundation
import CoreGraphics



enum Color : String {
    
    case Black = "Black"
    case White = "White"
    
    func swap () -> Color{
        switch self{
            case .White: return .Black
            case .Black: return .White
        }
    }
}

struct Tile {
    
    let x : Int
    let y : Int
    
    var color : Color
    
    static var tilesOnScreen = 0
    
    static var activeCells = Tile[]()
    static var deadCells = Tile[]()
    
    // Designated Initializer
    init (xPos x : Int , yPos y : Int, width : Int, height : Int, alive : Bool) {
        
        self.x = x
        self.y = y
        
        self.color = alive ? .Black : .White
        
        Tile.tilesOnScreen++
        Tile.activeCells.append(self)
    }
    
    // Convenience Initializer
    init (xPos x : Int, yPos y : Int, alive : Bool){
        self.init(xPos: x, yPos: y, width: 40, height: 40, alive : alive)
    }

    
}

























