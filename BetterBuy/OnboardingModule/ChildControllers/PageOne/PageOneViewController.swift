//
//  PageOneViewController.swift
//  BetterBuy
//
//  Created by user222682 on 5/26/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import UIKit
import Lottie

class PageOneViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var animationView: UIView!
    
    // MARK: - Variables
    private var lottieAnimationView: AnimationView?

    // MARK: - Life Cycle
    override func viewDidLoad() {
      super.viewDidLoad()
        playAnumation()
    }
    
    // MARK: - Functions
    func playAnumation(){
        lottieAnimationView = .init(name: "order-delivery")
        lottieAnimationView!.frame = animationView.bounds
        lottieAnimationView!.contentMode = .scaleAspectFit
        lottieAnimationView!.loopMode = .loop
        lottieAnimationView!.animationSpeed = 1.0
        animationView.addSubview(lottieAnimationView!)
        lottieAnimationView!.play()
    }

}
