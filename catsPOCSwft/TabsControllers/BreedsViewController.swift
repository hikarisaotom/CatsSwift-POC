//
//  BreedsViewController.swift
//  catsPOCSwft
//
//  Created by Claudia Cortes on 6/15/22.
//

import UIKit
import Alamofire

class BreedsViewController: UIViewController,UICollectionViewDataSource{
    
    private var catBreeds=Breeds(){
        didSet{
            //TODO: reload the collectionview
            print("breeds loaded")
            DispatchQueue.main.async {
                self.BreedsCollectionView.reloadData()
            }
        }
    }
    
    
    @IBOutlet weak var BreedsCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchBreeds()
        BreedsCollectionView.dataSource = self
    }
    private func fetchBreeds(){
        print("fetching.....")
        AF.request("https://api.thecatapi.com/v1/breeds",headers: API.headers).responseDecodable(of: Breeds.self) { response in
            if let breeds = response.value{
                self.catBreeds = breeds
            }else{
                print("Error in request")
            }
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return catBreeds.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = BreedsCollectionView.dequeueReusableCell(withReuseIdentifier: "customCell", for: indexPath) as! BreedCollectionViewCell
        let selectedBreed=catBreeds[indexPath.row]
        
        cell.breedName.text = selectedBreed.name.capitalized
        cell.breed=selectedBreed
        if let urlString=selectedBreed.image?.url, let imageUrl=URL(string: urlString ){
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                let urlContents=try?  Data(contentsOf: imageUrl)
                DispatchQueue.main.async {
                    if let imageData=urlContents{
                        cell.breedImage.image=UIImage(data:imageData)
//                        print("loading image")
                    }
                }
            }
            
        }
        return cell
    }
}//end of class

