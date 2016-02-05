//
//  ViewController.swift
//  13_app_Retro_Calculator
//
//  Created by 昆翰 蔡 on 2016/1/30.
//  Copyright © 2016年 昆翰 蔡. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    enum Operation: String {
        case Divide = "/"
        case Mutiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    @IBOutlet weak var outputLbl: UILabel!
    
    var btnSound: AVAudioPlayer!
    
    var runningNum = "0"
    var leftValStr = ""
    var rightValStr = ""
    var currentOperation: Operation = Operation.Empty
    var result = ""
    
    @IBAction func onClearPressed(sender: AnyObject) {
        playSound()
        runningNum = "0"
        outputLbl.text = "0"
        leftValStr = "0"
        rightValStr = "0"
        currentOperation = Operation.Empty
        result = "0"
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: path!)
        do {
            try btnSound = AVAudioPlayer(contentsOfURL: soundUrl)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
    }


    @IBAction func numPress(btn: UIButton) {
        playSound()
        if runningNum == "0" {
            
            runningNum = "\(btn.tag)"
            outputLbl.text = runningNum
        }else{
            runningNum += "\(btn.tag)"
            outputLbl.text = runningNum
        }
       
    }

    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(Operation.Divide)
        
    }
    
    @IBAction func onMutiplyPressed(sender: AnyObject) {
        processOperation(Operation.Mutiply)

    }
    
    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOperation(Operation.Subtract)

    }
    
    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(Operation.Add)

    }
    
    @IBAction func onEqualPressed(sender: AnyObject) {
        processOperation(currentOperation)

    }
    
    func processOperation(op: Operation) {
        playSound()
        
        if currentOperation != Operation.Empty {
            //開始計算
            
            //防止使用者按下了運算符號後，沒有輸入數字，又再選另一運算符號
            if runningNum != "" {

                rightValStr = runningNum
                runningNum = ""
                
                if currentOperation == Operation.Mutiply {
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                }else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                }else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                }else if currentOperation == Operation.Add {
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                }
                leftValStr = result
                
                displayNumber(result)
                //outputLbl.text = result
                
                currentOperation = op
                
            }else{
                currentOperation = op
            }
            
        } else {
            //這是第一次按下運算符號
            leftValStr = runningNum
            runningNum = ""
            currentOperation = op
        }
    }
    
    func playSound() {
        if btnSound.playing {
            btnSound.stop()
        }
        btnSound.play()
    }
    
    func displayNumber(number: String) {
        let dnumber = Double(number)
        if dnumber! - Double(Int(dnumber!)) == 0 {
            outputLbl.text = ("\(Int(dnumber!))")
        } else {
            outputLbl.text = ("\(dnumber!)")
        }
    }
    
}

