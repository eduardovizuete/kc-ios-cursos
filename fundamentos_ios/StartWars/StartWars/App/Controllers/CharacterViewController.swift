//
//  CharacterViewController.swift
//  StartWars
//
//  Created by eduardo on 5/6/19.
//  Copyright © 2019 eduardo. All rights reserved.
//

import UIKit

class CharacterViewController: UIViewController {

    //MARK: - properties
    
    @IBOutlet weak var photoView: UIImageView!
    
    let model: StarWarsCharacters
    
    //MARK: - initialization
    init(model: StarWarsCharacters) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - view lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        syncViewWithModel()
    }
    
    //MARK: - sync view -> model
    func syncViewWithModel() {
        photoView.image = model.photo
        title = model.alias
    }
    //MARK: - actions
    @IBAction func playSound(_ sender: Any) {
    }
    
    @IBAction func displayWikipedia(_ sender: UIBarButtonItem) {
        // crear wikiVC
        let wVC = WikiViewController(model: model)
        
        // hacer push
        navigationController?.pushViewController(wVC, animated: true)
    }
}

