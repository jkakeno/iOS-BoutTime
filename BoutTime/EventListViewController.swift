//
//  ViewControllerOne.swift
//  BoutTime
//
//  Created by EG1 on 8/20/18.
//  Copyright © 2018 Jun Kakeno. All rights reserved.
//

//Imported to use UIViewController
import UIKit
//Imported to use Timer
import GameKit
//Imported to use AudioServices
import AudioToolbox

class EventListViewController: UIViewController {
    
    var roundCount = 0
    var correctCount = 0
    var displayedEventList:[Event] = []
    var eventListProvider: EventListProvider = EventListProvider()
    var time = 60
    var timer:Timer?
    var gameSound: SystemSoundID = 0
    
    //Create enum with default values to minimize the use of magic numbers.
    enum defaultValues:Int {
        case roundCount = 6
        case time = 60
        case one = 1
        case zero = 0
    }

    //Event labels
    @IBOutlet weak var eventOneLabel: EdgeInsetLabel!
    @IBOutlet weak var eventTwoLabel: EdgeInsetLabel!
    @IBOutlet weak var eventThreeLabel: EdgeInsetLabel!
    @IBOutlet weak var eventFourLabel: EdgeInsetLabel!
    
    //Timer label
    @IBOutlet weak var secondsLabel: UILabel!
    
    //Event move buttons
    @IBOutlet weak var downOneButton: UIButton!
    @IBOutlet weak var downTwoButton: UIButton!
    @IBOutlet weak var downThreeButton: UIButton!
    @IBOutlet weak var upOneButton: UIButton!
    @IBOutlet weak var upTwoButton: UIButton!
    @IBOutlet weak var upThreeButton: UIButton!
    
    //Event move buttons
    @IBAction func downOneButton(_ sender: UIButton) {
        moveEvent(fromPosition: 0, toPosition: 1)
    }
    @IBAction func downTwoButton(_ sender: UIButton) {
        moveEvent(fromPosition: 1, toPosition: 2)
    }
    @IBAction func downThreeButton(_ sender: UIButton) {
        moveEvent(fromPosition: 2, toPosition: 3)
    }
    @IBAction func upOneButton(_ sender: UIButton) {
        moveEvent(fromPosition: 1, toPosition: 0)
    }
    @IBAction func upTwoButton(_ sender: UIButton) {
        moveEvent(fromPosition: 2, toPosition: 1)
    }
    @IBAction func upThreeButton(_ sender: UIButton) {
        moveEvent(fromPosition: 3, toPosition: 2)
    }
    
    @IBOutlet weak var nextRoundButton: UIButton!
    
    @IBAction func nextRoundButton(_ sender: UIButton) {
        print("Show next round")
        loadEvents()
        displayEvents()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadEvents()
        displayEvents()
        
        //Get shake gesture.
        self.becomeFirstResponder()
        
        toogleButtonImages()
    }

    func toogleButtonImages(){
        downOneButton.setImage(UIImage(named: "down_full")?.withRenderingMode(.automatic), for:.normal)
        downTwoButton.setImage(UIImage(named: "down_half")?.withRenderingMode(.automatic), for:.normal)
        downThreeButton.setImage(UIImage(named: "down_half")?.withRenderingMode(.automatic), for:.normal)
        upOneButton.setImage(UIImage(named: "up_half")?.withRenderingMode(.automatic), for:.normal)
        upTwoButton.setImage(UIImage(named: "up_half")?.withRenderingMode(.automatic), for:.normal)
        upThreeButton.setImage(UIImage(named: "up_full")?.withRenderingMode(.automatic), for:.normal)
        downOneButton.setImage(UIImage(named: "down_full_selected")?.withRenderingMode(.automatic), for: .highlighted)
        downTwoButton.setImage(UIImage(named: "down_half_selected")?.withRenderingMode(.automatic), for: .highlighted)
        downThreeButton.setImage(UIImage(named: "down_half_selected")?.withRenderingMode(.automatic), for: .highlighted)
        upOneButton.setImage(UIImage(named: "up_half_selected")?.withRenderingMode(.automatic), for: .highlighted)
        upTwoButton.setImage(UIImage(named: "up_half_selected")?.withRenderingMode(.automatic), for: .highlighted)
        upThreeButton.setImage(UIImage(named: "up_full_selected")?.withRenderingMode(.automatic), for: .highlighted)
    }
    
