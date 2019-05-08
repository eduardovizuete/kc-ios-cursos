//
//  CharacterViewController.swift
//  StartWars
//
//  Created by eduardo on 5/6/19.
//  Copyright © 2019 eduardo. All rights reserved.
//

import UIKit
import AVFoundation

class CharacterViewController: UIViewController {

    //MARK: - properties
    
    @IBOutlet weak var photoView: UIImageView!
    
    var model: StarWarsCharacters
    
    var player: AVAudioPlayer?
    
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
        do {
            // avisamos que vamos a reproducir sonido
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            // le decimos que formato de sonido vamos a reproducir
            player = try AVAudioPlayer(data: model.soundData, fileTypeHint: AVFileType.caf.rawValue)
            
            // reproducir el sonido
            player?.play()
        } catch let error as NSError {
            print("error reproduciendo sonido")
            print("\(error)")
        }
    }
    
    @IBAction func displayWikipedia(_ sender: UIBarButtonItem) {
        // crear wikiVC
        let wVC = WikiViewController(model: model)
        
        // hacer push
        navigationController?.pushViewController(wVC, animated: true)
    }
}

//MARK: - Protocols
extension CharacterViewController: UniverseTableViewControllerDelegate {
    func universeTableViewControllerDelegate(_ uVC: UniverseTableViewController, didSelectedCharacter char: StarWarsCharacters) {
        model = char
        syncViewWithModel()
    }
}
