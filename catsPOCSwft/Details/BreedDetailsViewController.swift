//
//  BreedDetailsViewController.swift
//  catsPOCSwft
//
//  Created by Claudia Cortes on 6/17/22.
//

import UIKit

class BreedDetailsViewController: UIViewController {
    var breed:Breed!
    
    @IBOutlet weak var loadingSpinner: UIActivityIndicatorView!
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var lblAlternativeName: UILabel!
    
    @IBOutlet weak var lblDescription: UILabel!
    
    @IBOutlet weak var lblLifeSpan: UILabel!
    
    @IBOutlet weak var imgBreed: UIImageView!
    @IBOutlet weak var lblOrigin: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingSpinner.startAnimating()
        lblName.text=breed.name
        lblAlternativeName.text=(breed.altNames != nil) ? breed.altNames : ""
        lblDescription.text=(breed.description != nil) ? breed.description : "N/A"
        lblLifeSpan.text=(breed.lifeSpan != nil) ? breed.lifeSpan : "N/A"
        lblOrigin.text=(breed.origin != nil) ? breed.origin : "N/A"
        
        if let urlString=breed.image?.url, let imageUrl=URL(string: urlString ){
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                let urlContents=try?  Data(contentsOf: imageUrl)
                DispatchQueue.main.async {
                    if let imageData=urlContents{
                        self?.imgBreed.image=UIImage(data:imageData)
                        self?.loadingSpinner.stopAnimating()
//                        print("loading image")
                    }
                }
            }
            
        }
        
    }


}
