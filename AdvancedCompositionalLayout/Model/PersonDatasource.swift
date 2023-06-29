//
//  PersonDatasource.swift
//  AdvancedCompositionalLayout
//
//  Created by Ahmed Tarık Bozyak on 28.06.2023.
//

import Foundation

public class FetchResponse {
    let person: [Person]
    let next: String?
    
    init(people: [Person], next: String?) {
        self.person = people
        self.next = next
    }
}


public class FetchError {
    let errorDescription: String
    
    init(description: String) {
        self.errorDescription = description
    }
}

public typealias FetchCompletionHandler = (FetchResponse?, FetchError?) -> ()


public class PersonDatasource {

    private struct Constants {
        static let peopleCountRange: ClosedRange<Int> = 100...200 // lower bound must be > 0
        static let fetchCountRange: ClosedRange<Int> = 5...20 // lower bound must be > 0
        static let lowWaitTimeRange: ClosedRange<Double> = 0.0...0.3 // lower bound must be >= 0.0
        static let highWaitTimeRange: ClosedRange<Double> = 1.0...2.0 // lower bound must be >= 0.0
        static let errorProbability = 0.25 // must be > 0.0
        static let backendBugTriggerProbability = 0.25 // must be > 0.0
        static let emptyFirstResultsProbability = 0.1 // must be > 0.0
    }

    private static var people: [Person] = []
    private static let operationsQueue = DispatchQueue.init(
        label: "data_source_operations_queue",
        qos: .userInitiated,
        attributes: [],
        autoreleaseFrequency: .inherit,
        target: nil
    )
    
    public class func fetch(next: String?, _ completionHandler: @escaping FetchCompletionHandler) {
        DispatchQueue.global().async {
            operationsQueue.sync {
                initializeDataIfNecessary()
                let (response, error, waitTime) = processRequest(next)
                DispatchQueue.main.asyncAfter(deadline: .now() + waitTime) {
                    completionHandler(response, error)
                }
            }
        }
    }
    
    private class func initializeDataIfNecessary() {
        guard people.isEmpty else { return }
        people = Person.generateRandomPersonData(numberOfData: Int.random(in: Constants.peopleCountRange)).shuffled()
    }
    
    private class func processRequest(_ next: String?) -> (FetchResponse?, FetchError?, Double) {
        var error: FetchError? = nil
        var response: FetchResponse? = nil
        let isError = RandomUtils.roll(forProbabilityGTZero: Constants.errorProbability)
        var waitTime: Double!
        
        if isError {
            waitTime = RandomUtils.generateRandomDouble(inClosedRange: Constants.lowWaitTimeRange)
            error = FetchError(description: "Internal Server Error")
        }
        else {
            waitTime = RandomUtils.generateRandomDouble(inClosedRange: Constants.highWaitTimeRange)
            let fetchCount = RandomUtils.generateRandomInt(inClosedRange: Constants.fetchCountRange)
            let peopleCount = people.count

            if let next = next, (Int(next) == nil || Int(next)! < 0) {
                error = FetchError(description: "Parameter error")
            }
            else {
                let endIndex: Int = min(peopleCount, fetchCount + (next == nil ? 0 : (Int(next!) ?? 0)))
                let beginIndex: Int = next == nil ? 0 : min(Int(next!)!, endIndex)
                var responseNext: String? = endIndex >= peopleCount ? nil : String(endIndex)
                
                var fetchedPeople: [Person] = Array(people[beginIndex..<endIndex])
                if beginIndex > 0 && RandomUtils.roll(forProbabilityGTZero: Constants.backendBugTriggerProbability) {
                    error = FetchError(description: "Backend Error!")
                }
                else if beginIndex == 0 && RandomUtils.roll(forProbabilityGTZero: Constants.emptyFirstResultsProbability) {
                    fetchedPeople = []
                    responseNext = nil
                }
                response = FetchResponse(people: fetchedPeople,
                                           next: responseNext)
            }
        }

        return (response, error, waitTime)
    }
    
}

//Util
fileprivate class RandomUtils {
    

    class func generateRandomInt(inClosedRange range: ClosedRange<Int>) -> Int {
        return Int.random(in: range)
    }

    class func generateRandomInt(inRange range: Range<Int>) -> Int {
        return Int.random(in: range)
    }

    
    class func generateRandomDouble(inClosedRange range: ClosedRange<Double>) -> Double {
        return Double.random(in: range)
    }
    
    class func roll(forProbabilityGTZero probability: Double) -> Bool {
        let random = Double.random(in: 0.0...1.0)
        return random <= probability
    }
}
