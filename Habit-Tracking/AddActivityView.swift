//
//  AddActivityView.swift
//  Habit-Tracking
//
//  Created by Varun Kumar Raghav on 01/10/21.
//

import SwiftUI

struct AddActivityView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var activities: Activities
    
    @State private var activityName = ""
    @State private var description = ""
    @State private var completionCount = 0
    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("Enter name of habit")){
                    TextField("Name", text: $activityName)
                }
                Section(header: Text("Enter details of activity")){
                    TextField("Description", text: $description)
                }
                Section(header: Text("Completed Times")){
                    Stepper(value: $completionCount, in: 0...Int.max, step: 1){
                        Text("\(completionCount) times.")
                    }
                }
            }.navigationTitle("Add Activities")
            .navigationBarItems(trailing: Button("Save"){
                self.addItem()
                self.presentationMode.wrappedValue.dismiss()
            })
        }
    }
    func addItem() {
        let item = Activity(id: self.activityName, activityName: self.activityName, description: self.description, activityCompletionCount: self.completionCount)
        if item.activityName.isEmpty || item.description.isEmpty {
            return
        }
        if isAlreadyExist(item: item){
            return
        }
        activities.items.append(item)
        activities.saveActivities()
    }
    func isAlreadyExist(item: Activity) -> Bool {
        if activities.items.contains(item){
            return true
        }
        else{
            return false
        }
    }
}

struct AddActivityView_Previews: PreviewProvider {
    static var previews: some View {
        AddActivityView(activities: Activities())
    }
}
