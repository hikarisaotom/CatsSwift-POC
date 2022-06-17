//
//  CategoriesViewController.swift
//  catsPOCSwft
//
//  Created by Claudia Cortes on 6/15/22.
//

import UIKit
import Alamofire

class CategoriesViewController:  UIViewController,UICollectionViewDataSource{
    
    private var imagesCategories=Categories(){
        didSet{
            //TODO: reload the collectionview
            print("Categories loaded")
            DispatchQueue.main.async {
                self.CategoriesViewCollection.reloadData()
            }
        }
    }
    
    
    @IBOutlet weak var CategoriesViewCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FetchCategories()
        CategoriesViewCollection.dataSource = self
    }
    private func FetchCategories(){
        print("fetching.....")
        AF.request("https://api.thecatapi.com/v1/categories",headers: API.headers).responseDecodable(of: Categories.self) { response in
            if let categories = response.value{
                self.imagesCategories = categories
            }else{
                print("Error in request")
            }
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = CategoriesViewCollection.dequeueReusableCell(withReuseIdentifier: "customCategoryCell", for: indexPath) as! CategoriesCollectionViewCell
        let selectedCategory=imagesCategories[indexPath.row]
        let parameters = APIParameters(category_ids: selectedCategory.id)
       
        AF.request("https://api.thecatapi.com/v1/images/search",
                   parameters: parameters,
                   headers: API.headers
        ).responseJSON { [self] response in
            if let result = response.value {
                let images = result as! [NSDictionary]
                if !images.isEmpty{
                    let urlString = images[0].object(forKey: "url")! as! String
                    self.loadImage(urlString,cell)
                }
            }
        }
        cell.categoryTitle.text = selectedCategory.name.capitalized
        cell.category=selectedCategory
        return cell
    }
    
    private func loadImage(_ urlString:String,_ cell:CategoriesCollectionViewCell){
        
        if  let imageUrl=URL(string:urlString){
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                let urlContents=try?  Data(contentsOf: imageUrl)
                DispatchQueue.main.async {
                    if let imageData=urlContents{
                        cell.categoryImage.image=UIImage(data:imageData)
                       
                       
                    }
                }
            }
            
        }
    }
}//end of class
