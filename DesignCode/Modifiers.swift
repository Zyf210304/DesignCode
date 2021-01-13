//
//  Modifiers.swift
//  DesignCode
//
//  Created by 亚飞 on 2021/1/13.
//

import SwiftUI
 
struct ShadowModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 10 )
            .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1 )
    }
    
}

struct FontModifier: ViewModifier {
    
    var style: Font.TextStyle = .body
    
    func body(content: Content) -> some View {
        content
            .font(.system(style, design: .rounded))
    }
    
}

