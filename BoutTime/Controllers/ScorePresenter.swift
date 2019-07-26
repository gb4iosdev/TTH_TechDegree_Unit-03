//
//  ScorePresenter.swift
//  BoutTime
//
//  Created by Gavin Butler on 22-07-2019.
//  Copyright © 2019 Gavin Butler. All rights reserved.
//

import UIKit

protocol ScoreDisplayDelegate: class {
    func startNewGame()
}

class ScorePresenter: UIViewController {
    
    weak var mainController: ScoreDisplayDelegate?
    var roundWins: Int?
    var totalRounds: Int?
    
    @IBOutlet weak var gameScoreLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Update the UI to reflect round wins out of total rounds
        if let wins = roundWins, let totalRounds = self.totalRounds {
            gameScoreLabel.text = "\(String(wins))/\(String(totalRounds))"
        }
        
    }
    
    //Dismiss this score View Controller and call function on the main View Controller to start a new game
    @IBAction func playAgainButtonPressed(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
        mainController?.startNewGame()
        
    }
    

}
