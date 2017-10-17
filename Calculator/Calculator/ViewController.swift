//
//  ViewController.swift
//  Calculator
//
//  Created by lsc on 2017/10/16.
//  Copyright © 2017年 landaye. All rights reserved.
//

import UIKit


class ViewController: UIViewController,BoardbuttonInputDelegate {

    let board = Board()
    let screen = Screen()
    
    let calculator = CalculatorEngine()
    var isNew = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        installUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func installUI() {
        self.view.addSubview(board)
        board.delegate = self;
        board.snp.makeConstraints { (maker) in
            maker.left.right.bottom.equalTo(0)
            maker.height.equalTo(board.superview!.snp.height).multipliedBy(2/3.0)
        }
        self.view.addSubview(screen)
        
        screen.snp.makeConstraints { (maker) in
            maker.left.right.top.equalTo(0)
            maker.bottom.equalTo(board.snp.top)
        }
    }
    
    func boardbuttonClick(content: String) {
        if content == "AC" || content == "Delete" || content == "=" {
            switch content {
            case "AC":
                screen.clearContent()
                screen.refreshHistory()
            case "Delete":
                screen.deleteInput()
            case "=":
                let result = calculator.calculatorEquation(equation: screen.inputString)
                screen.refreshHistory()
                screen.clearContent()
                screen.inputContent(content: String(result))
                isNew = true
                    
            default:
                screen.refreshHistory()
            }
            
        }else{
            if isNew {
                screen.clearContent()
                isNew = false
            }
            screen.inputContent(content: content)
        }
    }

}

