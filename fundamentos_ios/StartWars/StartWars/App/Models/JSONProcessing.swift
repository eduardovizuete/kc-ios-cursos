//
//  JSONProcessing.swift
//  StartWars
//
//  Created by eduardo on 5/2/19.
//  Copyright © 2019 eduardo. All rights reserved.
//

import Foundation
import UIKit

//MARK: - Aliases
typealias JSONObject = AnyObject
typealias JSONDictionary = [String: JSONObject]
typealias JSONArray = [JSONDictionary]

//MARK: - Decodification
func decode(starWarsCharacter json: JSONDictionary) throws ->  StarWarsCharacters {
    // validate dictionary
    guard let urlString = json["url"] as? String,
        let url = URL(string: urlString) else {
        throw StarWarsErrors.wrongURLFormatForJSONResource
    }
    
    guard let imageName = json["imageFile"] as? String,
        let image = UIImage(named: imageName) else {
            throw StarWarsErrors.resourcePointedByURLNotReachable
    }
    
    guard let soundName = json["soundFile"] as? String,
        let soundURL = Bundle.main.url(forResource: soundName),
        let sound = try? Data(contentsOf: soundURL) else {
            throw StarWarsErrors.resourcePointedByURLNotReachable
    }
    
    let firstName = json["firstName"] as? String
    let lastName = json["lastName"] as? String
    let alias = json["alias"] as? String
    
    if let affiliation = json["affiliation"] as? String {
        // create StarWarsAffiliation
        return StarWarsCharacters(firstName: firstName, lastName: lastName, alias: alias, sound: sound, photo: image, wikiURL: url, affiliation: StarWarsAffiliation.by(name: affiliation))
    } else {
        throw StarWarsErrors.wrongJSONFormat
    }
}

func decode(starWarsCharacter json: JSONDictionary?) throws -> StarWarsCharacters {
    guard let json = json else {
        throw StarWarsErrors.nilJSONObject
    }
    
    return try decode(starWarsCharacter: json)
}

func decode(forceSensitive json: JSONDictionary) throws -> ForceSensitives {
    // validate dictionary
    guard let urlString = json["url"] as? String,
        let url = URL(string: urlString) else {
            throw StarWarsErrors.wrongURLFormatForJSONResource
    }
    
    guard let imageName = json["imageFile"] as? String,
        let image = UIImage(named: imageName) else {
            throw StarWarsErrors.resourcePointedByURLNotReachable
    }
    
    guard let soundName = json["soundFile"] as? String,
        let soundURL = Bundle.main.url(forResource: soundName),
        let sound = try? Data(contentsOf: soundURL) else {
            throw StarWarsErrors.resourcePointedByURLNotReachable
    }
    
    guard let jedi = json["jedi"] as? Bool,
        let sith = json["sith"] as? Bool,
        let md = json["midichlorians"] as? Int else {
            throw StarWarsErrors.wrongJSONFormat
    }
    
    guard jedi != sith else {
        throw StarWarsErrors.wrongJSONFormat
    }
    
    let firstName = json["firstName"] as? String
    let lastName = json["lastName"] as? String
    let alias = json["alias"] as? String
    
    if let affiliation = json["affiliation"] as? String {
        // create ForceSensitives
        return ForceSensitives(firstName: firstName, lastName: lastName, alias: alias, sound: sound, photo: image, wikiURL: url, affiliation: StarWarsAffiliation.by(name: affiliation), midichlorians: md)
    } else {
        throw StarWarsErrors.wrongJSONFormat
    }
}

func decode(forceSenstitive json: JSONDictionary?) throws -> ForceSensitives {
    guard let json = json else {
        throw StarWarsErrors.nilJSONObject
    }
    
    return try decode(forceSensitive: json)
}

//MARK: - Loading
func loadFromLocalFile(filename name: String, bundle: Bundle = Bundle.main) throws -> JSONArray {
    
    if let url = bundle.url(forResource: name),
        let data = try? Data.init(contentsOf: url),
        let maybeArray = try? JSONSerialization.jsonObject(with: data,
                                                          options: JSONSerialization.ReadingOptions.mutableContainers) as? JSONArray,
        let array = maybeArray {
        return array
    } else {
        throw StarWarsErrors.jsonParcingError
    }
}
