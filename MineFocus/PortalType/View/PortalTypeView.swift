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
    let marginToBottom: CGFloat = 10
    var marginX: CGFloat = 0
    /// 前行のボタンのX
    var lastBtnY: CGFloat = 0
    
    ///　前行のボタンの高
    var lastBtnHeight: CGFloat = 0
    
    ///　前行の最初ボタンの高
    var lastRowFristBtnHeight: CGFloat = 0
    
    /// MAXボタンの横
    var maxBtnWidth: CGFloat = 0
    
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
            
            // MAXボタンの横の取得
            if btn.frame.width > maxBtnWidth {
                maxBtnWidth = btn.frame.width
            }
            // モニター関数の追加
            if let btnAction = btn.link {
                btn.addTarget(self, action: Selector(btnAction), for: [])
            }
            
            // ボタンViewに追加する
            addSubview(btn)
            
            // ボタンの追加
            portalTypeButtons.append(btn)
        }
        
        // マージンXの設置
        marginX = (self.frame.width - maxBtnWidth * 2) / 3

        // ボタンのソート
        portalTypeButtons.sort(by: { $0.sortTag < $1.sortTag })
        
        // ボタンViewに追加する
        setupButtons()
    }
    
    /// ボタンの追加
    func setupButtons()  {
        //　ボタンがない場合
        if portalTypeButtons.count == 0 {
            return
        }
        
        // ポータルタイプボタンのレイアウト
        for btn in portalTypeButtons {
            setupButton(btn: btn)
        }
    }
    
    /// ポータルタイプボタンの設置
    ///
    /// - Parameter btn: ポータルタイプのボタン
    func setupButton(btn: PortalTypeButton) {
        
        //　列数
        let col = CGFloat(btn.sortTag % columnCount)
        
//        // マージンXの設置
//        if btn.sortTag == 0 {
//            if portalTypeButtons.count > 2 {
//                if (portalTypeButtons[1] as PortalTypeButton).frame.width > btn.frame.width {
//                    marginX = (self.frame.width - (portalTypeButtons[1] as PortalTypeButton).frame.width * 2) / 3
//                }else{
//                    marginX = (self.frame.width - btn.frame.width * 2) / 3
//                }
//            }else{
//                marginX = 20
//            }
//        }
//        
        if layoutType == PortalTypeButtonLayoutType.TwoColumnWithoutMerge {
            
            // ボタンX/Yの設定
            let x = (col + 1) * marginX + (col) * maxBtnWidth
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
            if lastRowFristBtnHeight > btn.frame.height {
                lastBtnHeight = lastRowFristBtnHeight
            }else{
                lastBtnHeight = btn.frame.height
            }
            lastBtnY = btn.frame.origin.y
        }else{
            lastRowFristBtnHeight = btn.frame.height
        }
    }
}
