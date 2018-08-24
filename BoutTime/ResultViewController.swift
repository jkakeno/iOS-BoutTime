//
//  ResultViewController.swift
//  BoutTime
//
//  Created by EG1 on 8/23/18.
//  Copyright © 2018 Jun Kakeno. All rights reserved.
//

//Imported to use UIViewController
import UIKit

class ResultViewController: UIViewController{
    var correctCount: Int = 0
    var roundCount: Int = 0
    
    @IBOutlet weak var correctAnswer: UILabel!
    
    @IBOutlet weak var roundsPerGame: UILabel!
    
    @IBOutlet weak var playAgainButton: UIButton!
    
    @IBAction func playAgain(_ sender: UIButton) {
        //Get access to story board
        let storyBoard: UIStoryboard=UIStoryboard(name: "Main", bundle: nil)
        //Get the view controller with story board id "eventList"
        let eventListViewController=storyBoard.instantiateViewController(withIdentifier: "eventList")
        //Show viewController
        self.present(eventListViewController, animated: true, completion: nil)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Set the screen labels with data received from EventListViewController.
        correctAnswer.text = String(correctCount)
        roundsPerGame.text = String(roundCount)
        print("Your Score is \(correctCount) / \(roundCount)")
        //Show play again button.
        let btnImage = UIImage(named: "play_again")
        playAgainButton.setImage(btnImage , for: UIControlState.normal)
    }
}
