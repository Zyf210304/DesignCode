//
//  Model.swift
//  DesignCode
//
//  Created by 亚飞 on 2021/1/13.
//

import Foundation
import SwiftUI

struct Section: Identifiable {
    
    var id = UUID()
    var tiltle: String
    var text: String
    var logo: String
    var image: Image
    var color: Color
    
    
}

let sectionData = [
    
    Section(tiltle: "Prototype designs in SwiftUI", text: "18 Sections", logo: "logo", image: Image(uiImage: #imageLiteral(resourceName: "Illustration1")), color: Color(#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1))),
    Section(tiltle: "Prototype designs in SwiftUI", text: "9 Sections", logo: "logo", image: Image("Illustration2"), color: Color(#colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1))),
    Section(tiltle: "Prototype designs in SwiftUI", text: "12 Sections", logo: "logo", image: Image("Illustration3"), color: Color(#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1))),
    Section(tiltle: "Prototype designs in SwiftUI", text: "77 Sections", logo: "logo", image: Image("Illustration4"), color: Color(#colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1))),
    Section(tiltle: "Prototype designs in SwiftUI", text: "34 Sections", logo: "logo", image: Image("Illustration5"), color: Color(#colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)))
    
]


