//
//  NSObject+Extensions.swift
//  smflc
//
//  Created by xiaohui.sun on 2017/2/16.
//  Copyright © 2017 pactera. All rights reserved.
//

import Foundation

extension NSObject {
    
    static func pactera_ivarsList() -> NSArray{
        let ivarsKey = "com.pactera.xiaohui.MineFocus.ivarsList"
        let result = objc_getAssociatedObject(self, ivarsKey)
        
        if result != nil {
            return result as! NSArray
        }
        
        let count: UnsafeMutablePointer<UInt32> = UnsafeMutablePointer<UInt32>.allocate(capacity: 1)
        let list = class_copyIvarList(self, count)

        let  arrayM: NSMutableArray = NSMutableArray()
        for i in 0..<count.pointee{
            let ivar = list?[Int(i)]
            let cName = ivar_getName(ivar)
            let name = NSString(utf8String: cName!)
            
            arrayM.add(name ?? "")
        }
        
        free(list)
        
        objc_setAssociatedObject(self, ivarsKey, arrayM, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
        
        return objc_getAssociatedObject(self, ivarsKey) as! NSArray
    }
    
}
