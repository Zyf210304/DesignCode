//
//  HomeView.swift
//  DesignCode
//
//  Created by 张亚飞 on 2021/1/12.
//

import SwiftUI

struct HomeView: View {
    
    @Binding var showProfile: Bool
    
    var body: some View {
        VStack {
            HStack {
                
                Text("Watching")
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                
                Spacer()
                
                AvaterView(showProfile: $showProfile)
            }
            .padding(.horizontal)
            .padding(.leading, 14)
            .padding(.top, 30)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack (spacing: 30){
                    ForEach(/*@START_MENU_TOKEN@*/0 ..< 5/*@END_MENU_TOKEN@*/) { item in
                        SectionView()
                    }
                }
                .padding(30)
                .padding(.bottom, 30)
            }
            
            
            Spacer()
        }
    }
}


struct AvaterView: View {
    
    @Binding var showProfile: Bool
    
    var body: some View {
        Button(action: {
            self.showProfile.toggle()
        }) {
            Image("Avatar")
                .renderingMode(.original)
                .resizable()
                .frame(width: 36, height: 36, alignment: .center)
                .clipShape(Circle())
            
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(showProfile: .constant(false))
    }
}

struct SectionView: View {
    var body: some View {
        VStack {
            HStack (alignment: .top) {
                Text("Prototype designs in SwiftUI")
                    .font(.system(size: 24, weight: .bold, design: .default))
                    .frame(width: 160, alignment: .leading)
                    .foregroundColor(Color.white)
                
                Spacer()
                
                Image("Logo")
                    .resizable()
                    .frame(width: 40, height: 40, alignment: .center)
            }
            
            Text("18 Sections".uppercased())
                .frame(maxWidth:.infinity, alignment: .leading)
            
            Image("Illustration1")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 210)
            
        }
        .padding(.top, 20)
        .padding(.horizontal, 20)
        .frame(width: 275, height: 275, alignment: .center)
        .background(Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)).opacity(0.5))
        .cornerRadius(30)
        .shadow(color: Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)), radius: 20, x: 0, y: 20)
    }
}
