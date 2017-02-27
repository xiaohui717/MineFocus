//
//  PortalTypeManager.swift
//  MineFocus
//
//  Created by xiaohui.sun on 2017/2/17.
//  Copyright © 2017 pactera. All rights reserved.
//

import UIKit

/// ポータルタイプモデルの管理クラス
class PortalTypeManager {
    static let shared = PortalTypeManager()
    
    lazy var portalTypes = [PortalType]()
    
    private init(){
        loadPortalType()
    }
    
    /// ポータルタイプのロード
    func loadPortalType() {
        
        // JSON URLの取得, データのロード
        guard let jsonURL = Bundle.main.url(forResource: "PortalType.json", withExtension: nil),
              let data = try? Data(contentsOf: jsonURL) else {
            return
        }
        
        //　データのロード/反序列化
        guard let array = try? JSONSerialization.jsonObject(with: data, options: []) as? [[String: String]] else {
            return
        }
        
        //　辞書タイプからモデルに変換する
        for item in array ?? [[String: String]]() {
            
            // ボータルタイプの初期化
            let portalType = PortalType()
            
            // ボータルタイプの値の設置
            portalType.setValues(dict: item)
            
            //　ボータルタイプを配列集合に追加
            portalTypes.append(portalType)
        }
        
    }
}
