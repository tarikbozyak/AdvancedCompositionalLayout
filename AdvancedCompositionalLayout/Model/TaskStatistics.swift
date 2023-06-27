//
//  TaskStatistics.swift
//  AdvancedCompositionalLayout
//
//  Created by Ahmed Tarık Bozyak on 22.06.2023.
//

import Foundation

struct TaskStatistics: Hashable {
    let id = UUID()
    let title: String
    let subtitle: String
    let progress: Double
}

extension TaskStatistics {
    static var defaultData: [Self] {
        return [
            TaskStatistics(title: "Daily Tasks", subtitle: "Daily task subtitle here..", progress: 0.75),
            TaskStatistics(title: "Weekly Tasks", subtitle: "Weekly task subtitle here..", progress: 0.5),
            TaskStatistics(title: "Monthly Tasks", subtitle: "Monthly task subtitle here..", progress: 0.75),
            
        ]
    }
}
