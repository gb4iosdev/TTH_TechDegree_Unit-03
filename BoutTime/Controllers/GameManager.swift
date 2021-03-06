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
    var round: Int = 0
    
    //Swap events in currentRoundEvents array
    func swap(_ from: Int, with to: Int) {
        currentRoundEvents.swapAt(from - 1, to - 1)
    }
    
    //Return true & updates round wins if events are correctly ordered.  Note extracts and compares years to allow for same year ambiguity
    func eventsAreInCorrectOrder() -> Bool {
        var yearsInCorrectOrder: [Int] = []
        var yearsInUserOrder: [Int] = []
        var orderCorrect: Bool
        
        //Capture order of current Events (this represents the user's order in the UI),  Extract the years
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
    
    //shuffle allEvents, and extract eventsInRound array items & assign to currentRoundEvents
    func loadNewEvents() {
        
        EventDataSource.events.shuffle()
        currentRoundEvents.removeAll()
        currentRoundEvents = Array(EventDataSource.events.prefix(eventsInRound))
    }
    
    func isLastRound() -> Bool {
        return round == roundsInGame
    }
    
    //Return the URL object for the event, based on the event’s URL text.
    func urlForButtonGroup(_ buttonGroup: Int) -> URL? {
        return URL(string: currentRoundEvents[buttonGroup-1].url)
    }

}

enum URLError: Error {
    case invalidURL(description: String)
}
