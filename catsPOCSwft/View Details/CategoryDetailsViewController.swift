//
//  CategoryViewController.swift
//  catsPOCSwft
//
//  Created by Claudia Cortes on 6/17/22.
//

import UIKit

class CategoryDetailsViewController: UIViewController {

    @IBOutlet weak var lblTitleDescription: UILabel!
    
    
    @IBOutlet weak var categoryImagesCollectionView: UICollectionView!
    var category:Category!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lblTitleDescription.text=category.name
    }

}