    func eventMoveButton(isEnabled:Bool){
        if isEnabled == true{
            downOneButton.isEnabled = true
            downTwoButton.isEnabled = true
            downThreeButton.isEnabled = true
            upOneButton.isEnabled = true
            upTwoButton.isEnabled = true
            upThreeButton.isEnabled = true
        }else{
            downOneButton.isEnabled = false
            downTwoButton.isEnabled = false
            downThreeButton.isEnabled = false
            upOneButton.isEnabled = false
            upTwoButton.isEnabled = false
            upThreeButton.isEnabled = false
        }
    }
    
    func moveEvent(fromPosition startPosition:Int, toPosition endPosition: Int){
        let event = displayedEventList.remove(at: startPosition)
        displayedEventList.insert(event, at: endPosition)
        displayEvents()
    }
    
    func loadEvents(){
        eventMoveButton(isEnabled: true)
        resetTimer()
        //Hide next round button.
        nextRoundButton.isHidden=true
        //Clear displayEventList.
        displayedEventList.removeAll()
        //Get the list of selected events.
        displayedEventList = eventListProvider.getEventList()
        //Start timer
        timer=Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer(){
        if time > defaultValues.zero.rawValue{
            //Format the seconds to always display 2 digits.
            secondsLabel.text = String(format:"%02d",time)
            time -= defaultValues.one.rawValue
        }else if time == defaultValues.zero.rawValue {
            secondsLabel.text = String(format:"%02d",time)
            checkAnswer()
            resetTimer()
            displayEvents()
        }
    }
    
    func resetTimer(){
        time = defaultValues.time.rawValue
        //Stop the timer
        timer?.invalidate()
        timer=nil
    }
    
    func stopTimer(){
        //Stop the timer
        timer?.invalidate()
        timer=nil
    }
    
    func displayEvents(){
        eventOneLabel.text = displayedEventList[0].description
        eventTwoLabel.text = displayedEventList[1].description
        eventThreeLabel.text = displayedEventList[2].description
        eventFourLabel.text = displayedEventList[3].description
    }
    
    //Become first responder to get shake motion
    override var canBecomeFirstResponder: Bool {
        get {
            return true
        }
    }
    
    // Enable detection of shake motion
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            if nextRoundButton.isHidden{
                checkAnswer()
            }
        }
    }
    
    func checkAnswer(){
        stopTimer()
        if let date1 = displayedEventList[0].date, let date2 = displayedEventList[1].date, let date3 = displayedEventList[2].date, let date4 = displayedEventList[3].date {
            //Check that the date of events are in accending order.
            if date1<date2 && date2<date3 && date3<date4 {
                print("Good")
                //Show button image
                showNextRoundButton(forImage: "next_round_success")
                correctCount += defaultValues.one.rawValue
                roundCount += defaultValues.one.rawValue
                print("Round count is: \(roundCount)")
                checkRoundCount()
                playSound(resource: "CorrectDing", type: "wav")
            } else {
                print("No Good")
                showNextRoundButton(forImage: "next_round_fail")
                roundCount += defaultValues.one.rawValue
                print("Round count is: \(roundCount)")
                checkRoundCount()
                playSound(resource: "IncorrectBuzz", type: "wav")
            }
        }
    }
    
    func showNextRoundButton(forImage:String){
        nextRoundButton.isHidden = false
        let btnImage = UIImage(named: forImage)
        nextRoundButton.setImage(btnImage , for: UIControlState.normal)
        eventMoveButton(isEnabled: false)
    }
    
    func checkRoundCount(){
        if roundCount == defaultValues.roundCount.rawValue {
            //Display nextRoundButton but disable it.
            nextRoundButton.isEnabled = false
            loadResultViewController(delay: 3)
            print("Show score...")
        }
    }
    
    func playSound(resource: String, type: String){
        let path = Bundle.main.path(forResource: resource, ofType: type)
        let soundUrl = URL(fileURLWithPath: path!)
        AudioServicesCreateSystemSoundID(soundUrl as CFURL, &gameSound)
        AudioServicesPlaySystemSound(gameSound)
    }
    
    func loadResultViewController(delay seconds: Int) {
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = DispatchTime.now() + Double(delay) / Double(NSEC_PER_SEC)
        
        // Executes the nextRound method at the dispatch time on the main queue
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            //Pass the correct count and round count data to result view controller.
            if let resultViewController = self.storyboard?.instantiateViewController(withIdentifier: "result") as? ResultViewController{
                resultViewController.correctCount = self.correctCount
                resultViewController.roundCount = self.roundCount
                //Show viewController
                self.present(resultViewController, animated: true, completion: nil)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
