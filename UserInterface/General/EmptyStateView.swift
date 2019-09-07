//
//  EmptyStateView.swift
//  UserInterface
//
//  Created by Fernando Moya de Rivas on 29/08/2019.
//  Copyright © 2019 Fernando Moya de Rivas. All rights reserved.
//

import UIKit

class EmptyStateView: UIView {

    private let textLayer = CATextLayer()
    
    var textColor: UIColor = .red {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var textFontSize: CGFloat = 22 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    private var font: UIFont { return UIFont.systemFont(ofSize: textFontSize, weight: .bold) }
    
    var text: String = "" {
        didSet {
            setNeedsDisplay()
            setNeedsLayout()
        }
    }
    
    var didTap: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }
    
    @objc private func userDidTapView() {
        didTap?()
    }
    
    private func initialize() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(userDidTapView))
        tapGestureRecognizer.numberOfTapsRequired = 1
        addGestureRecognizer(tapGestureRecognizer)
        
        textLayer.font = CTFontCreateWithName(font.fontName as CFString, textFontSize, nil)
        textLayer.isWrapped = true
        layer.addSublayer(textLayer)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        textLayer.foregroundColor = textColor.cgColor
        textLayer.fontSize = textFontSize
        textLayer.string = text
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let rect = (text as NSString).boundingRect(with: CGSize(width: UIScreen.main.bounds.width,
                                                                height: CGFloat.greatestFiniteMagnitude),
                                                   options: [.usesLineFragmentOrigin, .usesFontLeading],
                                                   attributes: [NSAttributedString.Key.font: font],
                                                   context: nil)

        let position = CGPoint(x: bounds.midX, y: bounds.midY)
        
        textLayer.bounds = CGRect(origin: .zero, size: rect.size)
        textLayer.position = position
    }

}
