//
//  Errors.swift
//  StartWars
//
//  Created by eduardo on 5/2/19.
//  Copyright © 2019 eduardo. All rights reserved.
//

import Foundation

enum StarWarsErrors: Error {
    case wrongURLFormatForJSONResource
    case resourcePointedByURLNotReachable
    case wrongJSONFormat
    case nilJSONObject
}
