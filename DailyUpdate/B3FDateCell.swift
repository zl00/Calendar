//
//  B3FDateCell.swift
//  DailyUpdate
//
//  Created by Linda Zhong on 8/2/16.
//  Copyright © 2016 Linda Zhong. All rights reserved.
//

import UIKit

public enum B3FDateType {
    case NotDate
    case Date(NSDate, Bool)
}

class B3FDateCell: UICollectionViewCell {
    @IBOutlet weak var todayLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    
    private var dateType: B3FDateType?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    func setupUI() -> Void {
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor(red: 158.0/255, green: 158.0/255, blue: 158.0/255, alpha: 0.6).CGColor
    }
    
    func updateData(dateType: B3FDateType) -> Void {
        self.dateType = dateType
        switch dateType {
        case .NotDate:
            updateDate(nil)
            updateIsToday(false)
            break
        case .Date(let date, let istoday):
            updateDate(date)
            updateIsToday(istoday)
            break
        }
    }
    
    
    func updateIsToday(isToday: Bool) -> Void {
        self.todayLbl.hidden = !isToday
        self.dateLbl.font = isToday ? UIFont(name: "Helvetica-Bold", size: 35) : UIFont(name: "Helvetica", size: 35)
    }
    
    func updateDate(date: NSDate?) -> Void {
        if let d = date {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "d"
            self.dateLbl.text = dateFormatter.stringFromDate(d)
            self.dateLbl.hidden = false
        } else {
            self.dateLbl.hidden = true
        }
    }
    
    func updateDateType(dateType: B3FDateType) -> Void {
        self.dateType = dateType
        // TODO:
    }
}
