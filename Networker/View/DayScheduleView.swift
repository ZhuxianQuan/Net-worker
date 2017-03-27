//
//  DayScheduleView.swift
//  Networker
//
//  Created by Big Shark on 27/03/2017.
//  Copyright © 2017 shark. All rights reserved.
//

import UIKit

class DayScheduleView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var sheduleViews : [UIView] = []
    
    func initView() {
        for view in sheduleViews {
            view.removeFromSuperview()
        }
    
    }
    
    func drawGrid(){
        
        for index in 1...24 {
            let lineView = UIView(frame: CGRect(x: 30.0 * CGFloat(index), y: 0 , width : frame.size.width, height : 0.5))
            lineView.backgroundColor = UIColor.lightGray
            addSubview(lineView)
        }
    }
    
    func setView(_ daySchedule: DayScheduleModel) {
        initView()
        for dayData in daySchedule.schedule_dayData {
            
        }
    }
    

}
