//
//  ObjectDataSource.swift
//  M3 - Feed Reader
//  M6 - Data source for our tableView
//  Created by Uri on 15/4/23.
//

import Foundation
import UIKit

class ObjectDataSource: NSObject, UITableViewDataSource {
    
    var posts = [Post]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let postTitle = posts[indexPath.row].title
        cell.textLabel?.text = postTitle
        return cell
    }
}
