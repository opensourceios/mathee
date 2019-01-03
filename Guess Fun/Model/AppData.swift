//
//  AppData.swift
//  Guess Fun
//
//  Created by Daniel Springer on 1/3/19.
//  Copyright © 2019 Dani Springer. All rights reserved.
//

import Foundation
import AVKit

class AppData: UIViewController {

    static func getSoundEnabledSettings(sound: String) {
        let soundEnabled = UserDefaults.standard.bool(forKey: Constants.UserDef.soundEnabled)
        if soundEnabled {
            playSound(soundURL: sound)
        }
    }


    static func playSound(soundURL: String) {
        var soundID: SystemSoundID = 0
        let url = URL(fileURLWithPath: soundURL)
        AudioServicesCreateSystemSoundID(url as CFURL, &soundID)
        AudioServicesPlaySystemSound(soundID)
    }
}
