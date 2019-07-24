//
//  SoundPlayer.swift
//  BoutTime
//
//  Created by Gavin Butler on 22-07-2019.
//  Copyright © 2019 Gavin Butler. All rights reserved.
//

import AudioToolbox
import AVFoundation
import GameKit

class SoundPlayer {
    
    var backgroundSoundEffect: AVAudioPlayer?
    
    var correctAnswerSound: SystemSoundID = 0
    var inCorrectAnswerSound: SystemSoundID = 0
    
    func loadAnswerSounds() {
        loadSounds(fromFile: "CorrectDing.wav", soundID: &correctAnswerSound)
        loadSounds(fromFile: "IncorrectBuzz.wav", soundID: &inCorrectAnswerSound)
    }
    
    func loadSounds(fromFile fileName: String, soundID: inout SystemSoundID) {
        let path = Bundle.main.path(forResource: fileName, ofType: nil)
        let soundUrl = URL(fileURLWithPath: path!)
        AudioServicesCreateSystemSoundID(soundUrl as CFURL, &soundID)
    }
    
    func playCorrectAnswerSound() {
        AudioServicesPlaySystemSound(correctAnswerSound)
    }
    
    func playIncorrectAnswerSound() {
        AudioServicesPlaySystemSound(inCorrectAnswerSound)
    }
    
}

