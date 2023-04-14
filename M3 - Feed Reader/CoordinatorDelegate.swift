//
//  CoordinatorDelegate.swift
//  M3 - Feed Reader
//  M5 - Delegate pattern
//  Created by Uri on 14/4/23.
//

import Foundation
import UIKit

protocol CoordinatorDelegate {
    static func instantiate() -> Self
}

// extension lets us extend and implement the protocol, we can't do it in its declaration
// if the protocol has an implementation, it doesn't have to be implemented when associating it to a class
extension CoordinatorDelegate where Self: UIViewController {
    
    // method to return the VC inside Main
    static func instantiate() -> Self {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(identifier: id) as! Self
    }
}
