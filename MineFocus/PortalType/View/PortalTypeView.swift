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
        
        // ポータルタイプボタンの設置
        portalTypeView.setupUI()
        
        return portalTypeView
    }
    
    /// ポータルタイプボタンの設置
    func setupUI() {
        
        // モデルの取得
        for portalType in PortalTypeManager.shared.portalTypes {
            let btn = PortalTypeButton.portaTypeButton(portalType: portalType)
            
            // ボタンの追加
            addButton(btn: btn)
        }
    }
    
    /// ボタンの追加
    ///
    /// - Parameter btn: ポータルタイプのボタン
    func addButton(btn: PortalTypeButton)  {
        
        // ボタンのFrameの設定
        let btnFrame = CGRect(origin: CGPoint(x: 0, y: 0), size: btn.bounds.size)
        btn.frame = btnFrame
        
        // ボタンViewに追加する
        self.addSubview(btn)
        
    }
}
