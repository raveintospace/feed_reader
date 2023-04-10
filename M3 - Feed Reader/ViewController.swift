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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

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

