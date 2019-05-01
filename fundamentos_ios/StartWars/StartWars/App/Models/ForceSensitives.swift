//
//  ForceSensitives.swift
//  StartWars
//
//  Created by eduardo on 5/1/19.
//  Copyright © 2019 eduardo. All rights reserved.
//

import Foundation
import UIKit

class ForceSensitives: StarWarsCharacters {
    
    //MARK: - Stored properties
    let midichlorians: Int
    
    //MARK: - Initialization
    init(firstName: String?, lastName: String?,
         alias: String, sound: Data,
         photo: UIImage, wikiURL: URL,
         affiliation: StarWarsAffiliation, midichlorians: Int) {
        
        self.midichlorians = midichlorians
        
        super.init(firstName: firstName, lastName: lastName, alias: alias, sound: sound, photo: photo, wikiURL: wikiURL, affiliation: affiliation)
    }
    
    convenience init(jediWithFirstName: String?, lastName: String?,
                     alias: String, soundData: Data,
                     photo: UIImage, url: URL,
                     midichlorians: Int) {
        self.init(firstName: jediWithFirstName, lastName: lastName, alias: alias, sound: soundData, photo: photo, wikiURL: url, affiliation: .rebelAlliance, midichlorians: midichlorians)
    }
    
    convenience init(sithWithFirstName: String?, lastName: String?,
                     alias: String, soundData: Data,
                     photo: UIImage, url: URL,
                     midichlorians: Int) {
        self.init(firstName: sithWithFirstName, lastName: lastName,
                  alias: alias, sound: soundData,
                  photo: photo, wikiURL: url,
                  affiliation: .galacticEmpire, midichlorians: midichlorians)
    }
    
    //MARK: - Proxies
    override func proxyForEquality() -> String {
        return "\(super.proxyForEquality()) \(midichlorians)"
    }
    
    override func proxyForComparison() -> String {
        return proxyForEquality()
    }
    
}
