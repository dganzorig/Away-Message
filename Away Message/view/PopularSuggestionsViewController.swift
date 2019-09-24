//
//  PopularSuggestionsViewController.swift
//  Away Message
//
//  Created by Dona Ganzorig on 9/24/19.
//  Copyright © 2019 Dona Ganzorig. All rights reserved.
//

import UIKit

class PopularSuggestionsViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var messages = [ "This is the first message", "This is the second message that is really really really really really really really really REAAAALLLYYY loooooonnnngg", "Some other message that is still pretty decently long for example's purposes", "Filler", "Filler", "Filler", "Filler" ]
    
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
    }
    
    func showToast(message: String) {
        Toast.show(message: message, controller: self)
    }

}

extension PopularSuggestionsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PopularSuggestionsCell = tableView.dequeueReusableCell(withIdentifier: "popularSuggestionsCell") as! PopularSuggestionsCell
        cell.viewController = self
        cell.messageLabel.text = self.messages[indexPath.row]
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
