//
//  HomeView.swift
//  DesignCode
//
//  Created by 张亚飞 on 2021/1/12.
//

import SwiftUI

struct HomeView: View {
    
    @Binding var showProfile: Bool
    @State var showUpdate = false
    
    
    var body: some View {
        VStack {
            HStack {
                
                Text("Watching")
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                
                Spacer()
                
                AvaterView(showProfile: $showProfile)
                
                Button(action: {
                    self.showUpdate.toggle()
                }) {
                    Image(systemName: "bell")
                        .renderingMode(.original)
                        .font(.system(size: 16, weight: .medium))
                        .frame(width: 36, height: 36, alignment: .center)
                        .background(Color.white)
                        .clipShape(Circle())
                        .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1 )
                        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 10 )
                    
                }.sheet(isPresented: $showUpdate, content: {
                    UpdateList()
                })
                
            }
            .padding(.horizontal)
            .padding(.leading, 14)
            .padding(.top, 30)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack (spacing: 20){
                    ForEach(sectionData) { section in
                        GeometryReader { geometry in
                            SectionView(section: section)
                                .rotation3DEffect(
                                    .degrees(Double(geometry.frame(in: .global).minX) / -20),
                                    axis: (x: 0.0, y: 1.0, z: 0.0),
                                    anchor: .center,
                                    anchorZ: 0.0,
                                    perspective: 1.0
                                )
                        }
                        .frame(width: 275, height: 275, alignment: .center)
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
    
    var section: Section
    
    var body: some View {
        VStack {
            HStack (alignment: .top) {
                Text(section.tiltle)
                    .font(.system(size: 24, weight: .bold, design: .default))
                    .frame(width: 160, alignment: .leading)
                    .foregroundColor(Color.white)
                
                Spacer()
                
                Image(section.logo)
                    .resizable()
                    .frame(width: 40, height: 40, alignment: .center)
            }
            
            Text(section.text.uppercased())
                .frame(maxWidth:.infinity, alignment: .leading)
            
            section.image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 210)
            
        }
        .padding(.top, 20)
        .padding(.horizontal, 20)
        .frame(width: 275, height: 275, alignment: .center)
        .background(section.color.opacity(0.9))
        .cornerRadius(30)
        .shadow(color: section.color, radius: 20, x: 0, y: 20)
    }
}
