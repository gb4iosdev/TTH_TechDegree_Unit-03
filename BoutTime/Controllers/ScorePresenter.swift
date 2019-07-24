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
        
        if let wins = roundWins, let totalRounds = self.totalRounds {
            gameScoreLabel.text = "\(String(wins))/\(String(totalRounds))"
        }
        
    }
    
    
    @IBAction func playAgainButtonPressed(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
        mainController?.startNewGame()
        
    }
    

}
