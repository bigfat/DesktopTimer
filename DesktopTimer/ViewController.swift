//
//  ViewController.swift
//  DesktopTimer
//
//  Created by Colton Blume on 12/19/14.
//  Copyright (c) 2014 Colton Blume. All rights reserved.
//

import Cocoa
import AVFoundation


class ViewController: NSViewController {
    

    var audioPlayer = AVAudioPlayer()
    var timer = NSTimer()
    
    @IBOutlet internal weak var timerFaceTextField: NSTextField!
    

    @IBAction func startButton(sender: AnyObject) {
        
        update()

        // add timer
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
//        timer.fire()
        
        cancelButtonOutlet.enabled = true
        startButtonOutlet.enabled = false
    }
    
    @IBOutlet weak var startButtonOutlet: NSButton!
    
    @IBAction func cancelButton(sender: AnyObject) {
        audioPlayer.stop()
        timer.invalidate()
        cancelButtonOutlet.enabled = false
        startButtonOutlet.enabled = true
    }

    @IBOutlet weak var cancelButtonOutlet: NSButton!

    func update() {
        if (timerFaceTextField.integerValue != 0) {
        var currentTime = timerFaceTextField.integerValue
        currentTime = --currentTime
        // update and change what the textfield says
        timerFaceTextField.stringValue = currentTime.description
        } else if (timerFaceTextField.integerValue == 0){
            audioPlayer.play()
            timerFaceTextField.stringValue = ""
        }
    }
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Make an audio player to play the alert noise.
        
        // create a dictionary to edit with options of which sound to play for alarm
        
        var alarmSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("Alarm Clock Digital Buzzer Sound Effect", ofType: "mp3")!)
        // suggested adding the ! after mp3, maybe an issue
        
        audioPlayer = AVAudioPlayer(contentsOfURL: alarmSound, error: nil)
        audioPlayer.prepareToPlay() // to play: audioPlayer.play()
        
        cancelButtonOutlet.enabled = false

        
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

