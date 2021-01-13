//
//  Home.swift
//  DesignCode
//
//  Created by 张亚飞 on 2021/1/12.
//

import SwiftUI

struct Home: View {
    
    
    @State var showProfile: Bool = false
    @State var viewState = CGSize.zero
    @State var showContent = false
    
    var body: some View {
        
        ZStack {
            
            Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
                .edgesIgnoringSafeArea(.all)
            
            HomeView(showProfile: $showProfile, showContent: $showContent)
                .padding(.top, 44)
                .background(
                    
                    VStack {
                        LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)), Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))]), startPoint: .top, endPoint: .bottom)
                            .frame(height: 200)
                        Spacer()
                    }
                    
                )
                .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
//                .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0.0, y: 20)
                .offset(y : showProfile ? -450 : 0)
                .rotation3DEffect(
                    .degrees(showProfile ?  Double(viewState.height / 10) - 10: 0),
                    axis: (x: 10, y: 0, z: 0.0)
                )
                .scaleEffect(showProfile ? 0.9 : 1)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                .edgesIgnoringSafeArea(.all)
            
            
            MenuView()
                .background(Color.black.opacity(0.001))
                .offset(y : showProfile ? 0 : screen.height - 20)
                .offset(y : viewState.height)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                .onTapGesture {
                    self.showProfile.toggle()
                }
                .gesture(
                    DragGesture().onChanged({ value in
                        self.viewState = value.translation
                    })
                    .onEnded({ (value) in
                        
                        if self.viewState.height > 50 {
                            self.showProfile = false
                        }
                        
                        self.viewState = .zero
                    })
                )
                
            
            
            if showContent {
                
                Color.white.edgesIgnoringSafeArea(.all)
                
                ContentView()
                    .transition(.move(edge: .top))
                    .animation(.spring(response: 0.6, dampingFraction: 0.8, blendDuration: 0))
                
                VStack {
                    HStack {
                        
                        Spacer()
                        
                        Image(systemName: "xmark")
                            .frame(width: 36, height: 36, alignment: .center)
                            .foregroundColor(.white)
                            .background(Color.black)
                            .clipShape(Circle())
                            .padding()
                            .onTapGesture {
                                self.showContent = false
                            }
                        
                    }
                    Spacer()
                }
                .transition(.move(edge: .top))
                .animation(.spring(response: 0.6, dampingFraction: 0.8, blendDuration: 0))
                

            }
                
            
        }
        
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

let screen = UIScreen.main.bounds
