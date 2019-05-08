//
//  WikiViewController.swift
//  StartWars
//
//  Created by eduardo on 5/7/19.
//  Copyright © 2019 eduardo. All rights reserved.
//

import UIKit

class WikiViewController: UIViewController {

    //MARK: - properties
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBOutlet weak var browser: UIWebView!
    
    var model: StarWarsCharacters
    
    //MARK: - initialization
    init(model: StarWarsCharacters) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - sync view -> model
    func syncViewWithModel() {
        // creamos un urlrequest
        let req = URLRequest(url: model.url)
        browser.loadRequest(req)
    }
    
    //MARK: - view lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        syncViewWithModel()
        browser.delegate = self
        
        // alta notificaciones
        subscribe()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // baja notificaciones
        unsubscribe()
    }
    
}

//MARK: - UIWebViewDelegate
extension WikiViewController: UIWebViewDelegate {
    func webViewDidStartLoad(_ webView: UIWebView) {
        // mostrar el spinner
        spinner.isHidden = false
        spinner.startAnimating()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        spinner.isHidden = true
        spinner.stopAnimating()
    }
}

//MARK: - Notification
extension WikiViewController {
    func subscribe() {
        // reference notification center
        let nc = NotificationCenter.default
        
        nc.addObserver(forName: UniverseTableViewController.notificationName, object: nil, queue: OperationQueue.main)
            {(not: Notification) in
            // get notification data
            let userInfo = not.userInfo
            let char = userInfo?[UniverseTableViewController.characterKey]
            
            // update model
            self.model = char as! StarWarsCharacters
            
            // update ui
            self.syncViewWithModel()
        }
    }
    
    func unsubscribe() {
        // reference notification center
        let nc = NotificationCenter.default
        nc.removeObserver(self)
    }
}
