//: Playground - noun: a place where people can play
//Calculator Playground
//3-15-16
//CSC2310 Mobile App Development
//Tyler Griffith, Yonatan Belayhun, Jason Ellerbeck
//Calculates infix and postfix expressions.


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

func priority(_ char: String)->Int{
    switch char {
    case "(":
        return 20
    case "+":
        return 12
    case "-":
        return 12
    case "*":
        return 13
    case "/":
        return 13
    case ")":
        return 19
    default:
        return 0
    }
}

func inFixEval(_ tokens: [String]) -> Double
{
    var operand = Stack<Double>()
    var operater = Stack<String>()

    //while there is another element in the infixExpr
    for token in tokens
    {
        //if the token is a double
        if let num = Double(token)
        {
            //push onto stack
            operand.push(newItem: num)
        }else if token == ")"
        {
            while operater.top() != "("
            {
                //pop 2 values off the stack
                let val2 = operand.pop()!
                let val1 = operand.pop()!
                //pop an operator
                let operater1 = operater.pop()!
                //push result
                operand.push(newItem: doMath(val1, val2, operater1))
            }
            //pop the "(" off the stack
            operater.pop()!
        }else{
            while(operater.isEmpty() != true &&
                  priority(operater.top()!) >= priority(token) &&
                  operater.top() != "(")
            {
                //pop 2 values off the stack
                let val2 = operand.pop()!
                let val1 = operand.pop()!
                //pop an operator
                let operater1 = operater.pop()!
                //push result
                operand.push(newItem: doMath(val1, val2, operater1))
            }
            //push the current token on the operator stack
            operater.push(newItem: token)
        }
        //Print the stacks
        //print("Operators:" , operater.items)
        //print("Operands:" , operand.items)
    }
    //Taking care of any operations pending
    while(operater.isEmpty() != true) {
        let val2 = operand.pop()!
        let val1 = operand.pop()!
        let operater1 = operater.pop()!
        operand.push(newItem: doMath(val1, val2, operater1))
    }
    return operand.pop()!
}
//test statements
let infix1 = ["3", "+", "4", "*", "2"]
let infix2 = ["(", "3", "+", "4", ")", "*", "2"]
let infix3 = ["-9", "/", "2", "+", "6", "*", "5"]
let infix4 = ["-9", "/", "(", "2", "+", "6", ")", "*", "5"]
let postfix1 = ["3", "4", "2", "*", "+"]
let postfix2 = ["3", "4", "+", "2", "*"]
let postfix3 = ["-9", "2", "/", "6", "5", "*", "+"]
let postfix4 = ["-9", "2", "6", "+", "/", "5", "*"]
//test print statements
print("Infix 1:", inFixEval(infix1))
print("Infix 2:", inFixEval(infix2))
print("Infix 3:", inFixEval(infix3))
print("Infix 4:", inFixEval(infix4))
print("Postfix 1:", postFixEval(postfix1))
print("Postfix 2:", postFixEval(postfix2))
print("Postfix 3:", postFixEval(postfix3))
print("Postfix 4:", postFixEval(postfix4))

