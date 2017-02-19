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
        
        // JSON URLの取得
        let jsonURL = Bundle.main.url(forResource: "PortalType.json", withExtension: nil)
        
        // データのロード
        let data = NSData(contentsOf: jsonURL!)
        
        //　データのロード/反序列化
        guard let array = try? JSONSerialization.jsonObject(with: data as! Data, options: []) as? [[String: AnyObject]] else {
            return
        }
        
        //　辞書タイプからモデルに変換する
        for item in array! {
            let portalType: PortalType = PortalType.objectWithKeyValue(keyValue: (item as NSDictionary)) as! PortalType
            
            portalTypes.append(portalType)
        }
        
    }
}

// MARK: - NSObject+Extension
extension NSObject {
    /// 辞書タイプからモデルまでに変換する
    ///
    /// - Parameter keyValue: keyValue diction [String: AnyObject]
    /// - Returns: PortalType Model
    class func objectWithKeyValue(keyValue: NSDictionary) -> AnyObject {
        let model = self.init()
        var keyValueCount: UInt32 = 0
        let properties = class_copyPropertyList(self.classForCoder(), &keyValueCount)

        for i in 0..<Int(keyValueCount) {
            let property = properties?[i]
            guard let key = NSString(cString: property_getName(property), encoding: String.Encoding.utf8.rawValue) else {
                continue
            }
            if let value = keyValue[key] {
                model.setValue(value, forKey: key as String)
            }
        }
        return model
    }
}
