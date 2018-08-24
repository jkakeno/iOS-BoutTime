//
//  ViewController.swift
//  BoutTime
//
//  Created by EG1 on 8/20/18.
//  Copyright © 2018 Jun Kakeno. All rights reserved.
//

//Imported to use UIViewController
import UIKit

class SplashScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //Load the first round
        loadEventList(delay: 3)
    }

    func loadEventList(delay seconds: Int) {
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = DispatchTime.now() + Double(delay) / Double(NSEC_PER_SEC)
        
        // Executes the nextRound method at the dispatch time on the main queue
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            //Get access to story board
            let storyBoard: UIStoryboard=UIStoryboard(name: "Main", bundle: nil)
            //Get the view controller with story board id "eventList"
            let eventListViewController=storyBoard.instantiateViewController(withIdentifier: "eventList")
            //Show viewController
            self.present(eventListViewController, animated: true, completion: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

