//
//  ViewController.swift
//  iOSSearchTest
//
//  Created by 白彬涵 on 2017/10/30.
//  Copyright © 2017年 CMIOT. All rights reserved.
//

import UIKit
import PYSearch

class ViewController: UITableViewController {
    var searchController: UISearchController?
    override func viewDidLoad() {
        super.viewDidLoad()
        initSearchViewController()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


// MARK: - Some Functions
extension ViewController {
    func initSearchViewController() {
        searchController = UISearchController.init(searchResultsController: nil)
        searchController?.searchResultsUpdater = self
        searchController?.dimsBackgroundDuringPresentation = false
        searchController?.definesPresentationContext = true
        tableView.tableHeaderView = searchController?.searchBar
    }
}


// MARK: - UISearchResultsUpdating
extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        tableView.reloadData()
    }
}

// MARK: - TableViewDataSource
extension ViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (searchController?.isActive)! && searchController?.searchBar.text != "" {
            return 3
        }
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        return cell!
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
}

