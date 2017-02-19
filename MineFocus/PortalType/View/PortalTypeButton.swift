//
//  PortalTypeButton.swift
//  MineFocus
//
//  Created by xiaohui.sun on 2017/2/17.
//  Copyright © 2017 pactera. All rights reserved.
//

import UIKit

class PortalTypeButton: UIControl {
    
    /// ボタンの写真
    @IBOutlet weak var imageView: UIImageView!
    
    ///　ボタンのタイトル
    @IBOutlet weak var buttonTitle: UILabel!
    
    ///　ボタンのサブタイトル
    @IBOutlet weak var buttonSubTitle: UILabel!
    
    /// ソートのタグ
    var sortTag: Int = 1
    
    /// ボタンのリンク
    var link: String?
    
    /// クラスの関数
    ///
    /// - Parameter portalType: ポータルのタイプ
    /// - Returns: ポータルタイプのボタン
    class func portaTypeButton(portalType: PortalType) -> PortalTypeButton {
        
        // ボタンのインスタンス化
        let nib = UINib(nibName: "PortalTypeButton", bundle: nil)
        let btn = nib.instantiate(withOwner: nil, options: nil)[0] as! PortalTypeButton
        
        // ボタンサイズの設定
        btn.bounds.size = portalType.buttonSize
        
        // 背景色の設定
        btn.backgroundColor = portalType.backColor
        
        // ボタンの写真
        btn.imageView.image = portalType.image
        
        // ボタンのリンク
        btn.link = portalType.link
        
        // ソートのタグ
        btn.sortTag = (portalType.buttonSort)!
        
        //　ボタンのタイトル
        btn.buttonTitle.text = portalType.title
        
        //　ボタンのサブタイトル
        btn.buttonSubTitle.text = portalType.subTitle

        return btn
    }
    
}
