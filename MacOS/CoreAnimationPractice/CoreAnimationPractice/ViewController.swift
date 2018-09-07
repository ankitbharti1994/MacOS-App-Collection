//
//  ViewController.swift
//  CoreAnimationPractice
//
//  Created by Ankit Kumar Bharti on 20/07/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    private var textLayer: CATextLayer!
    private var text: String? {
        didSet {
            var size: CGSize = CGSize(width: 60, height: 24)
            size.width = ceil(size.width)
            size.height = ceil(size.height)
            textLayer.bounds = CGRect(origin: .zero, size: size)
            textLayer.superlayer?.bounds = CGRect(x: 0, y: 0, width: size.width + 16, height: size.height + 20)
            textLayer.string = text
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayer()
    }
    
    private func addImagesFromFolder(url: URL) {
        
    }
    
    private func thumbImage(from image: NSImage) -> NSImage {
        let targetHeight: CGFloat = 200.0
        let imageSize = image.size
        
        let smallerSize = CGSize(width: targetHeight * imageSize.width / imageSize.height, height: targetHeight)
        
        let thumbImage = NSImage(size: smallerSize, flipped: false) { rect -> Bool in
            image.draw(in: rect)
            return true
        }
        return thumbImage
    }
    
    private func setupLayer() {
        view.layer = CALayer()
        view.wantsLayer = true
        
        let textContainer = CALayer()
        textContainer.anchorPoint = .zero
        textContainer.position = CGPoint(x: 10.0, y: 10.0)
        textContainer.zPosition = 100
        textContainer.backgroundColor = NSColor.black.cgColor
        textContainer.borderColor = NSColor.white.cgColor
        textContainer.borderWidth = 1.0
        textContainer.cornerRadius = 20.0
        textContainer.shadowOpacity = 0.5
        view.layer?.addSublayer(textContainer)
        
        let textLayer = CATextLayer()
        textLayer.anchorPoint = .zero
        textLayer.position = CGPoint(x: 10.0, y: 6.0)
        textLayer.zPosition = 100
        textLayer.fontSize = 14.0
        textLayer.foregroundColor = NSColor.white.cgColor
        self.textLayer = textLayer
        
        textContainer.addSublayer(self.textLayer)
        
        text = "Loading..."
        let url = URL(fileURLWithPath: "Library/Desktop/Pictures")
        addImagesFromFolder(url: url)
    }
}

