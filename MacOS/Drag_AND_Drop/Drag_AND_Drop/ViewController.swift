//
//  ViewController.swift
//  Drag_AND_Drop
//
//  Created by Ankit Kumar Bharti on 16/07/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    // MARK:- Properties
    @IBOutlet weak var destinationView: DestinationView!
    @objc dynamic var isImageAvailable = false

    
    // MARK:- Controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        destinationView.processImage = {[unowned self] in
            if let image = $0 {
                self.isImageAvailable = true
                self.destinationView.subviews.removeAll()
                let imageView = NSImageView(image: image)
                self.destinationView.addSubview(imageView)
                self.setup(imageView)
            }
        }
    }
    
    // MARK:- Setup the constraint to imageview
    private func setup(_ imageView: NSImageView) {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let centerXConstraint = NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: destinationView, attribute: .centerX, multiplier: 1.0, constant: 0)
        let centerYConstraint = NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: destinationView, attribute: .centerY, multiplier: 1.0, constant: 0)
        let widthConstraint = NSLayoutConstraint(item: imageView, attribute: .width, relatedBy: .equal, toItem: destinationView, attribute: .width, multiplier: 0.7, constant: 0)
        let heightConstraint = NSLayoutConstraint(item: imageView, attribute: .height, relatedBy: .equal, toItem: destinationView, attribute: .height, multiplier: 0.7, constant: 0)
        
        NSLayoutConstraint.activate([centerXConstraint,centerYConstraint,widthConstraint,heightConstraint])
    }
}
