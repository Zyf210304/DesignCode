//
//  CourseList.swift
//  DesignCode
//
//  Created by 张亚飞 on 2021/1/13.
//

import SwiftUI

struct CourseList: View {
    
    @State var active = false
    @State var courses = courseData
    @State var activeIndex = -1
    
    var body: some View {
    
        ZStack {
            Color.black.opacity(active ? 0.5 : 0)
//                .animation(.linear)
                .edgesIgnoringSafeArea(.all)
            
            ScrollView (showsIndicators: false){
                VStack(spacing: 30) {
                    
                    Text("Courses")
                        .font(.largeTitle)
                        .bold()
                        .frame(maxWidth:.infinity, alignment: .leading)
                        .padding(.leading, 30)
                        .padding(.top, 30)
                        .blur(radius: active ? 20 : 0)
                    
                    
                    ForEach(courseData.indices, id:\.self) { index in
                        GeometryReader { geometry in
                            CourseView(
                                show: self.$courses[index].show,
                                course: self.courses[index],
                                active: self.$active,
                                index: index,
                                activeIndex: self.$activeIndex
                            )
                            .offset(y: self.courses[index].show ? -geometry.frame(in: .global).minY : 0)
                            .opacity(self.activeIndex != index && self.active ? 0 : 1)
                            .scaleEffect(self.activeIndex != index && self.active ? 0.5 : 1)
                            .offset(x: self.activeIndex != index && self.active ? screen.width : 0)
                        }
                        .frame(height: self.courses[index].show ? screen.height : 280)
                        .frame(maxWidth: self.courses[index].show ?  .infinity : screen.width - 60)
                        .zIndex(self.courses[index].show ? 1 : 0)
                        
                    }
                    
                    
                }.frame(width: screen.width)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
            }
            .statusBar(hidden: active ? true : false)
        }
//        animation(.linear)
        
    }
}

struct CourseList_Previews: PreviewProvider {
    static var previews: some View {
        CourseList()
    }
}

struct CourseView: View {
    
    @Binding var show:Bool
    var course: Course
    @Binding var active : Bool
    var index: Int
    @Binding var activeIndex:Int
    @State var activeView = CGSize.zero
    
    var body: some View {
        
        ZStack (alignment: .top){
            
            VStack(alignment: .leading, spacing: 30.0) {
                Text("Work today, for you know not how much you may be hindered tomorrow.")
                Text("About this course")
                    .font(.title)
                    .bold()
                Text("Youth means a temperamental predominance of courage over timidity, of the appetite for adventure over the love of ease. This often exists in a man of 60 more than a boy of 20. Nobody grows old merely by a number of years. We grow old by deserting our ideals.")
//                Text("Whether 60 or 16, there is in every human being’s heart the lure of wonders, the unfailing appetite for what’s next and the joy of the game of living. In the center of your heart and my heart, there is a wireless station; so long as it receives messages of beauty, hope, courage and power from man and from the infinite, so long as you are young.")
            }
            .padding(30)
            .frame(maxWidth:show ? .infinity : screen.width - 60, maxHeight: show ? screen.height : 280, alignment: .top)
            .offset(y: show ? 400 : 0)
            .background(Color.white)
            .modifier(ShadowModifier())
            .opacity(show ? 1 : 0)
            
            VStack {
                HStack(alignment: .top) {
                    VStack {
                        Text(course.title)
                            .font(.system(size: 24, weight: .bold, design: .default))
                            .foregroundColor(.white)
                        Text(course.subTitle)
                            .foregroundColor(.white)
                    }
                    Spacer()
                    ZStack {
                        Image(uiImage: #imageLiteral(resourceName: "Logo"))
                            .resizable()
                            .frame(width: 30, height: 30, alignment: .center)
                            .clipped()
                            .opacity(show ? 0 : 1)
                        
                        VStack {
                            Image(systemName: "xmark")
                                .font(.system(size: 16, weight:.medium))
                                .foregroundColor(.white)
                        }.frame(width: 30, height: 30, alignment: .center)
                        .background(Color.black.opacity(0.7))
                        .clipShape(Circle())
                        .opacity(show ? 1 : 0)
                        .onTapGesture {
                            self.show.toggle()
                        }
                    }
                }
                Spacer()
                Image(uiImage: course.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth:.infinity)
                    .frame(height:140, alignment: .top)
               
            }
            .padding(show ? 30 :20)
            .padding(.top, show ? 30 : 0)
    //        .frame(width: show ? screen.width : screen.width - 60, height: show ? screen.height : 280, alignment: .center)
            .frame(maxWidth: show ? .infinity : screen.width - 60, maxHeight: show ? 400 : 280, alignment: .center)
            .background(Color(course.color))
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: Color(course.color).opacity(0.3), radius: 20, x: 0, y: 20)
            .gesture(

                show ?
                    DragGesture().onChanged { value in
                        
                        print(value.translation.height)
                        self.activeView = value.translation

                        
                        if self.activeView.height > 15 {
                            self.show = false
                            self.active = false
                            self.activeIndex = -1
                            self.activeView = .zero
                        }
                        
                    }
                    .onEnded{ value in
                        self.activeView = .zero
                    }
                : nil

            )
            .onTapGesture {
                self.show.toggle()
                self.active.toggle()
                if self.show {
                    self.activeIndex = self.index
                } else {
                    self.activeView = .zero
                    self.activeIndex = -1
                }
            }
            
        }
        .frame(height: show ? screen.height : 280)
        .scaleEffect(1 - self.activeView.height / 100)
        .edgesIgnoringSafeArea(.all)
        .animation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0))
        
    }
}


struct Course : Identifiable {
    var id = UUID()
    var title: String
    var subTitle: String
    var image: UIImage
    var log: UIImage
    var color: UIColor
    var show: Bool
}


var courseData = [
    Course(title: "yafei 6666", subTitle: "gogogo", image: #imageLiteral(resourceName: "Illustration4"), log: #imageLiteral(resourceName: "Logo"), color:#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), show: false),
    
    Course(title: "nashei 6666", subTitle: "chong", image: #imageLiteral(resourceName: "Illustration2"), log: #imageLiteral(resourceName: "Logo"), color:#colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1), show: false),
    
    Course(title: "jiaren 6666", subTitle: "zhong", image: #imageLiteral(resourceName: "Illustration1"), log: #imageLiteral(resourceName: "Logo"), color:#colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1), show: false)
]
