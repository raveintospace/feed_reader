//
//  ViewController.swift
//  M3 - Feed Reader
//
//  Created by Uri on 8/4/23.
//

import UIKit

class ViewController: UIViewController, CoordinatorDelegate {

    @IBOutlet private weak var tableView: UITableView!
    
    var dataSource = ObjectDataSource()
    var coordinator: MainCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureTableViewDataSource()
        parseXML(url: "\(Constants.URL.main)\(Constants.EndPoint.feed)")
    }
    
    private func configureTableView(){
        self.tableView.tableFooterView = UIView() // footer of TV is an empty uiview, shows no empty cells
    }
    
    private func configureTableViewDataSource(){
        self.tableView.dataSource = self.dataSource
    }
    
    // method to serialize our XML
    private func parseXML(url: String) {
        guard let url = URL(string: url) else { return }
        guard let parser = XMLParser(contentsOf: url) else { return }
        
        let xmlManager = XMLManager()
        xmlManager.callBack = { posts in
            self.dataSource.posts = posts!      // send the data to our dataSource
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        parser.delegate = xmlManager
        parser.parse()
    }
}

// MARK: - Extensions

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.goToDetailVC(data: dataSource.posts[indexPath.row].link)
    }
}
