//
//  UniverseTableViewController.swift
//  StartWars
//
//  Created by eduardo on 5/6/19.
//  Copyright © 2019 eduardo. All rights reserved.
//

import UIKit

class UniverseTableViewController: UITableViewController {
    
    //MARK: - constants
    static let notificationName = Notification.Name("CharacterDidChange")
    static let characterKey = "CharacterKey"
    
    //MARK: - properties
    let model: StarWarsUniverse
    
    weak var delegate: UniverseTableViewControllerDelegate? = nil
    
    //MARK: - initialization
    init(model: StarWarsUniverse) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // descubrir la afiliacion
        let aff = getAffiliation(forSection: indexPath.section)
        
        // descubrir personaje
        let char = model.character(atIndex: indexPath.row, forAffiliation: aff)
        
        // avisar al delegado
        delegate?.universeTableViewControllerDelegate(self, didSelectedCharacter: char)
        
        // enviar notificacion
        notify(characterChanged: char)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return model.affiliationCount
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // cuantos personajes hay en esta aff
        return model.characterCount(forAffiliation: getAffiliation(forSection: section))
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return model.affiliationName(getAffiliation(forSection: section))
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // definir un id para el tipo de celda
        let cellId = "StarWarsCell"
        
        // averiguar la afiliacion
        let aff = getAffiliation(forSection: indexPath.section)
        
        // averiguar quien es el personaje
        let char = model.character(atIndex: indexPath.row, forAffiliation: aff)
        
        // crear la celda
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        
        if cell == nil {
            // el opcional esta vacio y toca crear la celda desde cero
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        }
        
        // configurar la celda
        cell?.imageView?.image = char.photo
        cell?.textLabel?.text = char.alias
        cell?.detailTextLabel?.text = char.name
        
        return cell!
    }

    
    //MARK: - Utils
    func getAffiliation(forSection section: Int) -> StarWarsAffiliation {
        var aff: StarWarsAffiliation = .unknown
        
        switch section {
        case 0:
            aff = .galacticEmpire
        case 1:
            aff = .rebelAlliance
        case 2:
            aff = .jabbaCriminalEmpire
        case 3:
            aff = .firstOrder
        default:
            aff = .unknown
        }
        
        return aff
    }
    
}

//MARL: - UniverseTableViewControllerDelegate
protocol UniverseTableViewControllerDelegate: class {
    // metodos should - piden permiso
    
    // metodos will - lo voy hacer
    
    // metodos did - ya lo he hecho
    
    func universeTableViewControllerDelegate(_ uVC: UniverseTableViewController, didSelectedCharacter char: StarWarsCharacters)
    
}

//MARK: - Notifications
extension UniverseTableViewController {
    
    func notify(characterChanged char: StarWarsCharacters) {
        // obtener instancia notification center
        let nc = NotificationCenter.default
        
        // crear objeto notification
        let notification = Notification(name: UniverseTableViewController.notificationName, object: self, userInfo: [UniverseTableViewController.characterKey : char])
        
        // enviar
        nc.post(notification)
    }
}
