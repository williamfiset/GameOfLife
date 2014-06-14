// Playground - noun: a place where people can play

import Cocoa

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

var color = Color.White
println(color.toRaw())


color = color.swap()
println(color.toRaw())
color = color.swap()
println(color.toRaw())
