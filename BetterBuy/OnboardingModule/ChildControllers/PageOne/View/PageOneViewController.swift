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
    private var viewModel : PageOneViewModelType?
    // MARK: - Life Cycle
    convenience init() {
        self.init(viewModel: nil)
    }

    init(viewModel: PageOneViewModelType?) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: PageOneViewController.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

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
    // MARK: - IBAction
    @IBAction func skip(_ sender: UIButton) {
        viewModel?.goToHomeScreen()
    }
    
}
