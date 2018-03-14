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

func add(_ a: Int, _ b: Int)->Int{
    return a+b
}

func sub(_ a: Int, _ b: Int)->Int{
    return a-b
}

func mult(_ a: Int, _ b: Int)->Int{
    return a*b
}

func div(_ a: Int, _ b: Int)->Int{
    
    if(b != 0){
        return a/b
    }else{
        return 0 //try catch
    }
}



