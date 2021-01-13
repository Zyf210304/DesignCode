//
//  updateDetail.swift
//  DesignCode
//
//  Created by 亚飞 on 2021/1/13.
//

import SwiftUI

struct updateDetail: View {
    
    var update: Update = updataData[0]
    
    var body: some View {
        List {
            VStack (spacing: 20){
                
                Image(update.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                    
                    
                Text(update.text)
                    .frame(maxWidth:.infinity, alignment: .leading)
                    
            }
            
        }
        .navigationBarTitle(update.title)
        .listStyle(PlainListStyle())
    }
    
}

struct updateDetail_Previews: PreviewProvider {
    static var previews: some View {
        updateDetail()
    }
}
