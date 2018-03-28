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

class ViewController: UIViewController {

    @IBOutlet weak var label: UITextField!
    var numOnScreen: Double = 0
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
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

