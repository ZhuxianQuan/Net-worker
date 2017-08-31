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
            calendarView.style = .standard
            calendarView.dayPosition = .center
            calendarView.selectionMode = .single(style: .circle)
            calendarView.selectedStyleColor = Constants.GREEN_SCHEDULE_COLOR
            calendarView
                .setDayFont(size: 12)
                .setWeekFont(size: 12)
            let screenSize = UIScreen.main.bounds.size
            calendarView.frame.size = CGSize(width: screenSize.width - 76, height: screenSize.width - 64)
            calendarView.currentDateFormat = "MMMM yyyy"
            
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
        if calendarView.getMonthValue() > DateUtils.getDayValue(Date()) / 100 {
            calendarView.display(in: .previous)
        }
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        let nextMonth = Date(timeIntervalSinceNow: 86400 * 62)
        if calendarView.getMonthValue() < DateUtils.getDayValue(nextMonth) / 100 {
            calendarView.display(in: .next)
        }
    }

    @IBAction func backButtonTapped(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated : true)
    }
    
    
    @IBAction func scheduleDayButtonTapped(_ sender: UIView) {
        if selectedDate != nil {
            let dailyScheduleVC = self.storyboard?.instantiateViewController(withIdentifier: "DailyScheduleViewController") as! DailyScheduleViewController
            dailyScheduleVC.selectedDay = selectedDate
            self.navigationController?.pushViewController(dailyScheduleVC, animated: true)
        }
    }
}



extension ScheduleViewController : KoyomiDelegate {
    
    func koyomi(_ koyomi: Koyomi, didSelect date: Date?, forItemAt indexPath: IndexPath) {
        let sinceFromNow = Int64((date?.timeIntervalSinceNow)!)
        if sinceFromNow >= -86400 && sinceFromNow < 86400 * 62 {
            selectedDate = date
            
            if DateUtils.getDayValue(selectedDate) / 100 > koyomi.getMonthValue() {
                koyomi.display(in: .next)
            }
            else if DateUtils.getDayValue(selectedDate) / 100 < koyomi.getMonthValue() {
                koyomi.display(in: .previous)
            }
        }
    }
    
    
    func koyomi(_ koyomi: Koyomi, currentDateString dateString: String) {
        
        monthLabel.text = dateString
    }
    
    
    
}
