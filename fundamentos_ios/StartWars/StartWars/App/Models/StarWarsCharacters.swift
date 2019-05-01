//
//  StarWarsCharacters.swift
//  StartWars
//
//  Created by eduardo on 5/1/19.
//  Copyright © 2019 eduardo. All rights reserved.
//

import Foundation
import UIKit

class StarWarsCharacters {
    
    //MARK: - Stored properties
    let firstName   :   String?
    let lastName    :   String?
    let alias       :   String
    let soundData   :   Data
    let photo       :   UIImage
    let url         :   URL
    let affiliation :   StarWarsAffiliation
    
    //MARK: - Computed properties
    var name: String? {
        get {
            guard let first = firstName else {
                return lastName
            }
            
            guard let last = lastName else {
                return first
            }
            
            return "\(first) \(last)"
        }
    }
    
    //MARK: - Initialization
    init(firstName: String?,
         lastName: String?,
         alias: String,
         sound: Data,
         photo: UIImage,
         wikiURL: URL,
         affiliation: StarWarsAffiliation) {
        
        self.firstName = firstName
        self.lastName = lastName
        self.alias = alias
        soundData = sound
        self.photo = photo
        url = wikiURL
        self.affiliation = affiliation
        
    }
    
    convenience init(alias: String,
                     soundData: Data,
                     photo: UIImage,
                     url: URL,
                     affiliation: StarWarsAffiliation) {
        self.init(firstName: nil,
                  lastName: nil,
                  alias: alias,
                  sound: soundData,
                  photo: photo,
                  wikiURL: url,
                  affiliation: affiliation)
    }
    
}
