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
                self.loadingSpinner.stopAnimating()
            }
        }
    }
    
    
    @IBOutlet weak var BreedsCollectionView: UICollectionView!
    
    @IBOutlet weak var loadingSpinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Breeds"
        fetchBreeds()
        BreedsCollectionView.dataSource = self
    }
    private func fetchBreeds(){
        print("fetching.....")
        loadingSpinner.startAnimating()
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
        cell.loadingSpinner.startAnimating()
        if let urlString=selectedBreed.image?.url, let imageUrl=URL(string: urlString ){
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                let urlContents=try?  Data(contentsOf: imageUrl)
                DispatchQueue.main.async {
                    if let imageData=urlContents{
                        cell.breedImage.image=UIImage(data:imageData)
                        cell.loadingSpinner.stopAnimating()
//                        print("loading image")
                    }
                }
            }
            
        }
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? BreedDetailsViewController, let index = BreedsCollectionView.indexPathsForSelectedItems?.first{
            dest.breed=catBreeds[index.row]
        }
            
    }
}//end of class

