//
//  PortaTypeView.swift
//  MineFocus
//
//  Created by xiaohui.sun on 2017/2/17.
//  Copyright © 2017 pactera. All rights reserved.
//

import UIKit

/// ボタンのレイアウト
///
/// - TwoColumnWithoutMerge: TwoColumnWithoutMerge
/// - TwoColumnWithFristMerge: TwoColumnWithFristMerge
enum PortalTypeButtonLayoutType {
    case TwoColumnWithoutMerge
    case TwoColumnWithFristMerge
}

/// ポータルタイプのビュー
class PortalTypeView: UIView {
    
    /// ボタンのレイアウト
    var layoutType: PortalTypeButtonLayoutType = PortalTypeButtonLayoutType.TwoColumnWithoutMerge

    /// ボタンのコレクション
    var portalTypeButtons = [PortalTypeButton]()
    
    /// 列数
    let columnCount: Int = 2
    
    /// マージン
    let marginToTop: CGFloat = 10
//    let marginToLeft: CGFloat = 10
//    let marginToRight: CGFloat = 10
    let marginToBottom: CGFloat = 10
    
    /// 前行のボタンのX
    var lastBtnY: CGFloat = 0
    
    ///　前行のボタンの高
    var lastBtnHeight: CGFloat = 0
    
    
    /// クラスの関数
    ///
    /// - Returns: PortalTypeView のインスタンス
    class func portalTypeView(layoutType: PortalTypeButtonLayoutType) -> PortalTypeView {
        
        //　インスタンス化
        let nib = UINib(nibName: "PortalTypeView", bundle: nil)
        let portalTypeView = nib.instantiate(withOwner: nil, options: nil)[0] as! PortalTypeView
        
        portalTypeView.layoutType = layoutType
        
        // ポータルタイプボタンの設置
        portalTypeView.setupUI()
        
        return portalTypeView
    }
    
    /// ニューの設置
    func setupUI() {
        
        // 背景色の設置
        backgroundColor = UIColor.clear
    
        //　ビューの横
        self.frame.size.width = UIScreen.main.bounds.size.width
        
        // モデルの取得
        for portalType in PortalTypeManager.shared.portalTypes {
            let btn = PortalTypeButton.portaTypeButton(portalType: portalType)
            
            // モニター関数の追加
            if let btnAction = btn.link {
                btn.addTarget(self, action: Selector(btnAction), for: [])
            }
            
            // ボタンViewに追加する
            addSubview(btn)
            
            // ボタンの追加
            portalTypeButtons.append(btn)
        }
        
        // ボタンのソート
        portalTypeButtons.sort(by: { $0.sortTag < $1.sortTag })
        
        // ボタンViewに追加する
        addButtons()
    }
    
    /// ボタンの追加
    func addButtons()  {
        
        if portalTypeButtons.count == 0 {
            return
        }
        
        for btn in portalTypeButtons {
            setupButton(btn: btn)
        }
    }
    
    /// ポータルタイプボタンの設置
    ///
    /// - Parameter btn: ポータルタイプのボタン
    func setupButton(btn: PortalTypeButton) {
        
        let col = CGFloat(btn.sortTag % columnCount)
        let marginX = (self.frame.width - btn.frame.width * 2) / 3
        
        if layoutType == PortalTypeButtonLayoutType.TwoColumnWithoutMerge {
            
            // ボタンX/Yの設定
            let x = (col + 1) * marginX + (col) * btn.frame.width
            let y = btn.sortTag < columnCount ? marginToTop : lastBtnY + lastBtnHeight + marginToTop
            
            // ボタンのOriginの設定
            let btnOrigin = CGPoint(x: x, y: y)
            btn.frame.origin = btnOrigin
            
        }else if layoutType == PortalTypeButtonLayoutType.TwoColumnWithFristMerge{
            
        }
        
        // ビューの高
        if btn.sortTag == portalTypeButtons.count - 1 {
            self.frame.size.height = btn.frame.origin.y + btn.frame.size.height + marginToBottom
        }
        
        // 上行の高とY
        if Int(col) == columnCount - 1 {
            lastBtnY = btn.frame.origin.y
            lastBtnHeight = btn.frame.height
        }
    }
}
