//
//  ViewController.swift
//  Calculator
//
//  Created by Yonatan Belayhun on 2/28/18.
//  Copyright © 2018 Yonatan Belayhun. All rights reserved.
//

import UIKit

struct Stack<T> {
    var items = [T]()
    mutating func push(newItem: T){
        items.append(newItem)
    }
    mutating func pop() -> T? {
        guard !items.isEmpty else{
            return nil
        }
        return items.removeLast()
    }
    func top() -> T? {
        guard !items.isEmpty else {
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
        print("Operators:" , operater.items)
        print("Operands:" , operand.items)
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
var numOnScreen = String()
class ViewController: UIViewController {

    @IBOutlet weak var label: UITextField!
    
    @IBAction func numbers(_ sender: UIButton) {
        label.text = label.text! + String(sender.tag)
    }
    @IBAction func clear(_ sender: UIButton) {
        label.text = nil
    }
    @IBAction func symbols(_ sender: UIButton) {
        
        if sender.tag == 10{
            label.text = label.text! + "("
        }
        if sender.tag == 11{
            label.text = label.text! + ")"
        }
        if sender.tag == 12{
            label.text = label.text! + "+"
        }
        if sender.tag == 13{
            label.text = label.text! + "-"
        }
        if sender.tag == 14{
            label.text = label.text! + "*"
        }
        if sender.tag == 15{
            label.text = label.text! + "/"
        }
        if sender.tag == 16{
            label.text = label.text! + "‐"
        }
        if sender.tag == 17{
            label.text = label.text! + "."
        }
    }
    @IBAction func Eval(_ sender: UIButton) {
        print(label.text!)
        numOnScreen = label.text!

        numOnScreen = label.text!.replacingOccurrences(of: "+", with: " + ")
        numOnScreen = numOnScreen.replacingOccurrences(of: "-", with: " - ")
        numOnScreen = numOnScreen.replacingOccurrences(of: "/", with: " / ")
        numOnScreen = numOnScreen.replacingOccurrences(of: "*", with: " * ")
        numOnScreen = numOnScreen.replacingOccurrences(of: "(", with: "( ")
        numOnScreen = numOnScreen.replacingOccurrences(of: ")", with: " )")
        numOnScreen = numOnScreen.replacingOccurrences(of: "  ", with: " ")
        let numOnScreen2 = numOnScreen.components(separatedBy: " ")
        print(numOnScreen)
        print(numOnScreen2)
        label.text = String(inFixEval(numOnScreen2))
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

