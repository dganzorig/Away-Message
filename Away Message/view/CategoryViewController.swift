//
//  CategoryViewController.swift
//  Away Message
//
//  Created by Dona Ganzorig on 9/19/19.
//  Copyright © 2019 Dona Ganzorig. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}

extension CategoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AppConstants.awayMessageDict.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CategoryCell = tableView.dequeueReusableCell(withIdentifier: "categoryCell") as! CategoryCell
        let currentEntry: CategoryEntry = self.getEntryAtIndex(index: indexPath.row)
        cell.emojiLabel.text = currentEntry.emoji
        cell.categoryLabel.text = currentEntry.category
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // calling deselectRow to allow only 'flash' graying out of selected row
        // tableView.deselectRow(at: indexPath, animated: true)
        
        // transition to screen showing messages for selected category
        performSegue(withIdentifier: "toSuggestions", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSuggestions" {
            let destinationVC: CategorySuggestionViewController = segue.destination as! CategorySuggestionViewController
            if let index: Int = tableView.indexPathForSelectedRow?.row {
                destinationVC.categoryEntry = self.getEntryAtIndex(index: index)
            }
        }
    }
    
    private func getEntryAtIndex(index: Int) -> CategoryEntry {
        let currentKey: String = Array(AppConstants.awayMessageDict.keys)[index]
        guard let currentEntry: CategoryEntry = AppConstants.awayMessageDict[currentKey] else { fatalError() }
        return currentEntry
    }
    
}
