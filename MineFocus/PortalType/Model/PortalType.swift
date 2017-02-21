//
//  PortalType.swift
//  MineFocus
//
//  Created by xiaohui.sun on 2017/2/17.
//  Copyright © 2017 pactera. All rights reserved.
//

import UIKit

/// ボータルタイプのモデル
class PortalType: NSObject {
    
    private let test: String = ""
    
    /// ボタンサイズ
    var buttonSize: CGSize = CGSize(width: 200, height: 100)
    var size: String? {
        didSet {
            guard let size = size else {
                return
            }
            
            let sizeArray = (size as NSString).components(separatedBy: ",")
            
            if sizeArray.count == 2 {
                if let width = Double(sizeArray[0]),
                   let height = Double(sizeArray[1]){
                    buttonSize.width = CGFloat(width)
                    buttonSize.height = CGFloat(height)
                }
            }
        }
    }
    
    ///　背景色
    var backColor: UIColor? = UIColor.blue
    var background: String? {
        didSet{
            guard let background = background else {
                return
            }
            
            backColor = colorWithHex(hex: background)
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
    
    /// setup color with rgb
    ///
    /// - Parameters:
    ///   - red: red uint32
    ///   - green: green uint32
    ///   - blue: blue uint32
    /// - Returns: UIColor
    func colorWithRGB(red: UInt32, green: UInt32, blue: UInt32) -> UIColor {
        return UIColor(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1)
    }
    
    /// setup color with hex
    ///
    /// - Parameter hex: hex color
    /// - Returns: UIColor
    func colorWithHex(hex: String) -> UIColor {
        
        // define rgb
        var red: UInt32 = 0
        var green: UInt32 = 0
        var blue: UInt32 = 0
        
        // convert hex to red/green/blue
        Scanner(string: hex[0..<2]).scanHexInt32(&red)
        Scanner(string: hex[2..<4]).scanHexInt32(&green)
        Scanner(string: hex[4..<6]).scanHexInt32(&blue)
        
        return self.colorWithRGB(red: red, green: green, blue: blue)
    }
    
    /// model description for Testing
    override var description: String {
        return String(format: "size:%@, background:%@, imageURL: %@, link:%@, sort:%@,title:%@, subTitle:%@, remark:%@", size ?? "", background ?? "", imageURL ?? "", link ?? "", sort ?? "", title, subTitle ?? "", remark ?? "")
    }
    
}

// MARK: - String+Extension
extension String{
    
    /// get subscript by range
    ///
    /// - Parameter r: range (0.0..<5.0)
    subscript (r: Range<Int>) -> String {
        get {
            let startIndex = self.index(self.startIndex, offsetBy: r.lowerBound)
            let endIndex = self.index(self.startIndex, offsetBy: r.upperBound)
            
            return self[startIndex..<endIndex]
        }
    }
}
