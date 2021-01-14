//
//  ContentView.swift
//  DesignCode
//
//  Created by 亚飞 on 2021/1/12.
//

import SwiftUI

struct ContentView: View {
    
    @State var show = false
    @State var viewState = CGSize.zero
    @State var showCard = false
    @State var bottomState = CGSize.zero
    @State var showFull = false
    
    var body: some View {
        ZStack {
            
            TitleView()
                .blur(radius: show ?  20 : 0)
                .opacity(showCard ? 0.4 : 1)
                .offset(y : showCard ? -200 : 0)
                .animation(
                    Animation
                        .default
                        .delay(0.1)
//                        .speed(2)
//                        .repeatCount(3, autoreverses: false)
                )
            
            BackCardView()
                .frame(width: showCard ? 300 : 340.0, height: 220.0)
                .background(show ? Color.purple: Color.yellow)
                .cornerRadius(20)
                .shadow(radius: 20)
                .offset(x: 0, y: show ? -400 : -40)
                .offset(x: viewState.width, y: viewState.height)
                .offset(y: showCard ? -180 : 0)
                .scaleEffect(showCard ? 1 : 0.9)
                .rotationEffect(.degrees(show ? 0 : 10))
                .rotationEffect(.degrees(showCard ? -10 : 0))
                .rotation3DEffect(
                    .degrees(showCard ? 0 : 5),
                    axis: (x: 1.0, y: 0.0, z: 0.0))
                .blendMode(.hardLight)
                .animation(.easeInOut(duration: 0.5))
            
            BackCardView()
                .frame(width: 340.0, height: 220.0)
                .background(show ? Color.orange: Color.pink)
                .cornerRadius(20)
                .shadow(radius: 20)
                .offset(x: 0, y: show ? -200 : -20)
                .offset(x: viewState.width, y: viewState.height)
                .offset(y: showCard ? -140 : 0)
                .scaleEffect(showCard ? 1 : 0.95)
                .rotationEffect(Angle.degrees(show ? 0 : 5))
                .rotationEffect(.degrees(showCard ? -5 : 0))
                .rotation3DEffect(
                    .degrees(showCard ? 0 : 5),
                    axis: (x: 1.0, y: 0.0, z: 0.0))
                .blendMode(.hardLight)
                .animation(.easeInOut(duration: 0.3))
            
            CardView()
                .frame(width: showCard ? 375 : 340.0, height: 220.0)
                .background(Color.black)
                .cornerRadius(20)
//                .shadow(radius: 20)
                .clipShape(RoundedRectangle(cornerRadius: showCard ? 30 : 20, style: .continuous))
                .offset(x: viewState.width, y: viewState.height)
                .offset(y: showCard ? -100 : 0)
                .blendMode(.hardLight)
                //dampingFraction 越大弹性越小
                .animation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0))
                .onTapGesture {
                    self.showCard.toggle()
                }
                .gesture(
                    DragGesture().onChanged { value in
                        self.viewState = value.translation
                        self.show = true
                    }
                    .onEnded { value in
                        self.viewState = .zero
                        self.show = false
                    }
                )
            
            Text("\(bottomState.height)").offset(y: -300)
            
            BottomCardView(show: $showCard)
                .offset(x: 0, y: showCard ? 360 : 1000)
                .blur(radius: show ?  20 : 0)
                .offset(y:bottomState.height)
                .animation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0))
                .gesture(
                    DragGesture().onChanged { value in
                        self.bottomState = value.translation
                        
                        if self.showFull {
                            self.bottomState.height += -300
                        }
                        if self.bottomState.height < -300 {
                            self.bottomState.height = -300
                        }
                        
                        
                        
                    }
                    .onEnded { value in
                        if self.bottomState.height > 50 {
                            self.showCard = false
                        }
                        if (self.bottomState.height < -100 && !self.showFull) || (self.bottomState.height < -250 && self.showFull){
                            self.bottomState.height = -300
                            self.showFull = true
                        } else {
                            self.bottomState = .zero
                            self.showFull = false
                        }
                        
                    }
                )
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CardView: View {
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("UI Design")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    Text("Certificate")
                        .foregroundColor(Color("accent"))
                }
                Spacer()
                Image("Logo")
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            Spacer()
            Image("Illustration1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 300, height: 100, alignment: .top)
        }
        
    }
}

struct BackCardView: View {
    var body: some View {
        VStack {
            Spacer()
        }
        
       
    }
}

struct TitleView: View {
    var body: some View {
        VStack {
            
            HStack {
                Text("Certificates")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
                
            }.padding()
            Image("Illustration5")
            Spacer()
        }
    }
}

struct BottomCardView: View {
    
    @Binding var show:Bool
    
    var body: some View {
        VStack(spacing: 20){
            
            Rectangle()
                .frame(width: 40, height: 5, alignment: .center)
                .cornerRadius(3.0)
                .opacity(0.1)
            
            Text("werwerasdafa as qrasdqrqasd qqwra asdqwa dasdwrrasd  qweqe sdfios sdfo sdfioswo diyg a 34asf rwerwer ")
                .multilineTextAlignment(.center)
                .font(.subheadline)
                .lineSpacing(4.0)
            

            HStack(spacing: 20) {
                RingView(color1: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), color2: #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1), width: 88, height:88, percent: 78, show: $show)
//                    .animation(Animation.easeInOut)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("SwiftUI").fontWeight(.bold)
                    Text("12 of 12 sections completed\n 10 hours spent to far")
                        .foregroundColor(.gray)
                        .lineSpacing(4)
                }
                .padding(20)
                .background(Color.white)
                .cornerRadius(20)
                .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 10 )
                
            }

           
            
            Spacer()
        }
        .padding(.top, 8)
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity)
        .background(BlurView())
        .cornerRadius(30)
        .shadow(radius: 20)
        
    }
}
