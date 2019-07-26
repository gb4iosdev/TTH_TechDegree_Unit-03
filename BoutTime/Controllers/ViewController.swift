//
//  ViewController.swift
//  BoutTime
//
//  Created by Gavin Butler on 19-07-2019.
//  Copyright © 2019 Gavin Butler. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var eventDisplayButton1: UIButton!
    @IBOutlet weak var eventDisplayButton2: UIButton!
    @IBOutlet weak var eventDisplayButton3: UIButton!
    @IBOutlet weak var eventDisplayButton4: UIButton!
    
    
    @IBOutlet weak var button1Down: UIButton!
    @IBOutlet weak var button2Up:   UIButton!
    @IBOutlet weak var button2Down: UIButton!
    @IBOutlet weak var button3Up:   UIButton!
    @IBOutlet weak var button3Down: UIButton!
    @IBOutlet weak var button4Up:   UIButton!
    
    @IBOutlet weak var nextRoundButton: UIButton!
    @IBOutlet weak var instructionLabel: UILabel!
    @IBOutlet weak var timerOutputLabel: UILabel!
    @IBOutlet weak var checkScoreButton: UIButton!
    
    
    // MARK: - Convenience Collections
    var buttonGroup1: [UIButton] = []
    var buttonGroup2: [UIButton] = []
    var buttonGroup3: [UIButton] = []
    var buttonGroup4: [UIButton] = []
    
    var allButtonGroups: [[UIButton]] = []

    // MARK: - General Variables
    let debug = true    //Make the event's year visible
    var buttonRoundedRadius = 15
    var timerMax = 60
    var timerCount = 60 {
        didSet {
            if timerCount == 60 {
                timerOutputLabel.text = "01:00"
            } else {
            timerOutputLabel.text = "00:" + String(timerCount)
            }
        }
    }
    
    
    var timer = Timer()
    
    // MARK: - External Classes
    var gameManager = GameManager()
    var soundPlayer = SoundPlayer()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Group the buttons into arrays for convenience
        initializeButtonCollections()
        
        //Pre-load game sound effects
        soundPlayer.loadAnswerSounds()
        
        //Initialize UI
        setMoveButtonSelectionImages()
        roundDisplayButtonCorners()
        
        //Start the game
        nextRound()
        
    }
    
    //MARK: - Round is in Play
    
    func nextRound() {
        
        gameManager.nextRound()
        
        displayEvents()
        
        // Rest the timer
        timerCount = timerMax
        startTimer()
        
        //Reset the UI
        instructionLabel.text = "Shake to Complete"
        nextRoundButton.isHidden = true
        checkScoreButton.isHidden = true
        timerOutputLabel.isHidden = false
        
        //Enable the move buttons
        changeButtonState(for: .move, toState: .active)
        
        //Disable the event display buttons
        changeButtonState(for: .display, toState: .inactive)
        
    }
    
    // Load the current event titles into the display buttons
    func displayEvents() {
        
        for (index, buttonGroup) in allButtonGroups.enumerated() {
            let debugText = debug ? String(gameManager.currentRoundEvents[index].year) + ": " : ""
            buttonGroup[0].setTitle(debugText + gameManager.currentRoundEvents[index].title, for: .normal)
            buttonGroup[0].titleLabel?.numberOfLines = 0
            //buttonGroup[0].titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping  //Check if this is required???
        }
        
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            //update timer output label
            self.timerCount -= 1
            
            if self.timerCount == 0 {
                
                //Stop the timer & hide label
                timer.invalidate()
                self.timerOutputLabel.isHidden = true
                
                
                //Check game status
                self.checkStatusForRound()
                
            }
        }
    }
    
    //When a move button is pressed, reflect the change in the gameManager event list and update the UI
    @IBAction func moveButtonPressed(_ sender: UIButton) {
        
        //Determine displayButton from/to
        guard let fromTo: (fromDisplayButtonNumber: Int, toDisplayButtonNumber: Int) = getFromToButtonIDsFor(sender) else { return }
        
        gameManager.swap(fromTo: fromTo)
        
        //Refresh the UI
        
        displayEvents()
        
    }
    
    
    //MARK: - Round Stopped
    
    //Detect Shake Gesture
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        
        guard timer.isValid else { return }             //Only proceed if the play is live (timer is still running)
        guard motion == .motionShake else { return }    //Should only respond to shake
        
        //Stop the timer & hide label
        timer.invalidate()
        timerOutputLabel.isHidden = true
        
        //Check the answers:
        checkStatusForRound()
    }
    
    //Check the event ordering, freeze move buttons, enable web function for display buttons
    func checkStatusForRound() {
        
        var nextRoundImageName: String
        var checkScoreImageName: String
        
        //Disable the move buttons
        changeButtonState(for: .move, toState: .inactive)
        
        //Enable the event display buttons
        changeButtonState(for: .display, toState: .active)
        
        //Check the results & set UI accordingly
        let correctOrder: Bool = gameManager.eventsAreInCorrectOrder()
        
        if correctOrder {
            soundPlayer.playCorrectAnswerSound()
            nextRoundImageName = "next_round_success"
            checkScoreImageName = "checkScore_success"
        } else {
            soundPlayer.playIncorrectAnswerSound()
            nextRoundImageName = "next_round_fail"
            checkScoreImageName = "checkScore_fail"
        }
        
        //Check if this is the last round
        if gameManager.isLastRound() {
            checkScoreButton.setImage(UIImage(named: checkScoreImageName), for: .normal)
            checkScoreButton.isHidden = false
            
        } else {
            nextRoundButton.setImage(UIImage(named: nextRoundImageName), for: .normal)
            nextRoundButton.isHidden = false
        }
        
        instructionLabel.text = "Tap events to learn more"
    }

    //Show web page for event when display button is pressed
    @IBAction func displayButtonPressed(_ sender: UIButton) {
        
        if let url = gameManager.urlForButtonGroup(sender.tag) {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func nextRoundButtonPressed(_ sender: UIButton) {
        
        nextRound()
    }
    
    
    //MARK: - Helper Functions
    
    //Add buttons to convenience collections with display button first in each array
    func initializeButtonCollections() {
        buttonGroup1 = [eventDisplayButton1, button1Down]
        buttonGroup2 = [eventDisplayButton2, button2Up, button2Down]
        buttonGroup3 = [eventDisplayButton3, button3Up, button3Down]
        buttonGroup4 = [eventDisplayButton4, button4Up]
        allButtonGroups = [buttonGroup1, buttonGroup2, buttonGroup3, buttonGroup4]
    }
    
    //Based on button pressed, determine which button groups the event needs to transfer from/to
    func getFromToButtonIDsFor(_ button: UIButton) -> (Int, Int)? {
        //Given the move button pressed, return the implied from button and to display button numbers
        switch button {
        case button1Down:   return (1,2)
        case button2Up:     return (2,1)
        case button2Down:   return (2,3)
        case button3Up:     return (3,2)
        case button3Down:   return (3,4)
        case button4Up:     return (4,3)
        default: return nil
        }
    }
    
    //Set button images for selected state
    func setMoveButtonSelectionImages() {
        button1Down.setImage(UIImage(named: "down_full_selected"),  for: .selected)
        button2Up.setImage  (UIImage(named: "up_half_selected"),    for: .selected)
        button2Down.setImage(UIImage(named: "down_half_selected"),  for: .selected)
        button3Up.setImage  (UIImage(named: "up_half_selected"),    for: .selected)
        button3Down.setImage(UIImage(named: "down_half_selected"),  for: .selected)
        button4Up.setImage  (UIImage(named: "up_full_selected"),    for: .selected)
    }
    
    // Round the top left and bottom left corners of the display buttons in order to match the arrow buttons
    func roundDisplayButtonCorners() {
        for buttonGroup in allButtonGroups {
            let path = UIBezierPath(roundedRect: buttonGroup[0].bounds, byRoundingCorners: [.topLeft, .bottomLeft], cornerRadii: CGSize(width: 5, height: 5))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            buttonGroup[0].layer.mask = mask
        }
    }
    
    //Enable/Disable move and display buttons to support the game state
    func changeButtonState(for buttonType: ButtonType, toState state: ButtonState) {
        
        var isEnabled: Bool = false
        
        if state == .active {
            isEnabled = true
        }
        
        for buttonGroup in allButtonGroups {
            switch buttonType {
            case .display:
                buttonGroup[0].isUserInteractionEnabled = isEnabled
            case .move:
                for index in 1..<buttonGroup.count {
                    buttonGroup[index].isEnabled = isEnabled
                }
            }
        }
    }
}


extension ViewController: ScoreDisplayDelegate {
    
    //Show the final score on separate view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scoreViewController = segue.destination as? ScorePresenter {
            scoreViewController.mainController = self
            scoreViewController.roundWins = gameManager.roundWins
            scoreViewController.totalRounds = gameManager.roundsInGame
        }
    }
    
    func startNewGame() {
        
        gameManager.newGame()
        nextRound()
    }
}

enum ButtonState {
    case active
    case inactive
}

enum ButtonType {
    case move
    case display
}

