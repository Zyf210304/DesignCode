//
//  UpdateList.swift
//  DesignCode
//
//  Created by 亚飞 on 2021/1/13.
//

import SwiftUI

struct UpdateList: View {
    
    @ObservedObject var store = UpdateStore()
    
    func addUpdate() {
        store.updates.append(Update(image: "Illustration5", title: "New Item", text: "The water that bears the boat is the same that swallows it up. Every man at forty is a fool or a physician.", date: "Jue 11"))
    }
    
    var body: some View {
        
        NavigationView {
            List {
                
                ForEach(store.updates) { update in
                    NavigationLink(destination: updateDetail(update: update)) {
                        
                        HStack {
                            
                            Image(update.image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 80 , height: 80)
                                .background(Color.black)
                                .cornerRadius(20)
                                .padding(.trailing, 4)
                            
                            VStack(alignment: .leading, spacing: 8) {
                                
                                Text(update.title)
                                    .font(.system(size: 20, weight: .bold, design: .default))
                                
                                Text(update.text)
                                    .lineLimit(2)
                                    .font(.subheadline)
                                    .foregroundColor(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
                                    
                                Text(update.date)
                                    .font(.caption)
                                    .fontWeight(.bold)
                                    .foregroundColor(.secondary)
                                
                            }
                        }
                        .padding(.vertical, 8)
                        
                    }
                    
                }
                .onDelete { index in
                    self.store.updates.remove(at: index.first ?? 0)
                }
                .onMove { (source: IndexSet, destination: Int) in
                    
                    self.store.updates.move(fromOffsets: source, toOffset: destination)
                    
                }
            }
            .navigationTitle(Text("Updates"))
            .navigationBarItems(leading: Button(action: addUpdate) {
                Text("Add Update")
            }, trailing: EditButton())
        }

    }
}

struct UpdateList_Previews: PreviewProvider {
    static var previews: some View {
        UpdateList()
    }
}






struct Update: Identifiable {
    var id = UUID()
    var image: String
    var title: String
    var text: String
    var date: String
}

let updataData = [
    
    Update(image: "Illustration1", title: "SwiftUI Advanced", text: "I decide who I am.", date: "Jue 1"),
    Update(image: "Illustration2", title: "Webflow", text: "While the priest climbs a post, the devil climbs ten.", date: "Oct 17"),
    Update(image: "Illustration3", title: "ProtoPie", text: "Water dropping day by day wears the hardest rock away.", date: "June 23"),
    Update(image: "Illustration4", title: "Swift UI", text: "The water that bears the boat is the same that swallows it up. Every man at forty is a fool or a physician.", date: "Jue 11"),
    
]
