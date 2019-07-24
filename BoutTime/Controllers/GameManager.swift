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
    let roundsInGame = 6
    var currentRoundEvents: [Event] = []
    var roundWins: Int = 0
    var round: Int = 1
    
    func swap(fromTo: (Int, Int)) {
        print("Performing Swap from: \(fromTo.0) to \(fromTo.1).  Events Count: \(currentRoundEvents.count)")
        let tempItem = currentRoundEvents.remove(at: fromTo.0-1)
        currentRoundEvents.insert(tempItem, at: fromTo.1-1)
    }
    
    func eventsAreInCorrectOrder() -> Bool {
        var yearsInCorrectOrder: [Int] = []
        var yearsInUserOrder: [Int] = []
        var orderCorrect: Bool
        
        //Capture order of current Events (this represents the user's order in the UI
        for event in currentRoundEvents {
            yearsInUserOrder.append(event.year)
        }
        
        //Copy to yearsInCorrectOrder array & sort into correct order
        yearsInCorrectOrder = yearsInUserOrder
        yearsInCorrectOrder.sort { $0 < $1 }
        
        orderCorrect = yearsInCorrectOrder.elementsEqual(yearsInUserOrder)
        
        //If the ordering is correct, increment the round wins
        if orderCorrect {
            roundWins += 1
        }
        
        return orderCorrect
    }
    
    func nextRound() {
        loadNewEvents()
        round += 1
    }
    
    func newGame() {
        round = 0
        roundWins = 0
    }
    
    func loadNewEvents() {
        //shuffle allEvents and extract eventsInRound array items & assign to currentRoundEvents
        EventDataSource.events.shuffle()
        currentRoundEvents.removeAll()
        currentRoundEvents = Array(EventDataSource.events.prefix(eventsInRound))
    }
    
    func isLastRound() -> Bool {
        return round == roundsInGame
    }
    
    func urlForButtonGroup(_ buttonGroup: Int) -> URL? {
        return URL(string: currentRoundEvents[buttonGroup-1].url)
    }

}
