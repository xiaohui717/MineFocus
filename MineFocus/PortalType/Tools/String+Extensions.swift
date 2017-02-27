//
//  String+Extensions.swift
//  MineFocus
//
//  Created by xiaohui.sun on 2017/2/27.
//  Copyright © 2017 pactera. All rights reserved.
//

import Foundation

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
