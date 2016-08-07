//
//  B3FCalendarVC.swift
//  DailyUpdate
//
//  Created by Linda Zhong on 8/2/16.
//  Copyright © 2016 Linda Zhong. All rights reserved.
//

import UIKit

class B3FCalendarVC: UIViewController {

    @IBOutlet weak var calendarCV: UICollectionView!
    private var firstDayOfMonth: NSDate = NSDate().firstDayOfMonth()!
    private var days: Array<B3FDateType> = []
    
    internal func prepareData(date: NSDate) -> Void {
        NSLog("set date \(date)")
        self.firstDayOfMonth = date.firstDayOfMonth()!
        let indexOfFirstDay = self.firstDayOfMonth.weekDay()
        let indexOfLastDay = indexOfFirstDay + self.firstDayOfMonth.daysOfMonth() - 1
        let cellCount = self.firstDayOfMonth.aboutWeeksOfMonth() * 7
        var cellIndex = 0
        self.days = []
        
        while cellIndex < cellCount {
            var dateN: B3FDateType?
            if cellIndex >= indexOfFirstDay && cellIndex <= indexOfLastDay {
                let date = self.firstDayOfMonth.dateByAddingDays(cellIndex-indexOfFirstDay)!
                dateN = .Date(date)
            }
            else { dateN = .NotDate } // TODO:
            
            self.days.append(dateN!)
            cellIndex += 1
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCalendarUI()
    }
    
    private func setupCalendarUI() -> Void {
        self.calendarCV.delegate = self
        self.calendarCV.dataSource = self
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator)
    {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        coordinator.animateAlongsideTransition({ (context) -> Void in // ui is a little strange.the perfect solution is to pre-calculate the size of different oritation
            }, completion: { (context) -> Void in
            self.calendarCV.reloadData()
        })
    }
    
}

// MARK: - calculates height...
extension B3FCalendarVC {    
    func calcCellHeight() -> Float {
        let h = Float(self.calendarCV.frame.size.height - 1.0) / Float(firstDayOfMonth.aboutWeeksOfMonth())
        
//        NSLog("height:\(h) \(UIDevice.currentDevice().orientation.isLandscape)")
        return h
    }
    
    func calcCellWidth() -> Float {
        let w = Float(self.calendarCV.frame.size.width - 1.0) / 7.0
//        NSLog("width:\(w)")
        return w
    }
}

extension B3FCalendarVC: UICollectionViewDataSource {
    internal func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.firstDayOfMonth.aboutWeeksOfMonth() * 7
    }
    
    internal func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    internal func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: B3FDateCell = self.calendarCV.dequeueReusableCellWithReuseIdentifier("B3FDateCell", forIndexPath: indexPath) as! B3FDateCell
        cell.updateData(days[indexPath.row])
        
        return cell
    }
}

extension B3FCalendarVC: UICollectionViewDelegate {
    
}

extension B3FCalendarVC: UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(CGFloat(self.calcCellWidth()), CGFloat(self.calcCellHeight()))
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsZero
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
}

