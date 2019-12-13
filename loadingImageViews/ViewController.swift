//
//  ViewController.swift
//  loadingImageViews
//
//  Created by Marlhex on 2019-10-09.
//  Copyright © 2019 Marlhex. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let shinnyLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Shimmer"
        lbl.font = UIFont.systemFont(ofSize: 80, weight: .regular)
        lbl.textColor = UIColor(white: 1, alpha: 0.9)
        lbl.textAlignment = .center
        return lbl
    }()

    let baseLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Shimmer"
        lbl.font = UIFont.systemFont(ofSize: 80, weight: .regular)
        lbl.textColor = UIColor(white: 1, alpha: 0.5)
        lbl.textAlignment = .center
        return lbl
    }()
    
    let shinnyImageFrame: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .white
        return iv
    }()
    
    let baseImageFrame: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .lightGray
        return iv
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override var prefersStatusBarHidden: Bool { return true }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpEffect()
    }
    

    fileprivate func setUpEffect() {
        view.backgroundColor = UIColor(white: 1, alpha: 0.1)

        
        //image views
        view.addSubview(baseImageFrame)
        view.addSubview(shinnyImageFrame)
        
//        baseImageFrame.frame = CGRect(x: 40, y: 350, width: 400, height: 200)
//        shinnyImageFrame.frame = CGRect(x: 40, y: 350, width: 420, height: 200)
        
        baseImageFrame.frame = CGRect(x: 40, y: 300, width: 200, height: 200)
        baseImageFrame.layer.cornerRadius = 100
        baseImageFrame.clipsToBounds = true
        
        shinnyImageFrame.frame = CGRect(x: 40, y: 300, width: 200, height: 200)
        shinnyImageFrame.layer.cornerRadius = 100
        shinnyImageFrame.clipsToBounds = true

        //Gradient
        let frameGradient = CAGradientLayer()
        frameGradient.frame = baseImageFrame.bounds
        
        frameGradient.colors = [UIColor.clear.cgColor, UIColor.clear.cgColor, UIColor.clear.cgColor, UIColor.clear.cgColor, UIColor.clear.cgColor, UIColor.clear.cgColor, UIColor.clear.cgColor, UIColor.clear.cgColor, UIColor.clear.cgColor, UIColor.black.withAlphaComponent(0.1).cgColor]
        
        frameGradient.locations = [0, 0.1, 0.2, 0.3, 0.49, 0.5, 0.51, 0.7, 0.8, 0.99, 1]
        
        let angleFrame = -90 * CGFloat.pi / 180
               let rotationTransformFrame = CATransform3DMakeRotation(angleFrame, 0, 0, 1)
               frameGradient.transform = rotationTransformFrame
        
        
        shinnyImageFrame.layer.mask = frameGradient

               let animationF = CABasicAnimation(keyPath: "transform.translation.x")
               animationF.duration = 1
//        animationF.speed = 1.5
               animationF.repeatCount = Float.infinity
               animationF.autoreverses = false
               animationF.fromValue = -baseImageFrame.frame.width
               animationF.toValue = baseImageFrame.frame.width
        
               animationF.isRemovedOnCompletion = false
               animationF.fillMode = CAMediaTimingFillMode.forwards

               frameGradient.add(animationF, forKey: "shimmerKeyFrame")
        
        
        
        // Labels
        view.addSubview(baseLbl)
        view.addSubview(shinnyLbl)
        baseLbl.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 400)
        shinnyLbl.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 400)

        let gradient = CAGradientLayer()

        gradient.frame = baseLbl.bounds

        gradient.colors = [UIColor.clear.cgColor, UIColor.clear.cgColor, UIColor.black.cgColor, UIColor.black.cgColor, UIColor.clear.cgColor, UIColor.clear.cgColor]
        gradient.locations = [0.0, 0.2, 0.4, 0.6, 0.8, 1.0]
        let angle = -60 * CGFloat.pi / 180
        let rotationTransform = CATransform3DMakeRotation(angle, 0, 0, 1)
        gradient.transform = rotationTransform

        shinnyLbl.layer.mask = gradient

        let animation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.duration = 2
        animation.repeatCount = Float.infinity
        animation.autoreverses = false
        animation.fromValue = -view.frame.width
        animation.toValue = view.frame.width
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards

        gradient.add(animation, forKey: "shimmerKey")
    }
    
}

