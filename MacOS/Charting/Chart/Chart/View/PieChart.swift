//
//  PieChart.swift
//  PieChartKit
//
//  Created by Ankit Kumar Bharti on 02/08/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Cocoa


@IBDesignable
@objc class PieChartView : NSView {
    
    // MARK: Properties
    @IBInspectable var lineWidth: CGFloat = 50.0
    @IBInspectable var innerLineWidth: CGFloat = 10.0
    @IBInspectable var shouldAnimate = true
    @IBInspectable var alphaForInnerSection: CGFloat = 0.55
    
    @IBOutlet weak var dataSource: PieChartViewDataSource?
    @IBOutlet weak var delegate: PieChartViewDelegate?
    
    private var sectionLayers: [CAShapeLayer] = []
    
    private var section: Int {
        return dataSource?.numberOfSection(self) ?? 0
    }
    
    // MARK: - View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        layer?.backgroundColor = .clear
    }
    
    override func draw(_ dirtyRect: CGRect) {
        super.draw(dirtyRect)
        self.wantsLayer = true
        guard let chartDataSource = dataSource else { return }
        let distributionPercentages = percentageDistribution
        var startAngle: CGFloat = 0.0
        var endAngle: CGFloat = 0.0
        sectionLayers.removeAll()
        for index in 0..<section {
            startAngle += index == 0 ? 0.0 : angleSharing(percent: distributionPercentages[index - 1])
            endAngle += angleSharing(percent: distributionPercentages[index])
            
            let innerColor = chartDataSource.color(self, at: index)?.withAlphaComponent(alphaForInnerSection).cgColor
            let externalColor = chartDataSource.color(self, at: index)?.cgColor
            
            
            // External Circle
            let externalPath = CGMutablePath()
            externalPath.addRelativeArc(center: dirtyRect.center, radius: dirtyRect.size.height / 3.0, startAngle: startAngle.degreesToRadians, delta: endAngle.degreesToRadians - startAngle.degreesToRadians)
            let sectionLayer = shapeLayer(at: index, color: externalColor)
            sectionLayer.path = externalPath
            sectionLayers.append(sectionLayer)
            
            // Internal Circle
            let innerPath = CGMutablePath()
            innerPath.addRelativeArc(center: dirtyRect.center, radius: (dirtyRect.size.height / 3.0) - (lineWidth / 2.0), startAngle: startAngle.degreesToRadians, delta: endAngle.degreesToRadians - startAngle.degreesToRadians)
            let innerSectionLayer = shapeLayer(at: index, color: innerColor, isInnerCircle: true)
            innerSectionLayer.path = innerPath
            //sectionLayers.append(sectionLayer)
            sectionLayer.addSublayer(innerSectionLayer)
            
            self.layer?.addSublayer(sectionLayer)
            
        }
        // animate the section
        animate()
        presentSectionTiles()
    }

    // MARK: - Present the section tiles
    func presentSectionTiles() {
        
        var sectionTileViewlist: [SectionTileView] = []
        
        for index in 0..<section {
            let sectionTileView = SectionTileView(title: title(at: index), color: color(at: index))
            sectionTileViewlist.append(sectionTileView)
        }
        
        let stackView = NSStackView(views: sectionTileViewlist)
        stackView.alignment = .centerY
        stackView.orientation = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 4.0
        self.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let bottomConstraint = stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 12.0)
        let heightConstraint = stackView.heightAnchor.constraint(equalToConstant: 32.0)
        let leadingConstraint = stackView.leadingAnchor.constraint(equalTo: leadingAnchor)
        let trailingConstraint = stackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        
        NSLayoutConstraint.activate([bottomConstraint, heightConstraint, leadingConstraint, trailingConstraint])
    }
    
    // MARK: - generate Shape layer
    
    /// create shapeLayer
    ///
    /// - Parameters:
    ///   - at: index of the section of pie chart
    ///   - color: color for the section
    /// - Returns: return instance of CAShapeLayer
    private func shapeLayer(at: Int, color: CGColor?, isInnerCircle: Bool = false) -> CAShapeLayer {
        let sectionLayer = CAShapeLayer()
        sectionLayer.fillColor = NSColor.clear.cgColor
        sectionLayer.lineWidth = isInnerCircle ? innerLineWidth : lineWidth
        sectionLayer.strokeColor = color
        sectionLayer.strokeStart = 0
        sectionLayer.strokeEnd = isInnerCircle ? 1 : (shouldAnimate ? 0 : 1)
        return sectionLayer
    }
    
    // MARK: - distribution percentage for the specific section
    
    /// discrtibuted points
    private var distributedPoints: [CGFloat] {
        guard let chartDataSource = dataSource else {
            return []
        }
        var totalValues: CGFloat = 0
        for index in 0..<section {
            totalValues += CGFloat(chartDataSource.data(pieChartView: self, at: index))
        }
        var sharedPoints: [CGFloat] = []
        
        for index in 0..<section {
            let value = CGFloat(chartDataSource.data(pieChartView: self, at: index))
            let point: CGFloat = 360 * value / totalValues
            sharedPoints.append(point)
        }
        return sharedPoints
    }
    
    /// percentage distribution calculation
    private var percentageDistribution : [CGFloat] {
        var distributionPercentageList: [CGFloat] = []
        for point in distributedPoints {
            let percentage = point * 100 / 360.0
            distributionPercentageList.append(percentage)
        }
        return distributionPercentageList
    }
    
    /// angle sharing calculation
    ///
    /// - Parameter percent: pass the percentage of sharing for each section
    /// - Returns: return the calculated angle from percentage
    private func angleSharing(percent: CGFloat) -> CGFloat {
        return 360 * percent / 100.0
    }
}

// MARK: PieChart Extension for animation

extension PieChartView {
    
    private func animate() {
        if shouldAnimate {
            for (index, sectionLayer) in sectionLayers.enumerated() {
                sectionLayer.add(strokeAnimation, forKey: "shapeLayer \(index)")
            }
        }
    }
    
    private var strokeAnimation: CABasicAnimation {
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 0.35
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        return animation
    }
}


// MARK: - PieChartView Extension for Touch

extension PieChartView {
    
    override func touchesBegan(with event: NSEvent) {
        guard let location = event.allTouches().first?.location(in: self),
            let subLayers = layer?.sublayers else { return }
        
        for (index, subLayer) in subLayers.enumerated() {
            if subLayer is CAShapeLayer {
                if let shapeLayer = subLayer as? CAShapeLayer, let path = shapeLayer.path {
                    let boxRect = path.boundingBox
                    if boxRect.contains(location) {
                        delegate?.didSelect?(section: index, self)
                    }
                }
            }
        }
    }
}

// MARK: - Methods to get title, color, attributes & attributed string

extension PieChartView {
    
    private func title(at index: Int) -> String {
        return delegate?.sectionTitle?(self, for: index) ?? ""
    }
    
    private func color(at index: Int) -> NSColor? {
        return dataSource?.color(self, at: index)
    }
    
    private func titleSize(at index: Int) -> CGSize {
         return (title(at: index) as NSString).size(withAttributes: attributes())
    }
    
    private func attributes(color: NSColor? = .black) -> [NSAttributedStringKey : Any] {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        return [.font: NSFont.systemFont(ofSize: 10.0), .foregroundColor: color ?? NSColor.black, .paragraphStyle: paragraphStyle]
    }
    
    private func attributedString(from text: String, color: NSColor? = .black) -> NSAttributedString {
        let attributedText = NSAttributedString(string: text, attributes: attributes(color: color))
        return attributedText
    }
}

