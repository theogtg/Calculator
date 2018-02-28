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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

