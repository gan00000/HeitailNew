//
//  UIViewExtension.swift
//  tripbay_ios
//
//  Created by Rock on 2019/8/1.
//  Copyright © 2019 TripBay. All rights reserved.
//

import UIKit

struct BorderSideType: OptionSet {
    let rawValue: UInt
    
    static let top = BorderSideType(rawValue: 1 << 0)
    static let left = BorderSideType(rawValue: 1 << 1)
    static let bottom = BorderSideType(rawValue: 1 << 2)
    static let right = BorderSideType(rawValue: 1 << 3)
    
    static let all: BorderSideType = [.top, .left, .bottom, .right]
}

extension UIView {
    
    func border(_ width: CGFloat, radius: CGFloat, color: UIColor) {
        layer.borderWidth = width
        layer.cornerRadius = radius
        layer.borderColor = color.cgColor
    }
    
    func shadow() {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        layer.shadowRadius = CGFloat(1.0)
        layer.shadowOpacity = 0.12
    }
    
    func gradient(_ colors: [CGColor], frame: CGRect) {
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = frame
        gradientLayer.colors = colors
        self.layer.addSublayer(gradientLayer)
    }
    
    /// rect 就是 view.bounds，由于使用xib导致rect暂时不对，可以手动传入
    func cornerRadius(with rectCorner: UIRectCorner, rect: CGRect? = nil, value: CGFloat) {
        var bounds = self.bounds
        if let rect = rect {
            bounds = rect
        }
        let bezierPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: rectCorner, cornerRadii: CGSize(width: value, height: value))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = bezierPath.cgPath
        layer.mask = maskLayer
    }
    
    /// rect 就是 view.bounds，由于使用xib导致rect暂时不对，可以手动传入
//    func border(with sideType: BorderSideType, rect: CGRect? = nil, color: UIColor, borderWidth: CGFloat) {
//        if sideType.contains(.all) {
//            layer.borderWidth = borderWidth
//            layer.borderColor = borderColor?.cgColor
//            return
//        }
//        var bounds = self.bounds
//        if let rect = rect {
//            bounds = rect
//        }
//        if sideType.contains(.top) {
//            layer.addSublayer(layer(from: CGPoint(x: 0.0, y: 0.0), toPoint: CGPoint(x: bounds.width, y: 0.0), color: color, borderWidth: borderWidth))
//        }
//        if sideType.contains(.left) {
//            layer.addSublayer(layer(from: CGPoint(x: 0.0, y: 0.0), toPoint: CGPoint(x: 0.0, y: bounds.height), color: color, borderWidth: borderWidth))
//        }
//        if sideType.contains(.bottom) {
//            layer.addSublayer(layer(from: CGPoint(x: 0.0, y: bounds.height), toPoint: CGPoint(x: bounds.width, y: bounds.height), color: color, borderWidth: borderWidth))
//        }
//        if sideType.contains(.right) {
//            layer.addSublayer(layer(from: CGPoint(x: bounds.width, y: 0.0), toPoint: CGPoint(x: bounds.width, y: bounds.height), color: color, borderWidth: borderWidth))
//        }
//    }
    
    private func layer(from originPoint: CGPoint, toPoint: CGPoint, color: UIColor, borderWidth: CGFloat) -> CAShapeLayer {
        let bezierPath = UIBezierPath()
        bezierPath.move(to: originPoint)
        bezierPath.addLine(to: toPoint)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.path = bezierPath.cgPath
        shapeLayer.lineWidth = borderWidth
        
        return shapeLayer
    }
    
    class func loadNib() -> UINib {
        let name = String(describing: self)
        return UINib(nibName: name, bundle: Bundle.main)
    }
    
    public class func fromNib(nibName: String?) -> Self {
        func fromNibHelper<T>(nibName: String?) -> T where T : UIView {
            let bundle = Bundle(for: T.self)
            let name = nibName ?? String(describing: T.self)
            return bundle.loadNibNamed(name, owner: nil, options: nil)?.first as? T ?? T()
        }
        
        return fromNibHelper(nibName: nibName)
    }
    
    /// attaches all sides of the receiver to its parent view
    
    func layoutAttachAll(margin: UIEdgeInsets = .zero) {
        let view = superview
        layoutAttachTop(to: view, margin: margin.top);
        layoutAttachLeading(to: view, margin: margin.left);
        layoutAttachBottom(to: view, margin: margin.bottom);
        layoutAttachTrailing(to: view, margin: margin.right);
    }
    
    /// attaches the top of the current view to the given view's top if it's a superview of the current view, or to it's bottom if it's not (assuming this is then a sibling view).
    /// if view is not provided, the current view's super view is used
    @discardableResult
    func layoutAttachTop(to: UIView? = nil, margin: CGFloat = 0.0) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let view: UIView? = to ?? superview
        let isSuperview = view == superview
        let constraint = NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: view, attribute: isSuperview ? .top : .bottom, multiplier: 1.0, constant: margin)
        superview?.addConstraint(constraint)
        
        return constraint
    }
    
    /// attaches the leading edge of the current view to the given view
    @discardableResult
    func layoutAttachLeading(to: UIView? = nil, margin: CGFloat = 0.0) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let view: UIView? = to ?? superview
        let isSuperview = (view == superview) || false
        let constraint = NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: view, attribute: isSuperview ? .leading : .trailing, multiplier: 1.0, constant: margin)
        superview?.addConstraint(constraint)
        
        return constraint
    }
    
    /// attaches the bottom of the current view to the given view
    @discardableResult
    func layoutAttachBottom(to: UIView? = nil, margin: CGFloat = 0.0, priority: UILayoutPriority? = nil) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let view: UIView? = to ?? superview
        let isSuperview = (view == superview) || false
        let constraint = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: isSuperview ? .bottom : .top, multiplier: 1.0, constant: -margin)
        if let priority = priority {
            constraint.priority = priority
        }
        superview?.addConstraint(constraint)
        
        return constraint
    }
    
    /// attaches the trailing edge of the current view to the given view
    @discardableResult
    func layoutAttachTrailing(to: UIView? = nil, margin: CGFloat = 0.0, priority: UILayoutPriority? = nil) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let view: UIView? = to ?? superview
        let isSuperview = (view == superview) || false
        let constraint = NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: isSuperview ? .trailing : .leading, multiplier: 1.0, constant: -margin)
        if let priority = priority {
            constraint.priority = priority
        }
        superview?.addConstraint(constraint)
        
        return constraint
    }
    
    
    func setupNib() {
        guard let contentView = loadNibView() else { return }
        addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.layoutAttachAll()
//        NSLayoutConstraint.activate([
//            nib.leadingAnchor.constraint(equalTo: self.leadingAnchor),
//            nib.trailingAnchor.constraint(equalTo: self.trailingAnchor),
//            nib.topAnchor.constraint(equalTo: self.topAnchor),
//            nib.bottomAnchor.constraint(equalTo: self.bottomAnchor)
//        ])
    }
    
    func loadNibView() -> UIView? {
        let bundle = Bundle(for: Self.self)
        return bundle.loadNibNamed(String(describing: Self.self), owner: self, options: nil)?.first as? UIView
    }
    
}

