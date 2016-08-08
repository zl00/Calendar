//
//  B3FDailyUpdateListVC.swift
//  DailyUpdate
//
//  Created by Linda Zhong on 8/8/16.
//  Copyright © 2016 Linda Zhong. All rights reserved.
//

import UIKit

class B3FDailyUpdateItemCell: UITableViewCell {
    
}

class B3FDailyUpdateList: NSObject {
    private var popover: Popover!
    private var dateLbl: UILabel! = UILabel(frame: CGRect(x: 0, y: 0, width: 400, height: 30))
    private var listTV: UITableView! = UITableView(frame: CGRect(x: 0, y: 30, width: 400, height: 270))
    private var btn: UIButton! = UIButton(frame: CGRect(x: 0, y: 300, width: 400, height: 30))
    private var view: UIView! = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 330))
    override init() {
        super.init()
        setup()
    }
    
    private func setup() {
        self.view.addSubview(dateLbl)
        self.view.addSubview(listTV)
        self.view.addSubview(btn)
        self.listTV.delegate = self
        self.listTV.dataSource = self
        self.listTV.registerClass(B3FDailyUpdateItemCell.classForCoder(), forCellReuseIdentifier: "B3FDailyUpdateItemCell")
        dateLbl.backgroundColor = UIColor.btnColor()
        dateLbl.textColor = UIColor.whiteColor()
        dateLbl.textAlignment = .Center
        btn.setTitle("Create Daily Update", forState: .Normal)
        btn.backgroundColor = UIColor.btnColor()
    }
    
    private func refreshUI(date: NSDate) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        self.dateLbl.text = dateFormatter.stringFromDate(date)
    }
    
    internal func showFromView(from fromView: UIView, date: NSDate) {
        refreshUI(date)
        self.popover = Popover(options: [.Type(estimatePopoverType(fromView)),
                                         .BlackOverlayColor(UIColor.overlayColor())], showHandler: nil, dismissHandler: nil)
        self.popover.show(self.view, fromView: fromView)
    }
}

extension B3FDailyUpdateList {
    private func estimatePopoverType(fromView: UIView) -> PopoverType{
        if (Float(fromView.frame.origin.y) - 410) > 0 { return .Up }
        else { return .Down }
    }
}

extension B3FDailyUpdateList: UITableViewDataSource {
    internal func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    internal func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("B3FDailyUpdateItemCell", forIndexPath: indexPath)
        cell.textLabel?.text = "Hello world!"
        return cell
    }
}

extension B3FDailyUpdateList: UITableViewDelegate {
    internal func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50.0
    }
}