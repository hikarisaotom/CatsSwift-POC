//
//  BreedDetailsViewController.swift
//  catsPOCSwft
//
//  Created by Claudia Cortes on 6/17/22.
//

import UIKit

class BreedDetailsViewController: UIViewController {
    var breed:Breed!
    @IBOutlet weak var name: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        name.text=breed.name
        
    }


}
