//
//  B3FCalendarPagingVC.swift
//  DailyUpdate
//
//  Created by Linda Zhong on 8/7/16.
//  Copyright © 2016 Linda Zhong. All rights reserved.
//

import UIKit

public protocol B3FMonthDelegate: NSObjectProtocol {
    func month(didPageToMonth: NSDate)
}

class B3FCalendarPagingVC: UIPageViewController {
    
    @IBOutlet weak var titleItem: UIBarButtonItem!
    @IBOutlet weak var calendarItem: UIBarButtonItem!
    
    var currFirstDayOfMonth: NSDate! = NSDate().firstDayOfMonth()!
    
    var popoverHelper: B3FDUPopover!
    internal var monthDelegate: B3FMonthDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        self.dataSource = self
        self.setViewControllers([generateVC(currFirstDayOfMonth)], direction: .Reverse, animated: true, completion: nil)
        self.doubleSided = false
        self.titleItem.title = stringTitle(currFirstDayOfMonth)
    }
    
    private func setup() {
        let image : UIImage? = UIImage(named:"calendar-icon")!.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        self.calendarItem.image = image
    }
    
    private func generateVC(date: NSDate) -> UIViewController {
        let calendarVC = (storyboard!.instantiateViewControllerWithIdentifier("B3FCalendarMonthVC")) as! B3FCalendarMonthVC
        calendarVC.dateDelegate = self
        calendarVC.prepareData(date)
        return calendarVC
    }
    
    private func stringTitle(d: NSDate) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy/MM"
        return dateFormatter.stringFromDate(d)
    }
    
    @IBAction func clickCalendar(sender: AnyObject) {
        
    }
}

extension B3FCalendarPagingVC: UIPageViewControllerDataSource {
    internal func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        if let d = currFirstDayOfMonth.dateByAddingMonths(-1) {
            currFirstDayOfMonth = d
            self.titleItem.title = stringTitle(currFirstDayOfMonth)
            monthDelegate?.month(d)
            return generateVC(d)
        }
        return nil
    }
    
    internal func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        if let d = currFirstDayOfMonth.dateByAddingMonths(1) {
            currFirstDayOfMonth = d
            self.titleItem.title = stringTitle(currFirstDayOfMonth)
            monthDelegate?.month(d)
            return generateVC(d)
        }
        return nil
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 1000
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
}

extension B3FCalendarPagingVC: B3FDateCellDelegate {
    func dateCell(date: NSDate, didSelectItemAtView fromView: UIView) {
        popoverHelper = B3FDUPopover()
        popoverHelper.showFromView(from: fromView, date: date)
    }
    
    func dateCell(date: NSDate, didDeselectItemAtView fromView: UIView) {
    }
}

extension B3FCalendarPagingVC: UIPageViewControllerDelegate {
}
