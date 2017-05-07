//
//  ViewController.swift
//  iMessage短信聊天界面
//
//  Created by Mac on 2017/5/5.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{

    var leftItem = UIBarButtonItem()
    
    var dataArrayName:Array = ["张三", "李四", "王二", "麻子", "枪手"]
    var dataArrayData:Array = ["2011/2/25", "2012/2/25", "2013/2/25", "2014/2/25", "2016/2/25"]
    var dataArrayDetail: Array = [ "1这是一个短信的内容，张三，晚上过来吃饭么， 这是一个短信的内容，张三，晚上过来吃饭么， 这是一个短信的内容，张三，晚上过来吃饭么", " 2这是一个短信的内容，张三，晚上过来吃饭么， 这是一个短信的内容，张三，晚上过来吃饭么， 这是一个短信的内容，张三，晚上过来吃饭么", " 3这是一个短信的内容，张三，晚上过来吃饭么， 这是一个短信的内容，张三，晚上过来吃饭么， 这是一个短信的内容，张三，晚上过来吃饭么" ," 4这是一个短信的内容，张三，晚上过来吃饭么， 这是一个短信的内容，张三，晚上过来吃饭么， 这是一个短信的内容，张三，晚上过来吃饭么" , " 5这是一个短信的内容，张三，晚上过来吃饭么， 这是一个短信的内容，张三，晚上过来吃饭么， 这是一个短信的内容，张三，晚上过来吃饭么"]
    var tableView = UITableView(frame: CGRectMake(0, 30, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height-64-30), style: .Plain)
    
    lazy var searchBar: UISearchBar = {
        var tempSearchBar = UISearchBar(frame: CGRectMake(0, 64, UIScreen.mainScreen().bounds.size.width, 30))
        tempSearchBar.placeholder = "输入文字进行查找"
        return tempSearchBar
    }()
    
    lazy var bgView: UIView = {
        var tempbgView = UIView(frame: CGRectMake(0, 64 + 30, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height-64-30))
        tempbgView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        return tempbgView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
        
    }
    
    
    func configUI() {
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        leftItem = UIBarButtonItem(title: "Edit", style: .Plain, target: self, action: #selector(ViewController.leftItemClick))
        self.navigationItem.leftBarButtonItem = leftItem
        let rightItem = UIBarButtonItem(barButtonSystemItem: .Action, target: self, action: #selector(ViewController.rightItemClick))
        self.navigationItem.rightBarButtonItem = rightItem
        
        self.title = "信息"
        bgView.hidden = true

        self.view.addSubview(tableView)
        self.view.addSubview(searchBar)
        self.view.addSubview(bgView)
        
    }
    
    func rightItemClick() {
        
        let newMessageController = NSBundle.mainBundle().loadNibNamed("NewMessageViewController", owner: nil, options: nil)?.first as! NewMessageViewController
        self.navigationController?.pushViewController(newMessageController, animated: true)
    }
    
    func leftItemClick() {
        
        if tableView.editing == true {
            leftItem.title = "Edit"
            tableView.editing = false
        }else{
            leftItem.title = "Done"
            tableView.editing = true
        }
    }
    
    //MARK: -UISearchBarDelegate
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        bgView.hidden = false
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        bgView.hidden = true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        searchBar.resignFirstResponder()
    }
    
    //MARK: -UITableViewDelegate and UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArrayDetail.count
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell") as? iMessageTableViewCell
        
        if cell == nil {
            cell = NSBundle.mainBundle().loadNibNamed("iMessageTableViewCell", owner: self, options: nil)?.last as? iMessageTableViewCell
        }
        
        cell?.datailTextLabel.text = dataArrayDetail[indexPath.row]
        cell?.dataLabel.text = dataArrayData[indexPath.row]
        cell?.titleTextLabel.text = dataArrayName[indexPath.row]
        
        return cell!
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    //MARK: -UITableViewEdit
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String? {
        return "删除"
    }
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return .Delete
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            dataArrayDetail.removeAtIndex(indexPath.row)
            dataArrayData.removeAtIndex(indexPath.row)
            dataArrayName.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Left)
        }
    }


}

