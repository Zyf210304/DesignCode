//
//  CourseDetail.swift
//  DesignCode
//
//  Created by 亚飞 on 2021/1/14.
//

import SwiftUI

struct CourseDetail: View {
    
    var course: Course
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct CourseDetail_Previews: PreviewProvider {
    static var previews: some View {
        CourseDetail(course: courseData[0])
    }
}
