//
//  B3FDailyUpdateListVC.swift
//  DailyUpdate
//
//  Created by Linda Zhong on 8/8/16.
//  Copyright © 2016 Linda Zhong. All rights reserved.
//

import UIKit

class B3FDailyUpdateItemCell: UITableViewCell {
    internal override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        textLabel?.font = UIFont.contentTextFont()
        detailTextLabel?.font = UIFont.contentTextFont()
        accessoryType = .DisclosureIndicator
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class B3FDailyUpdateList: NSObject {
    private var popover: Popover!
    
    private var dateLbl: UILabel! = {
        let l = UILabel(frame: CGRect(x: 0, y: 0, width: CGFloat(Float.dailyUpdatePopoverMaxWidth), height: 30))
        l.backgroundColor = UIColor.themeColor()
        l.textColor = UIColor.whiteColor()
        l.textAlignment = .Center
        l.font = UIFont.titleTextFont()
        return l
    }()
    private var listTV: UITableView! = {
        let t = UITableView(frame: CGRect(x: 0, y: 29, width: CGFloat(Float.dailyUpdatePopoverMaxWidth), height: 270))
        t.separatorStyle = .None
        t.registerClass(B3FDailyUpdateItemCell.classForCoder(), forCellReuseIdentifier: "B3FDailyUpdateItemCell")
        return t
    }()
    private var seperatorLine: UIView! = {
        let s = UIView(frame: CGRect(x: 0, y: 299, width: CGFloat(Float.dailyUpdatePopoverMaxWidth), height: 1))
        s.backgroundColor = UIColor.separatorLineColor()
        return s
    }()
    private var btn: UIButton! = {
        let b = UIButton(frame: CGRect(x: 0, y: 300, width: CGFloat(Float.dailyUpdatePopoverMaxWidth), height: 30))
        b.setTitle("Create Daily Update", forState: .Normal)
        b.setTitleColor(UIColor.textfontColor(), forState: .Normal)
        b.contentHorizontalAlignment = .Left
        b.titleLabel?.font = UIFont.contentTextFont()
        return b
    }()
    private var view: UIView! = {
        let v = UIView(frame: CGRect(x: 0, y: 0, width: CGFloat(Float.dailyUpdatePopoverMaxWidth), height: CGFloat(Float.dailyUpdatePopoverMaxHeight)))
        return v
    }()
    
    override init() {
        super.init()
        setup()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(B3FDailyUpdateList.rotated), name: UIDeviceOrientationDidChangeNotification, object: nil)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    private func setup() {
        listTV.delegate = self
        listTV.dataSource = self
        self.view.addSubview(dateLbl)
        self.view.addSubview(listTV)
        self.view.addSubview(seperatorLine)
        self.view.addSubview(btn)
        
    }
    
    private func refreshUI(date: NSDate) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        self.dateLbl.text = dateFormatter.stringFromDate(date)
    }
    
    @objc private func rotated() {
        self.popover.dismiss()
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
        if (Float(fromView.frame.origin.y) - Float.dailyUpdatePopoverMaxHeight) > 0 { return .Up }
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