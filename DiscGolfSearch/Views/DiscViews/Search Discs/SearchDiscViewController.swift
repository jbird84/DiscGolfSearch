//
//  SearchDiscViewController.swift
//  DiscGolfSearch
//
//  Created by Kinney Kare on 9/24/23.
//

import UIKit

class SearchDiscViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var allDisc: [DiscGolfDisc] = []
    var filteredDiscsData: [DiscGolfDisc]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        searchBar.delegate = self
        searchBar.placeholder = "Start typing a disc name"
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let savedDiscsData = UserDefaults.standard.data(forKey: "allDiscs") {
            // Attempt to decode the data into an array of DiscGolfDisc objects
            if let savedDiscs = try? JSONDecoder().decode([DiscGolfDisc].self, from: savedDiscsData) {
                self.allDisc = savedDiscs
                self.filteredDiscsData = savedDiscs
                self.tableView.reloadData()
            }
        }
    }
    
    private func setupNavigationBar() {
        self.title = "Search A Disc"
        
        // Customize the navigation bar appearance
        if let navigationBar = self.navigationController?.navigationBar {
            navigationBar.barTintColor = UIColor.white
            navigationBar.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.white,
                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 27)
            ]
            navigationBar.tintColor = UIColor.white
        }
    }
}

extension SearchDiscViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredDiscsData.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as! SearchDiscCell
        
        cell.discNameLabel.text = filteredDiscsData[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let disc = filteredDiscsData[indexPath.item]
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "discVC") as? DiscViewController {
            vc.disc = disc
            self.searchBar.text = ""
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

extension SearchDiscViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredDiscsData = []
        if searchText.isEmpty {
            // If search text is empty, show all discs
            filteredDiscsData = allDisc
        } else {
            // Filter the data based on the search text
            filteredDiscsData = allDisc.filter { disc in
                // Check if the disc name contains all characters in the search text
                return searchText.allSatisfy { char in
                    disc.name.lowercased().contains(char.lowercased())
                }
            }
        }
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // Dismiss the keyboard when the "Search" button is clicked
        searchBar.resignFirstResponder()
    }
}








