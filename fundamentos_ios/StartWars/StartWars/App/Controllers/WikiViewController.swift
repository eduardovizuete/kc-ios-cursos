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
    
    let model: StarWarsCharacters
    
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
