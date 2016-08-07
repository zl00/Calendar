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
        let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
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
        return (comps.weekday - 1)
    }
    
    func daysOfMonth() -> Int {
        let range = self.calendar().rangeOfUnit(.Day, inUnit: .Month, forDate: self)
        return range.length
    }
    
    func firstDayOfMonth() -> NSDate? {
        let currentDateComponents = self.calendar().components([.Year, .Month], fromDate: self)
        let startOfMonth = self.calendar().dateFromComponents(currentDateComponents)
        
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
    
    func aboutWeeksOfMonth() -> Int {
        let firstDayOfMonth = self.firstDayOfMonth()!
        let weekDay = firstDayOfMonth.weekDay()
        let length = firstDayOfMonth.daysOfMonth()
        return (weekDay+length+6)/7;
    }

}
