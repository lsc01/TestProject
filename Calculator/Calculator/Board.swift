//
//  Board.swift
//  Calculator
//
//  Created by lsc on 2017/10/16.
//  Copyright © 2017年 landaye. All rights reserved.
//

import UIKit
import SnapKit

protocol BoardbuttonInputDelegate {
    func boardbuttonClick(content:String)
}

class Board: UIView {

    var delegate:BoardbuttonInputDelegate?
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var dataArray = ["0",".","%","="
                    ,"1","2","3","+"
                    ,"4","5","6","-",
                     "7","8","9","*"
                    ,"AC","Delete","^","/"];
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        installUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func installUI(){
        var frontBtn:FuncButton!
        
        for index in 0..<20 {
            let btn = FuncButton()
            self.addSubview(btn)
            
            btn.snp.makeConstraints({ (maker) in
                if index%4 == 0 {
                    maker.left.equalTo(0)
                }else{
                    maker.left.equalTo(frontBtn.snp.right)
                }
                if index/4 == 0 {
                    maker.bottom.equalTo(0)
                }else if index%4 == 0{
                    maker.bottom.equalTo(frontBtn.snp.top)
                }else{
                    maker.bottom.equalTo(frontBtn.snp.bottom)
                }
                
                maker.width.equalTo(btn.superview!.snp.width).multipliedBy(0.25)
                maker.height.equalTo(btn.superview!.snp.height).multipliedBy(0.2)
                
            })
            
            btn.tag = index+100
            btn.addTarget(self, action: #selector(btnClick(button:)), for: .touchUpInside)
            btn.setTitle(dataArray[index], for: UIControlState.normal)
            frontBtn = btn
            
        }
    }
    func btnClick(button:FuncButton){
        if delegate != nil {
            delegate?.boardbuttonClick(content: button.currentTitle!)
        }
        
        print(button.title(for: UIControlState.normal)!)
    }

}
