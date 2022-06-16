//
//  ImagesViewController.swift
//  catsPOCSwft
//
//  Created by Claudia Cortes on 6/15/22.
//

import UIKit

class ImagesViewController: UIViewController {
    
    @IBOutlet weak var btnReloadImage: UIButton!
    @IBOutlet weak var lblMessage: UILabel!
    
    @IBOutlet weak var catImage: UIImageView!
    
    
    var imageURL:URL?{
        didSet{
            catImage.image=nil
            if view.window != nil{// to check if i am on screen
                fetchImage()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if imageURL==nil{
            imageURL=URL(string: "https://cdn2.thecatapi.com/images/sDmw9mgHP.png")
        }
        lblMessage.sizeToFit()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if catImage.image==nil{
            fetchImage()
        }
    }
    
    private func fetchImage(){
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
        //call the api for random url
        //https://api.thecatapi.com/v1/images/search
        imageURL=URL(string: "https://cdn2.thecatapi.com/images/5kc.png")
    }
//    "breeds": [],
//        "height": 333,
//        "id": "d9f",
//        "url": "https://cdn2.thecatapi.com/images/d9f.jpg",
//        "width": 500
    
}
