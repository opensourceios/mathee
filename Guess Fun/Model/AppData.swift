//
//  AppData.swift
//  Guess Fun
//
//  Created by Daniel Springer on 1/3/19.
//  Copyright © 2019 Dani Springer. All rights reserved.
//

import AVKit


class AppData: UIViewController, AVAudioPlayerDelegate {

    static var player = AVAudioPlayer()


    static func getSoundEnabledSettings(sound: String) {
        let soundEnabled = UserDefaults.standard.bool(forKey: Constants.UserDef.soundEnabled)
        if soundEnabled {
            playSound(soundURL: sound)
        }
    }


    static func playSound(soundURL: String) {

        let path = Bundle.main.path(forResource: soundURL, ofType: nil)!
        let url = URL(fileURLWithPath: path)

        do {
            player = try AVAudioPlayer(contentsOf: url)
            if !player.isPlaying {
                player.play()
            } else {
                print("playing")
            }
            player.play()
        } catch {
            print("couldn't load file: \(soundURL)")
        }
    }
}
