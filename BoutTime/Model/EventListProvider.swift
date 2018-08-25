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
    
    var eventList:[Event] = []
    var randomNumber: Int = 0
    var previousNumbers: [Int] = [Int]()
    
    init(){
        eventList.append(Event(date: "1872/11/30", description: "The first international football match was played in Glasgow - 1872"))
        eventList.append(Event(date: "1902/07/20", description: "First international football match outside the British Isles - 1902"))
        eventList.append(Event(date: "1904/05/22", description: "The Fédération Internationale de Football Association (FIFA) was founded in Paris - 1904"))
        eventList.append(Event(date: "1920/08/28", description: "The world's first intercontinental football competition was held in Belgium - 1920"))
        eventList.append(Event(date: "1930/07/13", description: "The first FIFA World Cup was held in Uruguay - 1930"))
        eventList.append(Event(date: "1934/05/27", description: "First World Cup to include a qualification stage - 1934"))
        eventList.append(Event(date: "1938/06/04", description: "First time the title holders and the host country were given automatic qualification - 1938"))
        eventList.append(Event(date: "1936/08/13", description: "1942 FIFA World Cup is canceled due to WWII - 1936"))
        eventList.append(Event(date: "1946/07/01", description: "FIFA meets to discuss the future of the organization - 1946"))
        eventList.append(Event(date: "1950/06/24", description: "The FIFA World Cup resumes after WWII and it was held in Brazil - 1950"))
        eventList.append(Event(date: "1954/06/16", description: "The FIFA World Cup held in Switzerland, was the first to be televised - 1954"))
        eventList.append(Event(date: "1958/06/08", description: "Brazil became the first team to win a FIFA World Cup outside their home continent - 1958"))
        eventList.append(Event(date: "1970/06/21", description: "Brazil became the first nation to win three World Cups - 1970"))
        eventList.append(Event(date: "1974/06/13", description: "A new trophy was created for the FIFA World Cup held in West Germany - 1974"))
        eventList.append(Event(date: "1978/06/25", description: "Argentina wins the FIFA World Cup for the first time - 1978"))
        eventList.append(Event(date: "1982/06/13", description: "FIFA World Cup participants expanded to 24 teams - 1982"))
        eventList.append(Event(date: "1986/06/22", description: "Maradona scores the goal of the century at the FIFA World Cup in Mexico - 1986"))
        eventList.append(Event(date: "1990/06/08", description: "Cameroon becomes the first African nation to advanse to the FIFA World Cup quater finals - 1990"))
        eventList.append(Event(date: "1994/07/17", description: "First World Cup final to be decided on penalties - 1994"))
        eventList.append(Event(date: "1998/06/10", description: "FIFA World Cup participants expanded to 32 teams - 1998"))
        eventList.append(Event(date: "2002/05/31", description: "South Korea and Japan hosted the FIFA World Cup for the first time on Asian soil - 2002"))
        eventList.append(Event(date: "2006/06/09", description: "Germany hosted the first FIFA World Cup for which the previous winner had to qualify - 2006"))
        eventList.append(Event(date: "2010/06/11", description: "South Africa hosted the first FIFA World Cup on African soil - 2010"))
        eventList.append(Event(date: "2014/06/12", description: "Brazil hosted the FIFA World Cup for the second time - 2014"))
        eventList.append(Event(date: "2018/06/14", description: "Russia hosted the FIFA World Cup for the first time on Eastern Europe - 2018"))
    }
    
    func getEventList() -> [Event] {
        var selectedEventList:[Event]=[]
        //Repeat until event list has 4 items.
        repeat{
            selectedEventList.removeAll()
            previousNumbers.removeAll()
            //Repeat the random extraction of events from the dictionary 4 times.
            for _ in 1...4 {
                //Generate a random number, repeat until items in previous number are all unique.
                repeat {
                    randomNumber = GKRandomSource.sharedRandom().nextInt(upperBound: eventList.count)
                }while previousNumbers.contains(randomNumber)
                //Get the event from the eventList.
                if let event = eventList[randomNumber] as? Event{
                    selectedEventList.append(event)
                }
                //Store the numbers generated to keep track of the number generated.
                previousNumbers.append(randomNumber)
            }
        print(previousNumbers)
        }while selectedEventList.count<4
        //Return list of selected events.
        return selectedEventList
    }
}
