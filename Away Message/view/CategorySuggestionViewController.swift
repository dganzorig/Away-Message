//
//  CategorySuggestionViewController.swift
//  Away Message
//
//  Created by Dona Ganzorig on 9/20/19.
//  Copyright © 2019 Dona Ganzorig. All rights reserved.
//

import UIKit

class CategorySuggestionViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var categoryEntry: CategoryEntry?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        
        if let entry: CategoryEntry = self.categoryEntry {
            titleLabel.text = "\(entry.emoji) \(entry.category)"
        } else {
            titleLabel.text = ""
        }
    }

}

extension CategorySuggestionViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categoryEntry?.messages.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CategorySuggestionCell = tableView.dequeueReusableCell(withIdentifier: "categorySuggestionCell", for: indexPath) as! CategorySuggestionCell
        cell.messageLabel.text = self.categoryEntry?.messages[indexPath.row] ?? ""
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
