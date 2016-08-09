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
    var calendarVCs: Array<UIViewController> = []
    var popoverHelper: B3FDUPopover!
    internal var monthDelegate: B3FMonthDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 30)
        let curr1stDay = NSDate().firstDayOfMonth()!
        for i in -24 ... 24 {
            let calendarVC = (storyboard!.instantiateViewControllerWithIdentifier("B3FCalendarMonthVC")) as! B3FCalendarMonthVC
            calendarVC.dateDelegate = self
            calendarVC.prepareData(curr1stDay.dateByAddingMonths(i)!)
            calendarVCs.append(calendarVC)
        }
        self.dataSource = self
        self.setViewControllers([calendarVCs[0]], direction: .Reverse, animated: true, completion: nil)
        self.doubleSided = false
    }
}

extension B3FCalendarPagingVC: UIPageViewControllerDataSource {
    internal func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        if let index = calendarVCs.indexOf(viewController) {
            if index > 0 {
                monthDelegate?.month((calendarVCs[index-1] as! B3FCalendarMonthVC).firstDayOfMonth)
                return calendarVCs[index-1]
            }
        }
        return nil
    }
    
    internal func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        if let index = calendarVCs.indexOf(viewController) {
            if (index+1) < calendarVCs.count {
                monthDelegate?.month((calendarVCs[index+1] as! B3FCalendarMonthVC).firstDayOfMonth)
                return calendarVCs[index+1]
            }
        }
        return nil
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return calendarVCs.count
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
