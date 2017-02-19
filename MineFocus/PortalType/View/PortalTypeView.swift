//
//  PortaTypeView.swift
//  MineFocus
//
//  Created by xiaohui.sun on 2017/2/17.
//  Copyright © 2017 pactera. All rights reserved.
//

import UIKit

class PortalTypeView: UIView {

    var portalTypes: [PortalType]?
    
    /// クラスの関数
    ///
    /// - Returns: PortalTypeView のインスタンス
    class func portalTypeView() -> PortalTypeView {
        
        //　インスタンス化
        let nib = UINib(nibName: "PortalTypeView", bundle: nil)
        let portalTypeView = nib.instantiate(withOwner: nil, options: nil)[0] as! PortalTypeView
        
        return portalTypeView
    }
}
