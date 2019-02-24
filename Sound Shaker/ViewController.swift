//
//  ViewController.swift
//  Sound Shaker
//
//  Created by IMCS2 on 2/23/19.
//  Copyright © 2019 IMCS2. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var audioPlayer = AVAudioPlayer()
    var sounds = [String]()
    var playedTrackNumber = [Int]()
    var randomInt = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //init all the soundtrack into array
        for i in 1...10 {
            sounds.append("sound\(i)")
        }
        //left swipe
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.swiperight(gesture:)))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        
        //right swipe
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.swiperight(gesture:)))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
       
    }
    func playSong(number :Int){
        let sound = Bundle.main.path(forResource: sounds[number], ofType: "mp3")
        playedTrackNumber.insert(number, at: 0) // saving the previous track number
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
        }catch{
            print("error in playing song")
        }
        
        audioPlayer.play()
    }

    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake{
            randomInt = Int.random(in: 1...10)
            playSong(number: randomInt)
        }
    }
    
    @objc func swiperight(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer{
            if swipeGesture.direction == .left{
                print("left")
                randomInt += 1
                playSong(number: (randomInt)%10)//play in to loop
            }else{
                print("right")
                if playedTrackNumber.count >= 2 {
                    playSong(number: playedTrackNumber[1])
                    playedTrackNumber.remove(at: 0)
                }
            }
        }
    }
    

}

