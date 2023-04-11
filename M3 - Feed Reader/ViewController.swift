//
//  ViewController.swift
//  M3 - Feed Reader
//
//  Created by Uri on 8/4/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    var posts = [Post]()
    var parser: XMLParser = XMLParser()
    var myTitle = String()
    var myLink = String()
    var myName = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parseXML()
    }
    
    private func parseXML() {
        guard let url = URL(string: "https://www.cfeapps.com/feed") else { return }
        guard let parser = XMLParser(contentsOf: url) else { return }
        
        parser.delegate = self
        parser.parse()
    }
}

// MARK: - Extensions

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let postTitle = posts[indexPath.row].title
        cell.textLabel?.text = postTitle
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "" {
            guard let selectedCell = tableView.indexPathForSelectedRow?.row else { return }
            let selectedPost = posts[selectedCell]
            let detailView = segue.destination as! DetailViewController
            detailView.webContent = selectedPost.link
        }
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
            posts.append(dataPost)
        }
    }
    
}

