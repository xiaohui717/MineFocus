//
//  UIColor+Extensions.swift
//  MineFocus
//
//  Created by xiaohui.sun on 2017/2/24.
//  Copyright © 2017年 pactera. All rights reserved.
//

import UIKit

// MARK: - UIColor Extension
extension UIColor {
    
    /// setup color with rgb
    ///
    /// - Parameters:
    ///   - red: red uint32
    ///   - green: green uint32
    ///   - blue: blue uint32
    /// - Returns: UIColor
    static func colorWithRGB(red: UInt32, green: UInt32, blue: UInt32) -> UIColor {
        return UIColor(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1)
    }
    
    /// setup color with hex
    ///
    /// - Parameter hex: hex color
    /// - Returns: UIColor
    static func colorWithHex(hex: String) -> UIColor {
        
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
}
