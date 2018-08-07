//
//  Music.swift
//  Typeracer-iOS
//
//  Created by Adlet on 07.08.2018.
//  Copyright © 2018 theSmartest. All rights reserved.
//

import Foundation
import AVFoundation

class Music {
    
    static let share = Music()
    var backgroundMusicPlayer = AVAudioPlayer()
    
    func playBackgroundMusic(filename: String) {
        let url = Bundle.main.url(forResource: filename, withExtension: "mp3")
        guard let newURL = url else {
            return
        }
        do {
            backgroundMusicPlayer = try AVAudioPlayer(contentsOf: newURL)
            backgroundMusicPlayer.numberOfLoops = -1
            backgroundMusicPlayer.prepareToPlay()
            backgroundMusicPlayer.play()
        } catch let error as NSError {
            print(error.description)
        }
    }
}
