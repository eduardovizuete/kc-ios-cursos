//
//  StarWarsUniverse.swift
//  StartWars
//
//  Created by eduardo on 5/6/19.
//  Copyright © 2019 eduardo. All rights reserved.
//

import UIKit

// representa a un conjunto de personajes
class StarWarsUniverse {
    
    //MARK: - Utility types
    typealias StarWarsArray = [StarWarsCharacters]
    fileprivate typealias StarWarsDictionary = [StarWarsAffiliation: StarWarsArray]
    
    //MARK: - properties
    fileprivate var dict: StarWarsDictionary = StarWarsDictionary()
    
    //MARK: - initialization
    init(characters chars: StarWarsArray) {
        // asignamos afiliaciones y un StarWarsArray vacio a cada una de ellas
        dict = makeEmptyAffiliations()
        
        for each in chars {
            dict[each.affiliation]?.append(each)
        }
    }
    
    //MARK: - Utils
    fileprivate func makeEmptyAffiliations() -> StarWarsDictionary {
        var d = StarWarsDictionary()
        
        d[.rebelAlliance] = StarWarsArray()
        d[.galacticEmpire] = StarWarsArray()
        d[.firstOrder] = StarWarsArray()
        d[.jabbaCriminalEmpire] = StarWarsArray()
        
        return d
    }
    
    //MARK: - Accessors
    var affiliationCount: Int {
        get {
            // cuantas afliaciones hay
            return dict.count
        }
    }
    
    func characterCount(forAffiliation affiliation: StarWarsAffiliation) -> Int {
        guard let count = dict[affiliation]?.count else {
            return 0
        }
        
        return count
    }
    
    func character(atIndex index: Int,
                   forAffiliation affiliation: StarWarsAffiliation) -> StarWarsCharacters {
        let chars = dict[affiliation]!
        let char = chars[index]
        return char
    }
    
    
    
}
func affiliationName(_ affiliation: StarWarsAffiliation) -> String {
    return affiliation.rawValue
}
