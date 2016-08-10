//
//  B3FCalendarMonthVC.swift
//  DailyUpdate
//
//  Created by Linda Zhong on 8/2/16.
//  Copyright © 2016 Linda Zhong. All rights reserved.
//

import UIKit

public protocol B3FDateCellDelegate: NSObjectProtocol {
    func dateCell(date: NSDate, didSelectItemAtView fromView: UIView);
    func dateCell(date: NSDate, didDeselectItemAtView fromView: UIView);
}

class B3FCalendarMonthVC: UIViewController {

    internal var dateDelegate: B3FDateCellDelegate?
    
    @IBOutlet weak var calendarCV: UICollectionView!
    
    private(set) var firstDayOfMonth: NSDate = NSDate().firstDayOfMonth()!
    private var days: Array<B3FDateType> = []
    private let lineSpacing: Float = 1.0
    
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
            else { dateN = .NotDate }
            
            self.days.append(dateN!)
            cellIndex += 1
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCalendarUI()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func setupCalendarUI() -> Void {
        self.calendarCV.backgroundColor = UIColor.borderColor()
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
extension B3FCalendarMonthVC {
    func calcCellHeight() -> Float {
        let weekCount = Float(firstDayOfMonth.aboutWeeksOfMonth())
        let h = (Float(self.calendarCV.frame.size.height)-(weekCount-1)*lineSpacing) / weekCount
//        NSLog("height:\(h) \(UIDevice.currentDevice().orientation.isLandscape)")
        return h
    }
    
    func calcCellWidth() -> Float {
        let w = (Float(self.calendarCV.frame.size.width)-6*lineSpacing-10) / 7.0
//        NSLog("width:\(w)")
        return w
    }
}

// MARK: - UICollectionViewDataSource
extension B3FCalendarMonthVC: UICollectionViewDataSource {
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


// MARK: - UICollectionViewDelegate
extension B3FCalendarMonthVC: UICollectionViewDelegate {
    internal func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! B3FDateCell
        if let type = cell.dateType {
            switch type {
            case .Date(let date):
                self.dateDelegate?.dateCell(date, didSelectItemAtView: cell)
            default:
                break
            }
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension B3FCalendarMonthVC: UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(CGFloat(self.calcCellWidth()), CGFloat(self.calcCellHeight()))
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsZero
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return CGFloat(lineSpacing)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return CGFloat(lineSpacing)
    }
}

