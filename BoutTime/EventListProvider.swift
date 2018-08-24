//
//  PlistConverter.swift
//  BoutTime
//
//  Created by EG1 on 8/22/18.
//  Copyright © 2018 Jun Kakeno. All rights reserved.
//

import Foundation
//Imported to use GKRandomSource
import GameKit


class EventListProvider{
    var dictionary:[String:String]=[:]
    
    
    var randomNumber: Int = 0
    var previousNumbers: [Int] = [Int]()
    
    enum PlistError: Error {
        case invalidResource
        case conversionFailure
    }
    init(){
        
    }
    //Create a dictionary from the plist.
    func loadEventList(fromFile name: String, ofType type: String) throws {
        //Get the path to the plist.
        guard let path = Bundle.main.path(forResource: name, ofType: type) else {
            throw PlistError.invalidResource
        }
        //Convert the plist file to a dictionary.
        guard let dictionary = NSDictionary(contentsOfFile: path) as? [String: String] else {
            throw PlistError.conversionFailure
        }
        self.dictionary=dictionary
    }
    
    func getEventList() -> [String] {
        var eventList:[String]=[]
        //Repeat until event list has 4 items. Beacuse sharedRandom regerates 0 and there's no 0 key in the dictionary.
        repeat{
            eventList.removeAll()
            previousNumbers.removeAll()
            //Repeat the random extraction of events from the dictionary 4 times.
            for _ in 1...4 {
                //Generate a random number, repeat until items in previous number are all unique.
                repeat {
                    randomNumber = GKRandomSource.sharedRandom().nextInt(upperBound: dictionary.count)
                }while previousNumbers.contains(randomNumber)
                //Get the value from the dictionary.
                if let value = dictionary["\(randomNumber)"]{
                    eventList.append(value)
                }
                //Store the numbers generated to keep track of the number generated.
                previousNumbers.append(randomNumber)
            }
        print(previousNumbers)
        }while eventList.count<4
        //Return the dictionary with the list of events.
        return eventList
    }
    
    //Call this after calling getEventList().
    func getSortedEventList()-> [String]{
        var sortedEventList:[String]=[]
        let sortedKeyList = previousNumbers.sorted(by: <)
        for key in sortedKeyList{
            //Get the value from the dictionary.
            if let value = dictionary["\(key)"]{
                sortedEventList.append(value)
            }
        }
        return sortedEventList
    }
}
