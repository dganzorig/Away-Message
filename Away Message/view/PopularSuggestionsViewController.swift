//
//  PopularSuggestionsViewController.swift
//  Away Message
//
//  Created by Dona Ganzorig on 9/24/19.
//  Copyright © 2019 Dona Ganzorig. All rights reserved.
//

import UIKit

class PopularSuggestionsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var messages = ["This is the first message", "This is the second message"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
    }

}

extension PopularSuggestionsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PopularSuggestionsCell = tableView.dequeueReusableCell(withIdentifier: "popularSuggestionsCell") as! PopularSuggestionsCell
        cell.messageLabel.text = self.messages[indexPath.row]
        return cell
    }
    
    
    //
    
}
