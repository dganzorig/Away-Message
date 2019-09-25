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
    private var suggestions: [Suggestion]?
    
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
    
    override func viewDidAppear(_ animated: Bool) {
        FirebaseService.getAllSuggestions { (suggestions) in
            if suggestions == nil {
                self.showToast(message: "Error loading suggestions")
            } else {
                self.suggestions = suggestions
                self.tableView.reloadData()
            }
        }
    }
    
    func showToast(message: String) {
        Toast.show(message: message, controller: self)
    }

}

extension PopularSuggestionsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.suggestions?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PopularSuggestionsCell = tableView.dequeueReusableCell(withIdentifier: "popularSuggestionsCell") as! PopularSuggestionsCell
        if let suggestion = self.suggestions?[indexPath.row] {
            cell.viewController = self
            cell.suggestion = suggestion
            cell.messageLabel.text = suggestion.message
            
            let likeState: LikeState = RealmService.hasLikedSuggestion(docId: suggestion.docId) ? .like : .none
            let likeButtonColor: UIColor = (likeState == .like) ? UIColor.red : UIColor.lightGray
            cell.heartButton.setTitleColor(likeButtonColor, for: .normal)
        }
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        // first hide from view
//        cell.transform = CGAffineTransform(translationX: UIScreen.main.bounds.width, y: 0.0)
//
//        UIView.animate(withDuration: 0.5, delay: 0.2 * Double(indexPath.row + 1), options: .curveEaseOut, animations: {
//            cell.transform = .identity
//        }, completion: nil)
//    }
    
}
