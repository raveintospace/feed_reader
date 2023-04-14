//
//  Coordinator.swift
//  M3 - Feed Reader
//
//  Created by Uri on 14/4/23.
//

import Foundation
import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}

