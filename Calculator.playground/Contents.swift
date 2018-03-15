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
func doMath(_ a: Double, _ b: Double, _ op: String) -> Double
{
    let opFunc = ops["\(op)"]
    return opFunc!(a,b)
}

//let postfixExpr = ["2.3", "14.32", "+", "2", "*"]
let postfixExpr = ["-9", "2", "/", "6", "5", "*", "+"]
func postFixEval(_ tokens: [String]) -> Double
{
    var stack = Stack<Double>()
    for token in tokens{
        if let num = Double(token) {
            stack.push(newItem: num)
        } else {
            let val2 = stack.pop()!
            let val1 = stack.pop()!
            //let b = doMath(val1, val2, token)
            stack.push(newItem: doMath(val1, val2, token))
            //stack.push(newItem: b)
        }
    }
    return stack.pop()!
}

var x = postFixEval(postfixExpr)
print(x)

let infixExpr = ["-9","/", "2","+", "6","*", "5"]
func inFixEval(_ tokens: [String]) -> Int
{
    var operand = Stack<Double>()
    var operater = Stack<String>()
    
    for token in tokens
    {
        if let num = Double(token){
            operand.push(newItem: num)
        }else if token == ")"{
            while operater.top() != "("
            {
                let val2 = operand.pop()!
                let val1 = operand.pop()!
                let operater1 = operater.pop()!
                operand.push(newItem: doMath(val1, val2, operater1))
            }
        }
    }
    return 0
}
