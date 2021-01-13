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
    @Binding var showContent: Bool
    
    var body: some View {
        ScrollView {
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
                            .modifier(ShadowModifier())
                        
                    }.sheet(isPresented: $showUpdate, content: {
                        UpdateList()
                    })
                    
                }
                .padding(.horizontal)
                .padding(.leading, 14)
                .padding(.top, 30)
                
                ScrollView(.horizontal, showsIndicators:false) {
                    WatchRingsView()
                        .padding(.horizontal, 20)
                        .padding(.bottom, 20)
                        .onTapGesture {
                            self.showContent = true
                        }
                }
                
                
                
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
                .offset(y: -30)
                
                HStack {
                    Text("Courses")
                        .font(.title).bold()
                    Spacer()
                }
                .padding(.leading, 30)
                .offset(y: -60)
                
                SectionView(section: sectionData[2], width: screen.width - 60, height: 275)
                    .offset(y: -60)
                
                
                Spacer()
            }
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
        HomeView(showProfile: .constant(false), showContent: .constant(false))
    }
}

struct SectionView: View {
    
    var section: Section
    var width: CGFloat = 275
    var height: CGFloat = 275
    
    
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
        .frame(width: width, height: height, alignment: .center)
        .background(section.color.opacity(0.9))
        .cornerRadius(30)
        .shadow(color: section.color, radius: 20, x: 0, y: 20)
    }
}

struct WatchRingsView: View {
    var body: some View {
        HStack(spacing: 30.0) {
            HStack(spacing: 12.0) {
                
                RingView(color1: #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), color2: #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1), width: 44, height: 44, percent: 88, show: .constant(true))
                
                VStack(alignment: .leading, spacing: 4.0) {
                    Text("6 minutes left").bold().modifier(FontModifier(style: .subheadline))
                    Text("Watched 10 mins today")
                        .modifier(FontModifier(style: .caption))
                }
                .modifier(FontModifier())
                
            }.padding(8)
            .background(Color.white)
            .cornerRadius(20)
            .modifier(ShadowModifier())
            
            
            HStack(spacing: 12.0) {
                
                RingView(color1: #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1), color2: #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1), width: 32, height: 32, percent: 88, show: .constant(true))
                
            }.padding(8)
            .background(Color.white)
            .cornerRadius(20)
            .modifier(ShadowModifier())
            
            
            HStack(spacing: 12.0) {
                
                RingView(color1: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), color2: #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1), width: 32, height: 32, percent: 43, show: .constant(true))
                
            }.padding(8)
            .background(Color.white)
            .cornerRadius(20)
            .modifier(ShadowModifier())
            
        }
    }
}
