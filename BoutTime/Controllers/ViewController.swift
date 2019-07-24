//
//  ViewController.swift
//  BoutTime
//
//  Created by Gavin Butler on 19-07-2019.
//  Copyright © 2019 Gavin Butler. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Outlets
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

    
    var buttonRoundedRadius = 15
    
    let debug = true    //Make the event's year visible
    var timerMax = 20
    var timerCount = 20 {
        didSet { timerOutputLabel.text = String(timerCount) }
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
    
    //Detect Shake Gesture
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        
        guard timer.isValid else { return }             //Only proceed if the play is live (timer is still running)
        guard motion == .motionShake else { return }    //Should only respond to shake
        
        //Stop the timer
        timer.invalidate()
        
        //Check the answers:
        checkStatusForRound()
    }
    
    func checkStatusForRound() {
        
        var nextRoundImageName: String
        var checkScoreImageName: String
        
        //Disable the the move buttons
        changeButtonState(for: .move, toState: .inactive)
        
        //Enable the event display buttons
        changeButtonState(for: .display, toState: .active)
        
        //Check the results
        let correctOrder: Bool = gameManager.eventsAreInCorrectOrder()
        
        if correctOrder {
            soundPlayer.playCorrectAnswerSound()
            nextRoundImageName = "next_round_success"
            checkScoreImageName = "check_score_success"
        } else {
            soundPlayer.playIncorrectAnswerSound()
            nextRoundImageName = "next_round_fail"
            checkScoreImageName = "check_score_fail"
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
        
        //Enable display buttons
    }

    
    func displayEvents() {
        
        for (index, buttonGroup) in allButtonGroups.enumerated() {
            let debugText = debug ? String(gameManager.currentRoundEvents[index].year) + "-" : ""
            buttonGroup[0].setTitle(debugText + gameManager.currentRoundEvents[index].title, for: .normal)
            buttonGroup[0].titleLabel?.numberOfLines = 0
            buttonGroup[0].titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping  //Check if this is required???
        }
        
    }
    
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
        
        //Enable the move buttons
        changeButtonState(for: .move, toState: .active)
        
        //Disable the event display buttons
        changeButtonState(for: .display, toState: .inactive)
        
    }
    
    func initializeButtonCollections() {
        buttonGroup1 = [eventDisplayButton1, button1Down]
        buttonGroup2 = [eventDisplayButton2, button2Up, button2Down]
        buttonGroup3 = [eventDisplayButton3, button3Up, button3Down]
        buttonGroup4 = [eventDisplayButton4, button4Up]
        allButtonGroups = [buttonGroup1, buttonGroup2, buttonGroup3, buttonGroup4]
    }
    
    //MARK: - IBActions
    
    @IBAction func displayButtonPressed(_ sender: UIButton) {
        
        print("Button Group is\(sender.tag)")
        //Future functionality to enable buttons for segue to web page
        if let url = gameManager.urlForButtonGroup(sender.tag) {
            UIApplication.shared.open(url)
        }
    }
    

    @IBAction func moveButtonPressed(_ sender: UIButton) {
        
        //Determine displayButton from/to
        guard let fromTo: (fromDisplayButtonNumber: Int, toDisplayButtonNumber: Int) = getFromToButtonIDsFor(sender) else { return }
        
        gameManager.swap(fromTo: fromTo)
        
        //Refresh the UI

        displayEvents()

    }
    
    @IBAction func nextRoundButtonPressed(_ sender: UIButton) {
        
        nextRound()
    }
    
}

extension ViewController {
    
    //MARK: - Helper Functions
    
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
    
    func setMoveButtonSelectionImages() {
        button1Down.setImage(UIImage(named: "down_full_selected"),  for: .selected)
        button2Up.setImage  (UIImage(named: "up_half_selected"),    for: .selected)
        button2Down.setImage(UIImage(named: "down_half_selected"),  for: .selected)
        button3Up.setImage  (UIImage(named: "up_half_selected"),    for: .selected)
        button3Down.setImage(UIImage(named: "down_half_selected"),  for: .selected)
        button4Up.setImage  (UIImage(named: "up_full_selected"),    for: .selected)
    }
    
    func roundDisplayButtonCorners() {
        for buttonGroup in allButtonGroups {
            roundCorners(of: buttonGroup[0], withRadius: 5)
        }
    }

    
    //Function to round top left and right corners of the display buttons in order to match the arrow buttons
    func roundCorners(of view: UIView, withRadius radius: Int) {
        let path = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: [.topLeft, .bottomLeft], cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        view.layer.mask = mask
    }
    
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
                    buttonGroup[index].isUserInteractionEnabled = isEnabled
                }
            }
        }
    }
    
    // MARK: - Timer
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            //update timer output label
            self.timerCount -= 1
            
            if self.timerCount == 0 {
                
                //Stop the timer, update game statistics, load next round:
                timer.invalidate()
                
                //Need to perform the same action here as the one where the user shakes the phone
                self.checkStatusForRound()
                
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

