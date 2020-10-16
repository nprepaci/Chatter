//
//  ViewController.swift
//  Chatter
//
//  Created by Nicholas Repaci on 10/13/20.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var chatterLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        printChatterCharacters()
        
        self.navigationController?.isNavigationBarHidden = true
        // Do any additional setup after loading the view.
    }
    
    func printChatterCharacters() {
        var charIndex = 0.0
        chatterLabel.text = ""
        let titleText = "Chatter"
        for letter in titleText {
            //multiplied by char index as each letter will appear x amount of seconds after the screen loads i.e. first letter appears immediately (*0) second appears at .2 (.2*1 (char index), third letter appears at .4 (.2 * 2(char index)). The reason for this is the loop applies a timer to each letter, and each letter needs to appear after the letter that precedes it
            Timer.scheduledTimer(withTimeInterval: 0.2 * charIndex, repeats: false) { (timer) in
                self.chatterLabel.text?.append(letter)
            }
            charIndex += 1.0
        }
    }


}

