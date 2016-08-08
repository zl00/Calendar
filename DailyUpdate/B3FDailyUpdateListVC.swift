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

class B3FDailyUpdateList: UIViewController {
    private var popover: Popover!
//    private var listTV: UITableView! = UITableView(frame: CGRect(x: 0, y: 0, width: 400, height: 300))
    
    @IBOutlet weak var listTV: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.listTV.delegate = self
        self.listTV.dataSource = self
        self.listTV.registerClass(B3FDailyUpdateItemCell.classForCoder(), forCellReuseIdentifier: "B3FDailyUpdateItemCell")
        self.view.frame = CGRect(x: 0, y: 0, width: 400, height: 300)
        self.listTV.frame = CGRect(x: 0, y: 0, width: 400, height: 300)
    }
    
    internal func showFromView(from fromView: UIView) {
        self.popover = Popover(options: [.Type(estimatePopoverType(fromView)),
                                         .BlackOverlayColor(UIColor.overlayColor())], showHandler: nil, dismissHandler: nil)
        self.view.frame = CGRect(x: 0, y: 0, width: 400, height: 300)
        self.popover.show(self.view, fromView: fromView)
    }
    
}

extension B3FDailyUpdateListVC {
    private func estimatePopoverType(fromView: UIView) -> PopoverType{
        if (Float(fromView.frame.origin.y) - 410) > 0 { return .Up }
        else { return .Down }
    }
}

extension B3FDailyUpdateListVC: UITableViewDataSource {
    internal func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    internal func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("B3FDailyUpdateItemCell", forIndexPath: indexPath)
        cell.textLabel?.text = "Hello world!"
        return cell
    }
}

extension B3FDailyUpdateListVC: UITableViewDelegate {
    internal func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50.0
    }
}