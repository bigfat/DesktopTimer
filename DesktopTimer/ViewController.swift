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
    
    var hoursLeft = 0
    var minutesLeft = 0
    var secondsLeft = 0
    
    
    var audioPlayer = AVAudioPlayer()
    var timer = NSTimer()
    
//    var df = NSDateFormatter()
    var clockFormat = NSNumberFormatter()
    
    @IBOutlet internal weak var timerFaceTextField: NSTextField!

    @IBAction func startButton(sender: AnyObject) {
        
        clockFormat.paddingCharacter = ":" //Dunno..
        
        var rawNumber = timerFaceTextField.integerValue
        hoursLeft = rawNumber / 10000
        minutesLeft = ((rawNumber - (hoursLeft * 10000)) - secondsLeft) / 100
        secondsLeft = rawNumber % 100
        println("rawNumber = \(rawNumber) minutesLeft = \(minutesLeft) secondsLeft = \(secondsLeft)")
        
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
        
        if (secondsLeft != 0){
            secondsLeft = --secondsLeft
            
            // make a stringValue to show in the clock
            var stringTimeValue = (hoursLeft.description + ":" + minutesLeft.description + ":" + secondsLeft.description)
            timerFaceTextField.stringValue = stringTimeValue
        } else if (minutesLeft != 0) {
            minutesLeft = --minutesLeft
            
            secondsLeft = 59
            
            // make a stringValue to show in the clock
            var stringTimeValue = (hoursLeft.description + ":" + minutesLeft.description + ":" + secondsLeft.description)
            timerFaceTextField.stringValue = stringTimeValue
        } else if (hoursLeft != 0) {
            hoursLeft = --hoursLeft
            
            minutesLeft = 59
            
            // make a stringValue to show in the clock
            var stringTimeValue = (hoursLeft.description + ":" + minutesLeft.description + ":" + secondsLeft.description)
            timerFaceTextField.stringValue = stringTimeValue
        } else if (timerFaceTextField.integerValue == 0){
            audioPlayer.play()
            timerFaceTextField.stringValue = "Done"
            timer.invalidate()
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

