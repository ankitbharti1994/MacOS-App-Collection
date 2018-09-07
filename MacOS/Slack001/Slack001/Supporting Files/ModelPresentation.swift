//
//  ModelPresentation.swift
//  Slack001
//
//  Created by Ankit Kumar Bharti on 07/09/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Cocoa

protocol ModelPresentation: AnyObject {
    func present(_ type: ModelType, relativeTo relativeView: NSView?)
}

extension ModelPresentation where Self: NSViewController {
    
    func present(_ type: ModelType, relativeTo relativeView: NSView?) {
        
        let backgroundDimView = PresentationBackgroundView()
        var modalView: NSView!
        view.addSubview(backgroundDimView, positioned: .above, relativeTo: relativeView)
        
        backgroundDimView.translatesAutoresizingMaskIntoConstraints = false
        
        let topConstraint = backgroundDimView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0.0)
        let bottomConstraint = backgroundDimView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        let leadingConstraint = backgroundDimView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let trailingConstraint = backgroundDimView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        
        NSLayoutConstraint.activate([topConstraint, bottomConstraint, leadingConstraint, trailingConstraint])
        
        // Modal View
        
        modalView = LoginModelView()
        view.addSubview(modalView, positioned: .above, relativeTo: backgroundDimView)
        modalView.translatesAutoresizingMaskIntoConstraints = false
        
        let centerXConstraint = modalView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let centerYConstraint = modalView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        let widthConstraint = modalView.widthAnchor.constraint(equalToConstant: 475.0)
        let heightConstraint = modalView.heightAnchor.constraint(equalToConstant: 300.0)
        
        NSLayoutConstraint.activate([centerXConstraint, centerYConstraint, widthConstraint, heightConstraint])
        
        backgroundDimView.didMouseClicked = {
            closeView()
        }
        
        (modalView as! LoginModelView).didClose = {
            closeView()
        }
        
        NSAnimationContext.runAnimationGroup({ (context) in
            context.duration = 0.5
            backgroundDimView.animator().alphaValue = 0.6
            modalView.animator().alphaValue = 1.0
            self.view.layoutSubtreeIfNeeded()
        }, completionHandler: nil)
        
        
        func closeView() {
            NSAnimationContext.runAnimationGroup({ (context) in
                context.duration = 0.5
                backgroundDimView.animator().alphaValue = 0.0
                modalView.animator().alphaValue = 0.0
                self.view.layoutSubtreeIfNeeded()
            }, completionHandler: {
                backgroundDimView.removeFromSuperview()
                modalView.removeFromSuperview()
            })
        }
    }
}
