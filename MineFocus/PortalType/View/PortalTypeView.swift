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
    
    // ボタンX
    var x: CGFloat = 0
    
    // ボタンY
    var y: CGFloat = 0
    
    //　列数
    var col: CGFloat = 0
    
    /// ビューの初期化
    ///
    /// - Parameters:
    ///   - frame: ヴューのフレーム
    ///   - layoutType: ボタンのレイアウト
    init(frame: CGRect, layoutType: PortalTypeButtonLayoutType) {
        
        //　スーパーのオーバーレイド
        super.init(frame: frame)
        
        // ボタンレイアウトの設置
        self.layoutType = layoutType
        
        // ニューの設置
        setupUI()
    }
    
    
    /// 初期化のオーバーレイド
    ///
    /// - Parameter frame: ヴューのフレーム
    override init(frame: CGRect){
        
        //　スーパーのオーバーレイド
        super.init(frame: frame)
        
        // ニューの設置
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// レサイズサーバビューのオーバーレイド
    override func layoutSubviews() {
        
        //　ボタンのレイアウト
        setupButtons()
    }
    
    /// ニューの設置
    func setupUI() {
        
        // オートレサイズビューの設置
        self.autoresizesSubviews = false
        
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
        
    }
    
    /// ボタンのレイアウトの設置
    func setupButtons()  {
        //　ボタンがない場合
        if portalTypeButtons.count == 0 {
            return
        }
        
        // ポータルタイプボタンのレイアウト
        for btn in portalTypeButtons {
            
            switch layoutType {
            case PortalTypeButtonLayoutType.TwoColumnWithoutMerge:
                
                // TwoColumnWithoutMergeのレイアウト
                setupButtonWithoutMerge(btn: btn)
                break
            case PortalTypeButtonLayoutType.TwoColumnWithFristMerge:
                
                // TwoColumnWithFristMergeのレイアウト
                setupButtonWithFirstMerge(btn: btn)
                break
            }
        }
    }
    
    /// ポータルタイプボタンの設置(TwoColumnWithoutMerge)
    ///
    /// - Parameter btn: ポータルタイプのボタン
    func setupButtonWithoutMerge(btn: PortalTypeButton) {
        
        //　列数
        col = CGFloat(btn.sortTag % columnCount)
        
        // ボタンをレイアウト
        layoutButton(btn: btn)
    }
    
    /// ポータルタイプボタンの設置(TwoColumnWithFristMerge)
    ///
    /// - Parameter btn: ポータルタイプのボタン
    func setupButtonWithFirstMerge(btn: PortalTypeButton) {
        
        //　列数
        if btn.sortTag == 0 || btn.sortTag == 1 {
            col = CGFloat(btn.sortTag % columnCount)
        }else{
            col = CGFloat((btn.sortTag + 1) % columnCount)
        }
        
        // ボタンをレイアウト
        layoutButton(btn: btn)
    }
    
    /// ボタンをレイアウト
    ///
    /// - Parameter btn: ポータルタイプのボタン
    func layoutButton(btn: PortalTypeButton) {
        // ボタンX/Yの設定
        x = (col + 1) * marginX + (col) * maxBtnWidth
        y = btn.sortTag < columnCount ? marginToTop : lastBtnY + lastBtnHeight + marginToTop
        
        // ボタンのOriginの設定
        let btnOrigin = CGPoint(x: x, y: y)
        btn.frame.origin = btnOrigin
        
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
            lastRowFristBtnHeight = 0
        }else{
            lastRowFristBtnHeight = btn.frame.height
        }
    }
}
