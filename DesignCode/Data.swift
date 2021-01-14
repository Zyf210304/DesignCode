//
//  Data.swift
//  DesignCode
//
//  Created by 亚飞 on 2021/1/14.
//

import SwiftUI





class  Api {
    func getPosts(completion: @escaping([Post]) ->()) {
        
        guard  let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            
            guard  let data = data else { return }
            
            let  posts = try! JSONDecoder().decode([Post].self, from: data)
            
            DispatchQueue.main.async {
                completion(posts)
            }
            
        }
        .resume()
        
    }
}





struct Features: Decodable, Hashable {
    var properties: Properties
    var geometry: Geometry
}

struct Properties: Decodable, Hashable {
    var mag: Double
    var place: String
    var time: Double
    var detail: String
    var title: String
    
}
struct Geometry: Decodable, Hashable {
    var type: String
    var coordinates: [Double]
}


struct QuakeAPIList: Decodable {
    var features: [Features]
}

class NetworkingManager : ObservableObject {
 
  
  @Published var dataList = QuakeAPIList(features: [])
  
  init() {
      guard let url = URL(string: "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/2.5_day.geojson") else {return}
      
      URLSession.shared.dataTask(with: url) {
          (data, _, _) in
          guard let data = data else {return}
          
          let dataList = try! JSONDecoder().decode(QuakeAPIList.self, from: data)
          
          DispatchQueue.main.async {
            
             print(dataList.features)
              self.dataList = dataList
              
             
              
              
          }
      }.resume()
  }
}
