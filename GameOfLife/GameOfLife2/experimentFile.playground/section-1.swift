// Playground - noun: a place where people can play

import CoreGraphics
import Foundation

class Shoe {}

var numbers : Int[][] = []


for n in 0...10 {
    
    var tempArray : Array<Int> = []
    
    for n2 in 0...10 {
        tempArray.append(n2)
    }
    numbers.append(tempArray)
    println("\(numbers[0][0])")
}



