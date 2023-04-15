//
//  ViewController.swift
//  M3 - Feed Reader
//
//  Created by Uri on 8/4/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    var parser: XMLParser = XMLParser()
    var myTitle = String()
    var myLink = String()
    var myName = String()
    
    var dataSource = ObjectDataSource()
    var coordinator: MainCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        parseXML()
    }
    
    private func configureTableView(){
        self.tableView.tableFooterView = UIView() // footer of TV is an empty uiview, shows no empty cells
    }
    
    private func parseXML() {
        guard let url = URL(string: "\(Constants.URL.main)\(Constants.EndPoint.feed)") else { return }
        guard let parser = XMLParser(contentsOf: url) else { return }
        
        parser.delegate = self
        parser.parse()
    }
}

// MARK: - Extensions

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.goToDetailVC(data: dataSource.posts[indexPath.row].link)
    }
}

extension ViewController: XMLParserDelegate {
    
    // what to do which each element (item) of the xml file
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        myName = elementName
        if elementName == "item" {
            // initialize from scratch my class' strings, deleting any previous existing value
            myTitle = String()
            myLink = String()
        }
    }
    
    // clean whitespaces and assign title & link from data
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        if !data.isEmpty {
            if myName == "title" {
                myTitle += data
            } else if myName == "link" {
                myLink += data
            }
        }
    }
    
    // create a Post object with myTitle & myLink as params
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            let dataPost = Post(title: myTitle, link: myLink)
            dataSource.posts.append(dataPost)
        }
    }
}

extension ViewController: CoordinatorDelegate {
}

