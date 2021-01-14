//
//  YFNetworkingError.swift
//  DesignCode
//
//  Created by 亚飞 on 2021/1/14.
//

import Foundation

public class YFNetworkingError: NSObject {
    ///错误码
    @objc var code = -1
    
    ///错描述
    @objc var localizedDescription: String
    
    init(code:Int, desc: String) {
        self.code = code
        self.localizedDescription = desc
        super.init()
    }
    
}
