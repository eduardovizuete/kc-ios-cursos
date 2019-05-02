//
//  FundationExtension.swift
//  StartWars
//
//  Created by eduardo on 5/2/19.
//  Copyright © 2019 eduardo. All rights reserved.
//

import Foundation

extension Bundle {
    func url(forResource name: String) -> URL? {
        // split name
        let tokens = name.components(separatedBy: ".")
        
        // create url
        return url(forResource: tokens[0], withExtension: tokens[1])
    }
}
