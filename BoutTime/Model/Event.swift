//
//  Event.swift
//  BoutTime
//
//  Created by EG1 on 8/25/18.
//  Copyright © 2018 Jun Kakeno. All rights reserved.
//

import Foundation
class  Event{
    var date:Date?
    var description: String?
    
    init(date:String, description: String){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        self.date = formatter.date(from: date)
        self.description = description
    }
}
