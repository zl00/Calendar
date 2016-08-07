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
    case Date(NSDate)
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
    
    func updateData(dateType: B3FDateType) -> Void {
        self.dateType = dateType
        switch dateType {
        case .NotDate:
            updateDate(nil)
            updateIsToday(false)
            break
        case .Date(let date):
            updateDate(date)
            updateIsToday(date.isSameDay(NSDate()))
            break
        }
    }
    
    private func setupUI() -> Void {
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.borderColor().CGColor
    }
    
    private func updateIsToday(isToday: Bool) -> Void {
        self.todayLbl.hidden = !isToday
        self.dateLbl.font = isToday ? UIFont.dateFont(true) : UIFont.dateFont(false)
    }
    
    private func updateDate(date: NSDate?) -> Void {
        if let d = date {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "d"
            self.dateLbl.text = dateFormatter.stringFromDate(d)
            self.dateLbl.hidden = false
        } else {
            self.dateLbl.hidden = true
        }
    }
    
}
