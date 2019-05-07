//
//  CharacterViewController.swift
//  StartWars
//
//  Created by eduardo on 5/6/19.
//  Copyright © 2019 eduardo. All rights reserved.
//

import UIKit

class CharacterViewController: UIViewController {

    let model: StarWarsCharacters
    
    init(model: StarWarsCharacters) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
