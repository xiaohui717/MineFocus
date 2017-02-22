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
    
    /// レマーク
    var remark: String?
    
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
        
        // 背景写真/背景色の設定
        if let backgroundImage = portalType.backgroundImage,
           let image = UIImage(named: backgroundImage) {
            
            btn.backgroundColor = UIColor(patternImage: image)
        }else if let color = portalType.backColor{
            
            btn.backgroundColor = color
        }
        
        // ボタンの写真
        if let image = portalType.image {
            btn.imageView.image = image
        }
        
        // ボタンのリンク
        btn.link = portalType.link
        
        // ソートのタグ
        if let tag = portalType.buttonSort {
            btn.sortTag = tag
        }
        
        //　ボタンのタイトル
        btn.buttonTitle.text = portalType.title
        
        //　ボタンのサブタイトル
        btn.buttonSubTitle.text = portalType.subTitle ?? ""
        
        // レマーク
        btn.remark = portalType.remark ?? ""

        return btn
    }
    
}
