//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Colin Fraser on 22/05/2015.
//  Copyright (c) 2015 Colin Fraser. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
   
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playSlowAudio(sender: UIButton) {
       audioPlayer.stop() // good practice to stop audio player before you play it
        
        audioEngine.stop()
        audioEngine.reset() // added to stop other effects
        
       audioPlayer.rate = 0.5
       audioPlayer.currentTime = 0.0 // resets the audio file to the beginning
       audioPlayer.play()
        
        
    }
    
    
    @IBAction func playFastAudio(sender: UIButton) {
        audioPlayer.stop()
        
        audioEngine.stop()
        audioEngine.reset()
        
        audioPlayer.rate = 2
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
        
        
    }
    
    
    @IBAction func playChipmunkAudio(sender: UIButton) {

        playAudioWithVariablePitch(1000)
        
    }
   
    @IBAction func playDarthVader(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
        
    }
    
    func playAudioWithVariablePitch(pitch: Float){
        // play Audio with variable pitch - initialises with number for pitch
        
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
    
    
    @IBAction func stopAudio(sender: UIButton) {
    
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset() // stop all possible audioPlayer and audioEngine processes
    
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    

}
