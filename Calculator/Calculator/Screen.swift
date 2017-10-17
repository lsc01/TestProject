//
//  Screen.swift
//  Calculator
//
//  Created by lsc on 2017/10/16.
//  Copyright © 2017年 landaye. All rights reserved.
//

import UIKit

class Screen: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var inputLabel:UILabel?
    
    var historyLabel:UILabel?
    
    var inputString = ""
    
    var historyString = ""
    
    let figureArray:Array<Character> = ["0","1","2","3","4","5","6","7","8","9","."]
    
    let funcArray = ["+","-","*","/","%","^"]
    
    var isInputDot = false
    
    init(){
        inputLabel = UILabel()
        historyLabel = UILabel()
        super.init(frame: CGRect.zero)
        installUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func installUI(){
        inputLabel?.textAlignment = .right;
        historyLabel?.textAlignment = .right
        
        inputLabel?.font = UIFont.systemFont(ofSize: 34)
        historyLabel?.font = UIFont.systemFont(ofSize: 30)
        
        inputLabel?.textColor = UIColor.orange
        historyLabel?.textColor = UIColor.black
        
        inputLabel?.adjustsFontSizeToFitWidth = true
        inputLabel?.minimumScaleFactor = 0.5
        historyLabel?.adjustsFontSizeToFitWidth = true
        historyLabel?.minimumScaleFactor = 0.5
        
        inputLabel?.lineBreakMode = .byTruncatingHead
        historyLabel?.lineBreakMode = .byTruncatingHead
        
        inputLabel?.numberOfLines = 0
        historyLabel?.numberOfLines = 0
        
        self.addSubview(inputLabel!)
        self.addSubview(historyLabel!)
        
        
        inputLabel?.snp.makeConstraints({ (maker) in
            maker.left.equalTo(10)
            maker.right.bottom.equalTo(-10)
        maker.height.equalTo(inputLabel!.superview!.snp.height).multipliedBy(0.5).offset(-10)
        })
        
        historyLabel?.snp.makeConstraints({ (maker) in
            maker.left.top.equalTo(10)
            maker.right.equalTo(-10)
            maker.height.equalTo(historyLabel!.superview!.snp.height).multipliedBy(0.5).offset(-10)
        })
        
    }
    
    func inputContent(content:String){
        if !figureArray.contains(content.characters.last!) && !funcArray.contains(content) {
            return;
        }
        
        if inputString.characters.count > 0 {
            //如果上次输入的是数字包括"."
            if figureArray.contains(inputString.characters.last!) {
                
                if !isInputDot && content.characters.last! == "." {
                    return
                }
                
                if funcArray.contains(content) && inputString.characters.last! == "." {
                    return
                }
                
                //输入了 "." 就不能再输
                if content.characters.last! == "." {
                    isInputDot = false
                }
                
                //输入了运算符就可以再输入 "."
                if funcArray.contains(content) && content.characters.last! != "%"{
                    isInputDot = true
                }
               
                inputString.append(content)
                inputLabel?.text = inputString
            }else{//如果上次输入的是运算符
                //如果输入的是数字
                if figureArray.contains(content.characters.last!) && content.characters.last! != "."{
                    inputString.append(content)
                    inputLabel?.text = inputString
                }
            }
        }else{
            if figureArray.contains(content.characters.last!) && content.characters.last! != "."{
                isInputDot = true
                inputString.append(content)
                inputLabel?.text = inputString
            }
        }
        
        
    }
    
    func refreshHistory(){
        historyString = inputString
        historyLabel?.text = historyString
    }
    
    func clearContent() {
        inputString = ""
        inputLabel?.text = inputString
    }
    
    func deleteInput() {
        if inputString.characters.count > 0 {
            inputString.remove(at: inputString.index(before: inputString.endIndex))
            inputLabel?.text = inputString
        }
    }
    
    

}
