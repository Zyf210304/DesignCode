//
//  RingView.swift
//  DesignCode
//
//  Created by 亚飞 on 2021/1/13.
//

import SwiftUI

struct RingView: View {
    
    var color1 = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
    var color2 = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
    var width: CGFloat = 88.0
    var height: CGFloat = 88.0
    var percent: CGFloat = 88
    
    @Binding var show: Bool
    
    var body: some View {
        
        let multiplier = width / 44
        let progress = 1 -  percent / 100
        
        
        ZStack {
            
            Circle()
                .stroke(Color.black.opacity(0.1), style: StrokeStyle(lineWidth:5 * multiplier))
                .frame(width: width, height: height, alignment: .center)
                
                
            
            Circle()
                .trim(from: show ? progress : 1, to: 1)
                .stroke(LinearGradient(gradient: Gradient(colors: [Color(color1), Color(color2)]), startPoint: .topTrailing, endPoint: .bottomLeading),
                        style: StrokeStyle(lineWidth: 5 * multiplier, lineCap: .round, lineJoin: .round, miterLimit: .infinity, dash: [20, 0], dashPhase: 0)
                )
                .rotationEffect(.degrees(90))
                .rotation3DEffect(
                    .degrees(180),
                    axis: (x: 1, y: 0, z: 0.0)
                )
                .frame(width: width, height: height, alignment: .center)
                .shadow(color: Color(color2).opacity(0.1), radius: 3 * multiplier, x: 0, y: 3 * multiplier)
                .animation(Animation.easeInOut.delay(0.3))
            
            Text("\(Int(percent))%")
                .font(.system(size: 14 * multiplier))
                .fontWeight(.bold)
                .onTapGesture {
                    self.show.toggle()
                }
        }
//        .animation(.easeOut)
    }
}

struct RingView_Previews: PreviewProvider {
    static var previews: some View {
        RingView(show: .constant(true))
    }
}
