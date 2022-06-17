//
//  CategoriesCollectionViewCell.swift
//  catsPOCSwft
//
//  Created by Claudia Cortes on 6/16/22.
//

import UIKit

class CategoriesCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var categoryImage: UIImageView!
    var category:Category?=nil
    @IBOutlet weak var categoryTitle: UILabel!

}
