//
//  BreedCollectionViewCell.swift
//  catsPOCSwft
//
//  Created by Claudia Cortes on 6/16/22.
//

import UIKit

class BreedCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var breedName: UILabel!
    @IBOutlet weak var breedImage: UIImageView!
    var  breed:Breed?=nil
}
