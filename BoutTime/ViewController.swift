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
    
    
    // MARK: - Convenience Collections
    var buttonGroup1: [UIButton] = []
    var buttonGroup2: [UIButton] = []
    var buttonGroup3: [UIButton] = []
    var buttonGroup4: [UIButton] = []
    
    var allButtonGroups: [[UIButton]] = []

    
    var buttonRoundedRadius = 15
    //var activeButton: Int = 0
    
    let debug = true    //Make Text Visible
    
    // MARK: - External Classes
    var gameManager = GameManager()

    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Group the buttons into arrays for convenience
        initializeButtonCollections()
        
        gameManager.nextRound()
        
        displayEvents()
        
    }
    
    //Detect Shake Gesture
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        print("GB - Device was shaken!")
    }

    
    func displayEvents() {
        
        populateDisplayButtonsWith(gameManager.currentRoundEvents)    
        
    }
    
    func populateDisplayButtonsWith(_ currentEventList: [Event])  {
        
        for (index, buttonGroup) in allButtonGroups.enumerated() {
            let debugText = debug ? String(currentEventList[index].year) + "-" : ""
            buttonGroup[0].setTitle(debugText + currentEventList[index].title, for: .normal)
            buttonGroup[0].titleLabel?.numberOfLines = 0; // Dynamic number of lines
            buttonGroup[0].titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping;
        }
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
        //Future functionality to display web Page once phone has been shaked or round is timed out
        
    }
    

    @IBAction func moveButtonPressed(_ sender: UIButton) {
        
        //Determine displayButton from/to
        guard let fromTo: (fromDisplayButtonNumber: Int, toDisplayButtonNumber: Int) = getFromToButtonIDsFor(sender) else { return }
        
        gameManager.swap(fromTo: fromTo)
        
        //Register the activeButton and activate the To Group
        //activeButton = fromTo.toDisplayButtonNumber //Do I really need this variable?
        activateButtonsInGroup(fromTo.toDisplayButtonNumber)

        populateDisplayButtonsWith(gameManager.currentRoundEvents)

    }
    
}

extension ViewController {
    
    //MARK: - Helper Functions
    
    func activateButtonsInGroup (_ groupNumber: Int) {
        
        //Translate for array
        let groupNumber = groupNumber - 1
        
        for (index, buttonGroup) in allButtonGroups.enumerated() {
            
            if index == groupNumber {
                
                //Add highlight
                highlightDisplayButton(buttonGroup[0])
                
                //Activate move buttons
                for index in 1..<buttonGroup.count {
                    buttonGroup[index].isEnabled = true
                    //set the button image to the activated version
                    if let newImageName = getButtonImageNameFor(buttonGroup[index], withState: .active) {
                        buttonGroup[index].setImage(UIImage(named: newImageName), for: .normal)
                    }
                }
            } else {
                //Remove highlight
                unHighlightDisplayButton(buttonGroup[0])
                
                //de-activate move buttons
                for index in 1..<buttonGroup.count {
                    buttonGroup[index].isEnabled = false
                    //set the button image to the de-activated version
                    if let newImageName = getButtonImageNameFor(buttonGroup[index], withState: .inactive) {
                        buttonGroup[index].setImage(UIImage(named: newImageName), for: .normal)
                    }
                }
            }
        }
    }
    
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
    
    func getButtonImageNameFor(_ button: UIButton, withState state: ButtonState) -> String? {
        switch button {
        case button1Down:
            switch state {
            case .active: return "down_full_selected"
            case .inactive: return "down_full"
            }
        case button2Up, button3Up:
            switch state {
            case .active: return "up_half_selected"
            case .inactive: return "up_half"
            }
        case button2Down, button3Down:
            switch state {
            case .active: return "down_half_selected"
            case .inactive: return "down_half"
            }
        case button4Up:
            switch state {
            case .active: return "up_full_selected"
            case .inactive: return "up_full"
            }
        default: return nil
        }
    }
    
//    func highlightDisplayButton(_ sender: UIButton) {
//        sender.layer.borderWidth = 5
//        sender.layer.borderColor = UIColor.black.cgColor
//    }
//    
//    func unHighlightDisplayButton(_ sender: UIButton) {
//        sender.layer.borderWidth = 0
//        sender.layer.borderColor = nil
//    }
    
    //Function to round top left and right corners of the display buttons in order to match the arrow buttons
    func roundCorners(of view: UIView, withRadius radius: Int) {
        let path = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        view.layer.mask = mask
    }
}

enum ButtonState {
    case active
    case inactive
}

