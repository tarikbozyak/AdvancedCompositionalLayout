//
//  Task.swift
//  AdvancedCompositionalLayout
//
//  Created by Ahmed Tarık Bozyak on 22.06.2023.
//

import Foundation

struct Task: Hashable {
    let id = UUID()
    let title: String
    let dueDate: String
    let progress: Double
    let personList: [Person]
}

extension Task {
    static var defaultData: [Self] {
        return [
            Task(title: "iOS Development", dueDate: "14 days", progress: 0, personList: [
                Person.defaultData[0],
                Person.defaultData[1],
                Person.defaultData[2],
            ]),
            
            Task(title: "App Design", dueDate: "3 days", progress: 0, personList: [
                Person.defaultData[3],
                Person.defaultData[4],
                Person.defaultData[5],
            ]),
            
            Task(title: "Backend Development", dueDate: "7 days", progress: 0, personList: [
                Person.defaultData[6],
                Person.defaultData[7],
                Person.defaultData[8],
            ]),
            
            Task(title: "Analysis", dueDate: "14 days", progress: 0, personList: [
                Person.defaultData[9],
                Person.defaultData[10],
                Person.defaultData[11],
            ]),
        ]
    }
    
    static var defaultData2: [Self] {
        return [
            Task(title: "iOS Development2", dueDate: "Mon, 23 Aug 2023", progress: 0.5, personList: [
                Person.defaultData[0],
                Person.defaultData[1],
                Person.defaultData[2],
            ]),
            
            Task(title: "App Design2", dueDate: "Mon, 23 Aug 2023", progress: 0.4, personList: [
                Person.defaultData[3],
                Person.defaultData[4],
                Person.defaultData[5],
            ]),
            
            Task(title: "Backend Development2", dueDate: "Mon, 23 Aug 2023", progress: 0.9, personList: [
                Person.defaultData[6],
                Person.defaultData[7],
                Person.defaultData[8],
            ]),
            
        ]
    }
    
    static var defaultData3: [Self] {
        return [
            Task(title: "iOS Development3", dueDate: "Mon, 23 Aug 2023", progress: 0.1, personList: [
                Person.defaultData[0],
                Person.defaultData[1],
                Person.defaultData[2],
            ]),
            
            Task(title: "App Design3", dueDate: "Mon, 23 Aug 2023", progress: 0.75, personList: [
                Person.defaultData[3],
                Person.defaultData[4],
                Person.defaultData[5],
            ]),
            
            Task(title: "Backend Development3", dueDate: "Mon, 23 Aug 2023", progress: 0.5, personList: [
                Person.defaultData[6],
                Person.defaultData[7],
                Person.defaultData[8],
            ]),
            
        ]
    }
    
    static var defaultData4: [Self] {
        return [
            Task(title: "iOS Development4", dueDate: "Mon, 23 Aug 2023", progress: 0.25, personList: [
                Person.defaultData[0],
                Person.defaultData[1],
                Person.defaultData[2],
            ]),
            
            Task(title: "App Design4", dueDate: "Mon, 23 Aug 2023", progress: 0.80, personList: [
                Person.defaultData[3],
                Person.defaultData[4],
                Person.defaultData[5],
            ]),
            
            Task(title: "Backend Development4", dueDate: "Mon, 23 Aug 2023", progress: 0.95, personList: [
                Person.defaultData[6],
                Person.defaultData[7],
                Person.defaultData[8],
            ]),
            
        ]
    }
    
    static var defaultData5: [Self] {
        return [
            Task(title: "iOS Development5", dueDate: "Mon, 23 Aug 2023", progress: 1, personList: [
                Person.defaultData[0],
                Person.defaultData[1],
                Person.defaultData[2],
            ]),
            
            Task(title: "App Design5", dueDate: "Mon, 23 Aug 2023", progress: 1, personList: [
                Person.defaultData[3],
                Person.defaultData[4],
                Person.defaultData[5],
            ]),
            
            Task(title: "Backend Development5", dueDate: "Mon, 23 Aug 2023", progress: 1, personList: [
                Person.defaultData[6],
                Person.defaultData[7],
                Person.defaultData[8],
            ]),
            
        ]
    }
}

