//
//  PostList.swift
//  DesignCode
//
//  Created by 亚飞 on 2021/1/14.
//

import SwiftUI
import Alamofire


struct PostList: View {
    

    @State private var showText = ""
        
    var body: some View {
        VStack {
            
            Text(showText).font(.title)
            
            Button(action: {
                self.startLoad()
                
            }) {
                Text("Start").font(.largeTitle)
            }
            
            Button(action: {
                self.showText = ""
            }) {
                Text("Clear").font(.largeTitle)
            }
            
        }
    }
    
    
    func startLoad() {
        
        let url = "https://jsonplaceholder.typicode.com/posts"
        ZN.GET(url: url).success { (response) in
            print("Success")
            print(response)
        }.failed { (HWNetworkingError) in
            print("Error")
            print(HWNetworkingError)
        }
        
        
        
    }
    
    func updateText(_ text : String) {
            self.showText = text
    }
    
    
    
}



//struct PostList_Previews: PreviewProvider {
//    static var previews: some View {
//        PostList()
//    }
//}
