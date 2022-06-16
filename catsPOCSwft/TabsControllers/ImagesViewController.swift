//
//  ImagesViewController.swift
//  catsPOCSwft
//
//  Created by Claudia Cortes on 6/15/22.
//

import UIKit
import Alamofire
class ImagesViewController: UIViewController {
    
    @IBOutlet weak var btnReloadImage: UIButton!
    @IBOutlet weak var lblMessage: UILabel!
    
    @IBOutlet weak var catImage: UIImageView!
    
    
    var imageURL:URL?{
        didSet{
            catImage.image=nil
            if view.window != nil{// to check if i am on screen
                loadImage()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if imageURL==nil{fetchImageURL()}
        lblMessage.sizeToFit()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if catImage.image==nil{loadImage()}
    }
    
    private func loadImage(){
        if let url=imageURL{
            //            spinner.startAnimating()
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                let urlContents=try?  Data(contentsOf: url)
                
                DispatchQueue.main.async {
                    if let imageData=urlContents,url==self?.imageURL{
                        self?.catImage.image=UIImage(data:imageData)
                        
                    }
                }
            }
            //            spinner.stopAnimating()
            
        }
        
    }
    
    //clicking functions
    
    @IBAction func onReloadClicked(_ sender: UIButton) {
        fetchImageURL()
    }
    
    func fetchImageURL() {
        //call the api for random url
        AF.request("https://api.thecatapi.com/v1/images/search",encoding: JSONEncoding.default)
            .responseJSON { response in
                if let status = response.response?.statusCode {
                    switch(status){
                    case 200:
                        //to get JSON return value
                        if let result = response.value {
                            let images = result as! [NSDictionary]
                            if !images.isEmpty{
                                let url = images[0].object(forKey: "url")!
                                self.imageURL=URL(string: url as! String)
                            }
                        }
                    default:
                        print("error with response status: \(status)")
                    }
                }
                
            }
    }
}//end of class
