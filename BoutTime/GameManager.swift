//
//  GameManager.swift
//  BoutTime
//
//  Created by Gavin Butler on 20-07-2019.
//  Copyright © 2019 Gavin Butler. All rights reserved.
//

import Foundation

class GameManager {
    
    private let eventsInRound = 4
    var currentRoundEvents: [Event] = []
    
    func swap(fromTo: (Int, Int)) {
        print("Performing Swap from: \(fromTo.0) to \(fromTo.1).  Events Count: \(currentRoundEvents.count)")
        let tempItem = currentRoundEvents.remove(at: fromTo.0-1)
        currentRoundEvents.insert(tempItem, at: fromTo.1-1)
    }
    
    func isCorrectOrder() -> Bool {
        var yearsInCorrectOrder: [Int] = []
        var yearsInUserOrder: [Int] = []
        
        //Capture order of current Events (this represents the user's order in the UI
        for event in currentRoundEvents {
            yearsInUserOrder.append(event.year)
        }
        
        //Copy to yearsInCorrectOrder array & sort into correct order
        yearsInCorrectOrder = yearsInUserOrder
        yearsInCorrectOrder.sort { $0 < $1 }
        
        return yearsInCorrectOrder.elementsEqual(yearsInUserOrder)
    }
    
    func nextRound() {
        //shuffle allEvents and extract eventsInRound array items & assign to currentRoundEvents & the same to currentRoundUserOrdered
        EventDataSource.events.shuffle()
        currentRoundEvents.removeAll()
        currentRoundEvents = Array(EventDataSource.events.prefix(eventsInRound))
    }
    
    

}
