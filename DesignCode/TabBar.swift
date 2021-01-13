//
//  TabBar.swift
//  DesignCode
//
//  Created by 亚飞 on 2021/1/13.
//

import SwiftUI

struct TabBar: View {
    var body: some View {
        
        TabView {
            Home().tabItem {
                Image(systemName: "play.circle.fill")
                Text("home")
            }
            ContentView().tabItem {
                Image(systemName: "rectangle.stack.fill")
                Text("certifaicates")
            }
            
        }
        .edgesIgnoringSafeArea(.top)
        
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
