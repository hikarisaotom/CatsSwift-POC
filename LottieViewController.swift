//
//  LottieViewController.swift
//  
//
//  Created by Claudia Cortes on 6/21/22.
//

import UIKit
import Lottie
class LottieViewController: UIViewController {
    
    
    @IBOutlet weak var lottieView: AnimationView!


    @IBOutlet weak var lblDescription: UILabel!
    
    var descriptiontext:String!
    var lottieName:String!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        lottieView.animation = Animation.named(lottieName)
        // 1. Set animation content mode
        lottieView.contentMode = .scaleAspectFit
        // 2. Set animation loop mode
        lottieView.loopMode = .loop
        // 3. Adjust animation speed
        lottieView.animationSpeed = 0.5
        // 4. Play animation
        lottieView.play()
        lblDescription?.text=descriptiontext
    }
    
    
}
