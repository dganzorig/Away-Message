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
        tableView.tableFooterView = UIView()
        
        titleLabel.transform = CGAffineTransform(translationX: UIScreen.main.bounds.width, y: 0.0)
        
        UIView.animate(withDuration: 0.5) {
            self.titleLabel.transform = .identity
        }
        
        if let entry: CategoryEntry = self.categoryEntry {
            titleLabel.text = "\(entry.emoji) \(entry.category)"
        } else {
            titleLabel.text = ""
        }
    }
    
    func showToast(message: String) {
        Toast.show(message: message, controller: self)
    }

}

extension CategorySuggestionViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categoryEntry?.messages.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CategorySuggestionCell = tableView.dequeueReusableCell(withIdentifier: "categorySuggestionCell", for: indexPath) as! CategorySuggestionCell
        cell.messageLabel.text = self.categoryEntry?.messages[indexPath.row] ?? ""
        cell.viewController = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // first hide from view
        cell.transform = CGAffineTransform(translationX: UIScreen.main.bounds.width, y: 0.0)
        
        UIView.animate(withDuration: 0.5, delay: 0.2 * Double(indexPath.row + 1), options: .curveEaseOut, animations: {
            cell.transform = .identity
        }, completion: nil)
    }
    
}
