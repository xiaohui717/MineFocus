//
//  PacteraPickerTool.swift
//  smflc
//
//  Created by xiaohui.sun on 2017/1/19.
//  Copyright © 2017年 pactera. All rights reserved.
//

import UIKit

enum KeyboardToolButtonType{
    case KeyboardToolButtonDone
    case KeyboardToolButtonCancel
}

protocol KeyboardToolDelegate: NSObjectProtocol {
    func buttonClick(keyboardToolButtonType: KeyboardToolButtonType)
}

class PacteraPickerTool: UIView {

    var toolBar: UIToolbar?
    weak var delegate: KeyboardToolDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI()  {
//        self.frame = CGRect(x: 0, y: 0, width: 320, height: 44)
        self.backgroundColor = UIColor.black
        
        toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: 44))
        toolBar?.barStyle = UIBarStyle.default
        toolBar?.backgroundColor = UIColor.black
        
        let confrimBtn = UIBarButtonItem(title: "確定", style: UIBarButtonItemStyle.plain, target: self, action: #selector(doneBtnClick))
        let cancelBtn = UIBarButtonItem(title: "取消", style: UIBarButtonItemStyle.plain, target: self, action: #selector(cancelBtnClick))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem:UIBarButtonSystemItem.flexibleSpace, target:"barButtonItemClicked:", action:nil)
        toolBar?.items = [confrimBtn, flexibleSpace, cancelBtn]

        self.addSubview(toolBar!)
    }
    
    func doneBtnClick()  {
        delegate?.buttonClick(keyboardToolButtonType: KeyboardToolButtonType.KeyboardToolButtonDone)
    }
    
    func cancelBtnClick()  {
        delegate?.buttonClick(keyboardToolButtonType: KeyboardToolButtonType.KeyboardToolButtonCancel)
    }

}
