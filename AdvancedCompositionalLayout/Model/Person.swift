//
//  Person.swift
//  AdvancedCompositionalLayout
//
//  Created by Ahmed Tarık Bozyak on 30.04.2023.
//

import Foundation

enum PersonStatus {
    case online
    case offline
}

struct Person: Hashable {
    let name: String
    let surname: String
    let job: String
    let imageName: String
    let status: PersonStatus
}

extension Person {
    static var defaultData: [Self] {
        return [
            Person(name: "Hasan", surname: "Yerlikaya", job: "Director", imageName: "user1", status: .online),
            Person(name: "Mehmet", surname: "Günsur", job: "iOS Developer", imageName: "user2", status: .online),
            Person(name: "Halim", surname: "Üstündağ", job: "Android Developer", imageName: "user3", status: .offline),
            Person(name: "Meltem", surname: "Şekik", job: "UI Designer", imageName: "user4", status: .online),
            Person(name: "Kürşat", surname: "Oğuz", job: "Project Owner", imageName: "user5", status: .offline),
            Person(name: "Sergen", surname: "Ekmekçi", job: "Front-End Developer", imageName: "user6", status: .online),
            Person(name: "Serhat", surname: "İhsanoğlu", job: "Backend Developer", imageName: "user7", status: .offline),
            Person(name: "Metin", surname: "Dedeli", job: "Assistant", imageName: "user8", status: .online),
            Person(name: "Leyla", surname: "Perdeci", job: "Web Developer", imageName: "user9", status: .online),
            Person(name: "Ömer", surname: "Gallavi", job: "Lawyer", imageName: "user10", status: .online),
            Person(name: "Selim", surname: "Uncu", job: "Project Owner", imageName: "user11", status: .online),
            Person(name: "Adem", surname: "Ekşi", job: "Accountant", imageName: "user12", status: .online)
        ]
    }
}
