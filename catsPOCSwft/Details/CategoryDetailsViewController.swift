//
//  CategoryViewController.swift
//  catsPOCSwft
//
//  Created by Claudia Cortes on 6/17/22.
//

import UIKit
import Alamofire
class CategoryDetailsViewController:UIViewController,UICollectionViewDataSource  {
    @IBOutlet weak var lblTitleDescription: UILabel!
    
    @IBOutlet weak var loadingSpinner: UIActivityIndicatorView!
    @IBOutlet weak var categoryImagesCollectionView: UICollectionView!
    
    private var images=[URL](){
        didSet{
            //TODO: reload the collectionview
            print("Images loaded")
            DispatchQueue.main.async {
                self.categoryImagesCollectionView.reloadData()
                self.loadingSpinner.stopAnimating()
            }
        }
    }
    
    var category:Category!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchImages()
        self.title = category.name.capitalized
        lblTitleDescription.text = "Enjoy the pictures of cats in : \(category.name)"
        categoryImagesCollectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = categoryImagesCollectionView.dequeueReusableCell(withReuseIdentifier: "imageCategoryDetail", for: indexPath) as! CategoryDetailsCollectionViewCell
        let image=images[indexPath.row]
        
        cell.loadingSpinner.startAnimating()
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            let urlContents=try?  Data(contentsOf: image)
            DispatchQueue.main.async {
                if let imageData=urlContents{
                    cell.imageCategory.image=UIImage(data:imageData)
                    cell.loadingSpinner.stopAnimating()
                }
            }
        }
        
        return cell
    }
    
    
    private func fetchImages(){
        let parameters = APIParameters(category_ids: category.id, limit:20)
        print("starting....... for category \(category.id) \(category.name)")
        loadingSpinner.startAnimating()
        AF.request("https://api.thecatapi.com/v1/images/search",
                   parameters: parameters,
                   headers: API.headers
        ).responseJSON { [self] response in
            if let result = response.value {
                let images = result as! [NSDictionary]
                if !images.isEmpty{
                    var urls=[URL]()
                    // let urlString = images[0].object(forKey: "url")! as! String
                    for image in images{
                        if let urlString = image.object(forKey: "url")! as? String,let tempUrl=URL(string: urlString){
                            print(tempUrl)
                            urls.append(tempUrl)
                        }
                    }
                    self.images=urls
                }
            }
        }
        
    }
    
    
}
