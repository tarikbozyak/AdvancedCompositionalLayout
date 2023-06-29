//
//  Person.swift
//  AdvancedCompositionalLayout
//
//  Created by Ahmed Tarık Bozyak on 30.04.2023.
//

import Foundation

enum PersonJob: String, CaseIterable {
    case iOSDeveloper = "iOS Developer"
    case WebDeveloper = "Web Developer"
    case TeamLead = "Team Lead"
    case SoftwareArchitect = "Software Architect"
    case UIDesigner = "UI Designer"
    case ProductOwner = "Product Owner"
    case FrontEndDeveloper = "Front-End Developer"
    case BackendDeveloper = "Back-End Developer"
    case Director = "Director"
}

enum PersonImage: String, CaseIterable {
    case user1, user2, user3, user4, user5, user6,
         user7, user8, user9, user10, user11, user12
}

enum PersonStatus: CaseIterable {
    case online
    case offline
}

struct Person: Hashable {
    let id = UUID()
    let fullName: String
    let job: PersonJob
    let imageName: PersonImage
    let status: PersonStatus
    
    var firstName: String {
        return fullName.components(separatedBy: " ").first ?? ""
    }
    
    var lastName: String {
        return fullName.components(separatedBy: " ").last ?? ""
    }
}

extension Person {
    
    private static let firstNames = [
        "Fatma",
        "Mehmet",
        "Ayşe",
        "Mustafa",
        "Emine",
        "Ahmet",
        "Hatice",
        "Ali",
        "Zeynep",
        "Hüseyin",
        "Elif",
        "Hasan",
        "İbrahim",
        "Can",
        "Murat",
        "Özlem"
    ]
    
    private static let lastNames = [
        "Yılmaz",
        "Şahin",
        "Demir",
        "Çelik",
        "Şahin",
        "Öztürk",
        "Kılıç",
        "Arslan",
        "Taş",
        "Aksoy",
        "Barış",
        "Dalkıran"
    ]
    
    
    private static func generateRandomFullName() -> String {
        let firstNamesCount = Person.firstNames.count
        let lastNamesCount = Person.lastNames.count

        let firstName = Person.firstNames[Int.random(in: 0..<firstNamesCount)]
        let lastName = Person.lastNames[Int.random(in: 0..<lastNamesCount)]

        return "\(firstName) \(lastName)"
    }
    
    static func generateRandomPerson() -> Self {
        let fullName = generateRandomFullName()
        let job = PersonJob.allCases.randomElement()!
        let imageName = PersonImage.allCases.randomElement()!
        let status = PersonStatus.allCases.randomElement()!
        return Person(fullName: fullName, job: job, imageName: imageName, status: status)
    }
    
    static func generateRandomPersonData(numberOfData: Int) -> [Self] {
        var data = [Self]()
        for _ in 0..<numberOfData {
            data.append(generateRandomPerson())
        }
        return data
    }
}


extension Person {
    static var defaultData: [Self] {
        return [
            Person(fullName: "Hasan Yerlikaya", job: .Director, imageName: .user1, status: .online),
            Person(fullName: "Mehmet Günsur", job: .iOSDeveloper, imageName: .user2, status: .online),
            Person(fullName: "Halim Üstündağ", job: .SoftwareArchitect, imageName: .user3, status: .offline),
            Person(fullName: "Meltem Şekik", job: .UIDesigner, imageName: .user4, status: .online),
            Person(fullName: "Kürşat Oğuz", job: .ProductOwner, imageName: .user5, status: .offline),
            Person(fullName: "Sergen Ekmekçi", job: .FrontEndDeveloper, imageName: .user6, status: .online),
            Person(fullName: "Serhat İhsanoğlu", job: .BackendDeveloper, imageName: .user7, status: .offline),
            Person(fullName: "Metin Dedeli", job: .iOSDeveloper, imageName: .user8, status: .online),
            Person(fullName: "Leyla Perdeci", job: .WebDeveloper, imageName: .user9, status: .online),
            Person(fullName: "Ömer Gallavi", job: .BackendDeveloper ,imageName: .user10, status: .online),
            Person(fullName: "Selim Uncu", job: .ProductOwner, imageName: .user11, status: .online),
            Person(fullName: "Adem Ekşi", job: .BackendDeveloper, imageName: .user12, status: .online)
        ]
    }
}
