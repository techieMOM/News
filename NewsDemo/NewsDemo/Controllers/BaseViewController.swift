//
//  BaseViewController.swift
//  NewsDemo
//
//  Created by SOWJI on 23/11/20.
//

import UIKit
// The purpose is to share common functionalities in super class
class BaseViewController: UIViewController {
    var currentOverlay : UIView?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    // Simple overlay to show while we are fetching API Data
    func showOverlay() {
        // Here i'm just adding an transparent overlay and an activity indicator on top of it
        self.hideOverLay()
        let overlay = UIView(frame: self.view.frame)
        overlay.center = self.view.center
        overlay.alpha = 0.6
        overlay.backgroundColor = .black
        self.view.addSubview(overlay)
        self.view.bringSubviewToFront(overlay)
        self.currentOverlay = overlay
        let loadingIndicator = UIActivityIndicatorView()
        loadingIndicator.center = overlay.center
        loadingIndicator.style = .large
        loadingIndicator.startAnimating()
        self.currentOverlay?.addSubview(loadingIndicator)
    }
    func hideOverLay() {
        if currentOverlay != nil {
            currentOverlay?.removeFromSuperview()
            currentOverlay =  nil
        }
        
    }

}
