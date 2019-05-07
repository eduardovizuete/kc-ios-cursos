//
//  AppDelegate.swift
//  StartWars
//
//  Created by eduardo on 5/1/19.
//  Copyright © 2019 eduardo. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // crear una window
        window = UIWindow(frame: UIScreen.main.bounds)
        
        // crear instancia del modelo
        do {
            var json = try loadFromLocalFile(filename: "regularCharacters.json")
            let force = try loadFromLocalFile(filename: "forceSensitives.json")
            json.append(contentsOf: force)
            
            // crear un array de clases de swift
            var chars = [StarWarsCharacters]()
            for dict in json {
                do {
                    let char = try decode(starWarsCharacter: dict)
                    chars.append(char)
                } catch {
                    print("Error al procesar \(dict)")
                }
            }
            
            // podemos crear el modelo
            let model = StarWarsUniverse(characters: chars)
            
            // creamos el UniverseVC
            let uVC = UniverseTableViewController(model: model)
            
            // colocamos un NAV
            let uNav = UINavigationController(rootViewController: uVC)
            
            //creamos un charVC
            let charVC = CharacterViewController(model: model.character(atIndex: 0, forAffiliation: .galacticEmpire))
            
            // colocamos en un NAV
            let cNav = UINavigationController.init(rootViewController: charVC)
            
            // creamos el splitVC
            let splitVC = UISplitViewController()
            splitVC.viewControllers = [uNav, cNav]
            
            // colocamos en window
            window?.rootViewController = splitVC
            
            // mostramos la window
            window?.makeKeyAndVisible()
            
            return true
            
        } catch {
            fatalError("Error while loading model from JSON")
        }
        
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

