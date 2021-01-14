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
    @State var posts:[Post] = []
    
    
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
            
            List(posts) { post in
                Text(post.title)
            }
            
            
            
            
        }
    }
    
    
    func startLoad() {
        
        let url = "https://jsonplaceholder.typicode.com/posts"
        ZN.GET(url: url).success { (response) in
            self.updateText("Success")
            print(response)
            do {
                try self.posts = response as! [Post]
            } catch {
                print(error)
            }
            
        }.failed { (HWNetworkingError) in
            self.updateText("Error")
        }
        
        
        
    }
    
    func updateText(_ text : String) {
            self.showText = text
    }
    
    
    
}



struct PostList_Previews: PreviewProvider {
    static var previews: some View {
        PostList()
    }
}
