//
//  NSDate+Extension.swift
//  DailyUpdate
//
//  Created by Linda Zhong on 8/3/16.
//  Copyright © 2016 Linda Zhong. All rights reserved.
//

import Foundation


extension NSDate {
    func calendar() -> NSCalendar {
        let calendar = NSCalendar(calendarIdentifier: NSGregorianCalendar)
        calendar?.timeZone = NSTimeZone(forSecondsFromGMT: 0)
        
        return calendar!
    }
    
    func dateByAddingDays(daysToAdd: Int) -> NSDate? {
        let calendar = self.calendar()
        let days = NSDateComponents()
        days.day = daysToAdd
        
        return calendar.dateByAddingComponents(days, toDate: self, options: [])
    }
    
    func dateByAddingMonths(monthsToAdd: Int) -> NSDate? {
        let calendar = self.calendar()
        let months = NSDateComponents()
        months.month = monthsToAdd
        
        return calendar.dateByAddingComponents(months, toDate: self, options: [])
    }
    
    func isSameDay(date: NSDate) -> Bool {
        return self.calendar().isDate(self, inSameDayAsDate: date)
    }
    
    func weekDay() -> Int {
        let comps  = self.calendar().components(.Weekday, fromDate: self)
        return comps.weekday
    }
    
    func daysOfMonth() -> Int {
        let range = self.calendar().rangeOfUnit(.Day, inUnit: .Month, forDate: self)
        return range.length
    }
    
    func fisrtDayOfMonth() -> NSDate? {
        let calendar = self.calendar()
        let currentDateComponents = calendar.components([.Year, .Month], fromDate: self)
        let startOfMonth = calendar.dateFromComponents(currentDateComponents)
        
        return startOfMonth
    }
    
    func endDayOfMonth() -> NSDate? {
        let calendar = self.calendar()
        if let plusOneMonthDate = dateByAddingMonths(1) {
            let plusOneMonthDateComponents = calendar.components([.Year, .Month], fromDate: plusOneMonthDate)
            let endOfMonth = calendar.dateFromComponents(plusOneMonthDateComponents)?.dateByAddingTimeInterval(-1)
            
            return endOfMonth
        }
        
        return nil
    }
}
