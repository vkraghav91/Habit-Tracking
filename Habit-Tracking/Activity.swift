//
//  Activity.swift
//  Habit-Tracking
//
//  Created by Varun Kumar Raghav on 01/10/21.
//

import Foundation

class Activities: ObservableObject {
    @Published var items :[Activity]{
        didSet{
            print("run Did Set")
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(items){
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let items = UserDefaults.standard.data(forKey: "Items"){
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([Activity].self, from: items){
                self.items = decoded
                return
            }
        }
        self.items = []
    }
    
    func saveActivities() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(items){
            UserDefaults.standard.set(encoded, forKey: "Items")
            
        }
    }
    
}

struct Activity: Codable, Equatable{
    //   let id = UUID()
    let id: String
    let activityName: String
    let description: String
    let activityCompletionCount: Int
    
    
    static func == (lhs: Activity, rhs: Activity) -> Bool{
        return lhs.id == rhs.id
    }
}
