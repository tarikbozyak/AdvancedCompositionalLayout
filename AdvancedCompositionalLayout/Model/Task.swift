//
//  Task.swift
//  AdvancedCompositionalLayout
//
//  Created by Ahmed Tarık Bozyak on 22.06.2023.
//

import Foundation

struct Task: Hashable {
    let id = UUID()
    let name: String
    let estimated: String
    let personList: [Person]
}

extension Task {
    static var defaultData: [Self] {
        return [
            Task(name: "iOS Development", estimated: "14 days", personList: [
                Person.defaultData[0],
                Person.defaultData[1],
                Person.defaultData[2],
            ]),
            
            Task(name: "App Design", estimated: "3 days", personList: [
                Person.defaultData[3],
                Person.defaultData[4],
                Person.defaultData[5],
            ]),
            
            Task(name: "Backend Development", estimated: "7 days", personList: [
                Person.defaultData[6],
                Person.defaultData[7],
                Person.defaultData[8],
            ]),
            
            Task(name: "Analysis", estimated: "14 days", personList: [
                Person.defaultData[9],
                Person.defaultData[10],
                Person.defaultData[11],
            ]),
        ]
    }
}

