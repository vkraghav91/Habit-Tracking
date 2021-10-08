//
//  ActivityDetailView.swift
//  Habit-Tracking
//
//  Created by Varun Kumar Raghav on 01/10/21.
//

import SwiftUI

struct ActivityDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var activities: Activities
    
    @State private var activityCompletionCount = 0
    var activity: Activity
    var body: some View {
        Form{
            Section(header:Text("Activity Name")){
                Text(activity.activityName)
            }
            Section(header: Text("Activity Description")){
                Text(activity.description)
            }
            Section(header: Text("Completed Times")){
                Stepper(value: $activityCompletionCount, in: 0...Int.max, step: 1){
                    Text("\(activityCompletionCount) times.")
                }
            }
            
        }.navigationBarTitle("Activity Details")
        .navigationBarItems(trailing: Button("Save"){
            self.saveActivity()
            self.presentationMode.wrappedValue.dismiss()
        })
        .onAppear(){
            self.activityCompletionCount = activity.activityCompletionCount
        }
        
    }
    func saveActivity() {
        if let indexItem = self.activities.items.firstIndex(where: {(item) -> Bool in
            item == self.activity
        }){
            let tempActivity = Activity(id: self.activity.activityName, activityName: self.activity.activityName, description: self.activity.description, activityCompletionCount: self.activityCompletionCount)
            self.activities.items.remove(at: indexItem)
            self.activities.items.insert(tempActivity, at: indexItem)
            self.activities.saveActivities()
            
        }
    }
}

struct ActivityDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityDetailView(activities: Activities(), activity: Activity(id: "Name", activityName: "Name", description: "Description", activityCompletionCount: 0))
    }
}
