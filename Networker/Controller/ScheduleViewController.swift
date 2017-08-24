//
//  ScheduleViewController.swift
//  Networker
//
//  Created by Big Shark on 16/03/2017.
//  Copyright © 2017 shark. All rights reserved.
//

import UIKit

class ScheduleViewController: BaseViewController {
    
 
    //variable related with calendar
    //@IBOutlet weak var calendarView: Koyomi!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    var user = UserModel()
    var selectedDate : Date!
    
    
    @IBOutlet fileprivate weak var calendarView: Koyomi! {
        didSet {
            //calendarView.circularViewDiameter = 0.2
            calendarView.calendarDelegate = self
            calendarView.inset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            //koyomi.weeks = ("Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat")
            calendarView.style = .standard
            calendarView.dayPosition = .center
            calendarView.selectionMode = .multiple(style: .circle)//.sequence(style: .semicircleEdge)
            calendarView.selectedStyleColor = Constants.GREEN_SCHEDULE_COLOR
            calendarView
                .setDayFont(size: 12)
                .setWeekFont(size: 12)
            let screenSize = UIScreen.main.bounds.size
            calendarView.frame.size = CGSize(width: screenSize.width - 76, height: screenSize.width - 64)
            calendarView.currentDateFormat = "MMMM yyyy"
            calendarView.isHiddenOtherMonth = true
            //calendarView.is
        
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if self.navigationController?.viewControllers.count == 1 {
            backButton.isHidden = true
        }
        else{
            backButton.isHidden = false
        }
        calendarView.display(in: .current)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        calendarView.reloadData()        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func prevButtonTapped(_ sender: UIButton) {
        calendarView.display(in: .previous)
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        calendarView.display(in: .next)
    }

    @IBAction func backButtonTapped(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated : true)
    }
    
    
    @IBAction func scheduleDayButtonTapped(_ sender: UIView) {
        if selectedDate != nil {
            let dailyScheduleVC = self.storyboard?.instantiateViewController(withIdentifier: "DailyScheduleViewController") as! DailyScheduleViewController
            dailyScheduleVC.selectedDay = calendarView.getMonthValue()
            self.navigationController?.pushViewController(dailyScheduleVC, animated: true)
        }
    }
}



extension ScheduleViewController : KoyomiDelegate {
    
    func koyomi(_ koyomi: Koyomi, didSelect date: Date?, forItemAt indexPath: IndexPath) {
        
        let currentDate = Date()
        if Int64((date?.timeIntervalSinceNow)!) >= -86400 {
            selectedDate = date
        }
    }
    
    func koyomi(_ koyomi: Koyomi, currentDateString dateString: String) {
        
        monthLabel.text = dateString
    }
    
    
    
}
