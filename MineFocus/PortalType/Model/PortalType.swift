//
//  PortalType.swift
//  MineFocus
//
//  Created by xiaohui.sun on 2017/2/17.
//  Copyright © 2017 pactera. All rights reserved.
//

import UIKit

/// ボータルタイプのモデル
class PortalType {
    
    /// ボータルタイプの初期化
    func setValues(dict: Dictionary<String, String>) {
        
        // ボタンサイズ
        size = dict["size"] ?? ""
        
        // 背景写真
        backgroundImage = dict["backgroundImage"] ?? ""
        
        //　背景色
        background = dict["background"] ?? ""
        
        //　ボタンの写真
        imageURL = dict["imageURL"] ?? ""
        
        //　ボタンのリンク
        link = dict["link"] ?? ""
        
        //　ボタンのソート
        sort = dict["sort"] ?? ""
        
        //　タイトル
        title = dict["title"] ?? ""
        
        //　サブタイトル
        subTitle = dict["subTitle"] ?? ""
        
        // レマーク
        remark = dict["remark"] ?? ""
        
    }
    
    /// ボタンサイズ
    var buttonSize: CGSize = CGSize(width: 180, height: 80)
    var size: String? {
        didSet {
            guard let size = size else {
                return
            }
            
            let sizeArray = size.components(separatedBy: ",")
            
            if sizeArray.count == 2 {
                if let width = Double(sizeArray[0]),
                   let height = Double(sizeArray[1]){
                    buttonSize.width = CGFloat(width)
                    buttonSize.height = CGFloat(height)
                }
            }
        }
    }
    
    /// 背景写真
    var backgroundImage: String?
    
    ///　背景色
    var backColor: UIColor? = UIColor.blue
    var background: String? {
        didSet{
            guard let background = background else {
                return
            }
            
            backColor = UIColor.colorWithHex(hex: background)
        }
    }
    
    ///　ボタンの写真
    var image: UIImage?
    var imageURL: String? {
        didSet{
            guard let imageURL = imageURL else {
                return
            }
            
//            let url = URL(fileURLWithPath: imageURL)
//            let data = try? Data(contentsOf: url)
//            image = UIImage(data: data ?? Data())
            
            image = UIImage(named: imageURL)
        }
    }
    
    ///　ボタンのリンク
    var link: String?
    
    ///　ボタンのソート
    var buttonSort: Int? = 1
    var sort: String?{
        didSet {
            guard let sort = sort else {
                return
            }
            
            buttonSort = Int(sort) ?? 1
        }
    }

    ///　タイトル
    var title: String = ""

    ///　サブタイトル
    var subTitle: String?
    
    /// レマーク
    var remark: String?
}
