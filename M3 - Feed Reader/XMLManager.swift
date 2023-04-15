//
//  XMLManager.swift
//  M3 - Feed Reader
//
//  Created by Uri on 15/4/23.
//

import Foundation
import UIKit

class XMLManager: NSObject, XMLParserDelegate {
    
    var posts = [Post]()
    var myTitle: String = ""
    var myLink: String = ""
    var myName: String = ""
    
    var callBack: (([Post]?) -> ())? // to send to VC the data that XMLParseDelegate will get
    
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
            callBack?(posts)
        }
    }
}
