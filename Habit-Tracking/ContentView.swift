//
//  ContentView.swift
//  Habit-Tracking
//
//  Created by Varun Kumar Raghav on 01/10/21.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var activities = Activities()
    @State private var showingAddActivity = false
    
    var body: some View {
        NavigationView{
            List{
                ForEach(activities.items, id: \.id){ item in
                    NavigationLink(destination: ActivityDetailView(activities: activities, activity: item)){
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.activityName)
                                    .font(.headline)
                                Text(item.description)
                            }
                            Spacer()
                            Text("\(item.activityCompletionCount)")
                        }
                    }
                }.onDelete(perform: removeItems)
            }.navigationTitle("Habits")
            .navigationBarItems(trailing: Button("Add Activity"){
                self.showingAddActivity = true
            })
            .sheet(isPresented: $showingAddActivity){
                AddActivityView(activities: self.activities)
            }
        }
    }
    func removeItems(at offsets: IndexSet) {
        activities.items.remove(atOffsets: offsets)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
