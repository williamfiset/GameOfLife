//
//  Tile.swift
//  GameOfLife
//
//  Created by William Fiset on 2014-06-14.
//  Copyright (c) 2014 William Fiset. All rights reserved.
//


import SpriteKit

struct Tile {
    
    let x : Int
    let y : Int
    
    var color : Color

    static var tileSize : Int = 0;
    
    // Defines the color of a Block
    enum Color : String {
        
        case Black = "Black"
        case White = "White"
        
        func swap () -> Color{
            switch self {
                case .White: return .Black
                case .Black: return .White
            }
        }
    }
    
    
    // Designated Initializer
    init (xPos x : Int , yPos y : Int, tileSize : Int, alive : Bool) {
        
        self.x = x
        self.y = y
        
        self.color = alive ? .Black : .White

        Tile.tileSize = tileSize

    }
    
    // Convenience Initializer
    init (xPos x : Int, yPos y : Int, alive : Bool){
        self.init(xPos: x, yPos: y, tileSize : 40, alive : alive)
    }
    
    // Defines alive as being black
    func isAlive() -> Bool {
        return self.color == .Black
    }

    
}
































































