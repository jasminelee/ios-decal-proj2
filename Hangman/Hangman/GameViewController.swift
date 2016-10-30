//
//  GameViewController.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {


    var inProgress = true
    
    let hm1 = #imageLiteral(resourceName: "hangman1.gif")
    let hm2 = #imageLiteral(resourceName: "hangman2.gif")
    let hm3 = #imageLiteral(resourceName: "hangman3.gif")
    let hm4 = #imageLiteral(resourceName: "hangman4.gif")
    let hm5 = #imageLiteral(resourceName: "hangman5.gif")
    let hm6 = #imageLiteral(resourceName: "hangman6.gif")
    let hm7 = #imageLiteral(resourceName: "hangman7.gif")
    
    var phrase = ""
    
    @IBOutlet weak var puzzleString: UILabel!
    @IBOutlet weak var guess: UITextField!
    @IBOutlet weak var hangmanImage: UIImageView!
    @IBOutlet weak var incorrectGuesses: UILabel!
    @IBOutlet weak var numIncorrectGuesses: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let hangmanPhrases = HangmanPhrases()
        let phrase = hangmanPhrases.getRandomPhrase()
        incorrectGuesses.text = ""
        numIncorrectGuesses.text = String(incorrectGuesses.text!.characters.count)
        puzzleString.text = String(repeating: "-", count: (phrase?.characters.count)!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pressGuess(_ sender: UIButton) {
        print(phrase)
        updateGuess()
        drawHangman()
    }

    
    func updateGuess() {
        let guessedLetter:String = "\(guess.text?.characters.first)"
        
        if phrase.contains(guessedLetter) {
            let displayString = puzzleString.text
            let newStr = displayString?.replacingOccurrences(of: "-", with: guessedLetter, options: .literal, range: nil)
            puzzleString.text = newStr
        } else {
            let newStr:String = incorrectGuesses.text! + guessedLetter
            incorrectGuesses.text = newStr
            let newNumIncorrect = Int(numIncorrectGuesses.text!) += 1
            numIncorrectGuesses.text = "\(newNumIncorrect)"
        }
    }
    
    func drawHangman() {
        let numIncorrect:Int = Int(numIncorrectGuesses.text!)!
        switch numIncorrect {
        case 0:
            hangmanImage.image = hm1
        case 1:
            hangmanImage.image = hm2
        case 2:
            hangmanImage.image = hm3
        case 3:
            hangmanImage.image = hm4
        case 4:
            hangmanImage.image = hm5
        case 5:
            hangmanImage.image = hm6
        case 6:
            hangmanImage.image = hm7
        default:
            break
        }
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
