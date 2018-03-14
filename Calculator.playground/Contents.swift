//: Playground - noun: a place where people can play

import Cocoa

struct Stack<T> {
    var items = [T]()
    
    mutating func push(newItem: T) {
        items.append(newItem)
    }
    
    mutating func pop() -> T? {
        guard !items.isEmpty else {
            return nil
        }
        return items.removeLast()
    }
    
    func top() -> T? {
        guard !items.isEmpty else{
            return nil
        }
        return items.last
    }
    
    func isEmpty() -> Bool? {
        guard !items.isEmpty else {
            return true
        }
        return false
    }
}

func add(_ a: Double, _ b: Double)->Double{
    return a+b
}

func sub(_ a: Double, _ b: Double)->Double{
    return a-b
}

func mult(_ a: Double, _ b: Double)->Double{
    return a*b
}

func div(_ a: Double, _ b: Double)->Double{
    
    if(b != 0){
        return a/b
    }else{
        return 0 //try catch
    }
}

typealias binop = (Double, Double)->Double

let ops: [String: binop] = ["+":add, "-":sub, "*":mult, "/":div]

var opFunc = ops["+"]

var x = opFunc!(5,10)

func doMath(_ a: Double, _ b: Double, _ op: Character) -> Double
{
    let opFunc = ops["\(op)"]
    return opFunc!(a,b)
}

//fix negatives
//let x = Double("-4")!

