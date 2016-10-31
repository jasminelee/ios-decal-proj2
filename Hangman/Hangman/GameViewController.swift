//
//  GameViewController.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import UIKit

extension String {
    subscript(i: Int) -> String {
        guard i >= 0 && i < characters.count else { return "" }
        return String(self[index(startIndex, offsetBy: i)])
    }
    subscript(range: Range<Int>) -> String {
        let lowerIndex = index(startIndex, offsetBy: max(0,range.lowerBound), limitedBy: endIndex) ?? endIndex
        return substring(with: lowerIndex..<(index(lowerIndex, offsetBy: range.upperBound - range.lowerBound, limitedBy: endIndex) ?? endIndex))
    }
    subscript(range: ClosedRange<Int>) -> String {
        let lowerIndex = index(startIndex, offsetBy: max(0,range.lowerBound), limitedBy: endIndex) ?? endIndex
        return substring(with: lowerIndex..<(index(lowerIndex, offsetBy: range.upperBound - range.lowerBound + 1, limitedBy: endIndex) ?? endIndex))
    }
}

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
        phrase = hangmanPhrases.getRandomPhrase()
        print(phrase)
        incorrectGuesses.text = ""
        numIncorrectGuesses.text = String(0)
        var puzzleStringText = ""
        for char:Character in phrase.characters {
            if char == " " {
                puzzleStringText += " "
            } else {
                puzzleStringText += "-"
            }
        }
        puzzleString.text = puzzleStringText
        drawHangman()
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
        let gl = guess.text?.characters.first
        let guessedLetter = "\(gl!)".uppercased()
        if phrase.contains(guessedLetter) {
            var displayStr = ""
            
            for (index, char) in (puzzleString.text?.characters.enumerated())! {
                if phrase[index] == guessedLetter {
                    displayStr += phrase[index]
                } else if "\(char)" == "-" {
                    displayStr += "-"
                } else {
                    displayStr += phrase[index]
                }
            }
            puzzleString.text = displayStr
        } else {
            let newStr:String = incorrectGuesses.text! + guessedLetter
            incorrectGuesses.text = newStr
            var newNumIncorrect = Int(numIncorrectGuesses.text!)
            newNumIncorrect! += 1
            numIncorrectGuesses.text = "\(newNumIncorrect!)"
        }
        checkGameStatus()
    }
    
    func checkGameStatus() {
        let victory = !(puzzleString.text?.contains("-"))!
        if victory {
            let alertController = UIAlertController(title: "You won!", message:
                "Want to play again?", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default,handler: resetGame))
            alertController.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.default,handler: backToHome))
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func resetGame(alert: UIAlertAction!) {
        viewDidLoad()
        viewWillAppear(true)
    }
    
    func backToHome(alert: UIAlertAction!) {
        let mapViewControllerObj = self.storyboard?.instantiateViewController(withIdentifier: "HomeController")
        self.navigationController?.present(mapViewControllerObj!, animated: true, completion: nil)
    }
    
    func drawHangman() {
        let numIncorrect = Int(numIncorrectGuesses.text!)
        switch numIncorrect! {
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
