//
//  ViewController.swift
//  TADynamicHeaderTableView
//
//  Created by anhdt64 on 9/17/18.
//  Copyright © 2018 FPT. All rights reserved.
//

import UIKit

class ViewController: TATableViewWithDynamicHeaderViewController, UITableViewDataSource {

    @IBOutlet weak var tableViewContent: UITableView!
    @IBOutlet weak var headerHConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupWithHeaderHeight(maxHeight: 200, minHeight: 80, contentTable: self.tableViewContent, headerHeightConstraint: self.headerHConstraint)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel!.text = "Cell \(indexPath.row)"
        return cell
    }
}

