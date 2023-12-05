//
//  Extension.swift
//  News-Reader-Swift
//
//  Created by Dhanraj Kawade on 05/12/23.
//

import UIKit

protocol ReusableView: AnyObject {
    static var identifier: String { get }
}

extension ReusableView where Self: UIView {
    static var identifier: String {
        return String(describing: self)
    }
}

protocol NibLoadableView: AnyObject {
    static var nibName: String { get }
}

extension NibLoadableView where Self: UIView {
    static var nibName: String {
        return String(describing: self)
    }
}

extension UICollectionView {
    
    func register<T: UICollectionViewCell>(_: T.Type) where T: ReusableView {
        register(T.self, forCellWithReuseIdentifier: T.identifier)
    }
    
    func register<T: UICollectionViewCell>(_: T.Type) where T: ReusableView, T: NibLoadableView {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.nibName, bundle: bundle)
        register(nib, forCellWithReuseIdentifier: T.identifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T where T: ReusableView {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.identifier)")
        }
        return cell
    }
    
    func refreshData() {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
}

extension UIView {
    
    private static let lineDashPattern: [NSNumber] = [2, 2]
    private static let lineDashWidth: CGFloat = 2.0
    
    @IBInspectable var cornerRadius: CGFloat {
        get {  return layer.cornerRadius }
        set { layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {  return layer.borderWidth }
        set {  layer.borderWidth = newValue }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get { return UIColor(cgColor: layer.borderColor!) }
        set {  layer.borderColor = newValue?.cgColor }
    }
    
    func addCornerRadius(radius:CGFloat) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
    
    func addShadow(offset: CGSize, color: UIColor, radius: CGFloat, opacity: Float) {
        layer.masksToBounds = false
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        
        let backgroundCGColor = backgroundColor?.cgColor
        backgroundColor = nil
        layer.backgroundColor =  backgroundCGColor
    }
}

extension UIStoryboard {
    static let main = UIStoryboard(name: "Main", bundle: nil)
}
