//
//  CountryModel.swift
//  AdvancedCompositionalLayout
//
//  Created by Ahmed Tarık Bozyak on 27.05.2023.
//

import Foundation
import UIKit

struct Country: Hashable {
    let name: String
    let capital: String
    let continent: Continent
    let flag: String
}

enum Continent: String{
    case Africa
    case Antarctica
    case Asia
    case Europe
    case Oceania
    case NourthAmerica = "Nourth America"
    case SouthAmerica = "South America"
}

extension Country {
    static func getAllCountry() -> [Country] {
        return [
            Country(name: "Turkey", capital: "Ankara", continent: .Asia, flag: "🇹🇷"),
            Country(name: "China", capital: "Beijing", continent: .Asia, flag: "🇨🇳"),
            Country(name: "France", capital: "Paris", continent: .Europe, flag: "🇫🇷"),
            Country(name: "Germany", capital: "Berlin", continent: .Europe, flag: "🇩🇪"),
            Country(name: "United Kingdom", capital: "London", continent: .Europe, flag: "🇬🇧"),
            Country(name: "United States of America", capital: "Washington", continent: .NourthAmerica, flag: "🇺🇸"),
            Country(name: "Canada", capital: "Ottawa", continent: .NourthAmerica, flag: "🇨🇦"),
            Country(name: "Puerto Rico", capital: "San Juan", continent: .NourthAmerica, flag: "🇵🇷"),
            Country(name: "Belgium", capital: "Brussels", continent: .Europe, flag: "🇧🇪"),
            Country(name: "Saudi Arabia", capital: "Riyadh", continent: .Asia, flag: "🇸🇦"),
            Country(name: "Qatar", capital: "Doha", continent: .Asia, flag: "🇶🇦"),
            Country(name: "India", capital: "New Delhi", continent: .Asia, flag: "🇮🇳"),
            Country(name: "Pakistan", capital: "Islamabad", continent: .Asia, flag: "🇵🇰"),
            Country(name: "Brazil", capital: "Brasil", continent: .SouthAmerica, flag: "🇧🇷"),
            Country(name: "Peru", capital: "Lima", continent: .SouthAmerica, flag: "🇵🇪"),
            Country(name: "Chile", capital: "Santiago", continent: .SouthAmerica, flag: "🇨🇱"),
            Country(name: "Bolivia", capital: "Sucre", continent: .SouthAmerica, flag: "🇧🇴"),
            Country(name: "South Georgia", capital: "King Edward Point", continent: .Antarctica, flag: "🇬🇸"),
            Country(name: "Papua New Guinea", capital: "Port Moresb", continent: .Oceania, flag: "🇵🇬"),
            Country(name: "Marshall Islands", capital: "Majuro", continent: .Oceania, flag: "🇲🇭")
        ]
    }
}
