//
//  pagerViewController.swift
//  catsPOCSwft
//
//  Created by Claudia Cortes on 6/21/22.
//

import UIKit
import Alamofire

class pagerViewController: UIPageViewController,UIPageViewControllerDelegate,UIPageViewControllerDataSource {
    
    lazy var orderViewControllers:[UIViewController]={
        return [self.newVC(viewControllerID: "slidePage",index:1),self.newVC(viewControllerID: "slidePage",index:2),self.newVC(viewControllerID: "slidePage",index: 3),]
    }()
    private var textDescriptions:[String]=["Welcome to the cats app, here you can find lots of information to lear more about your furry friend! lets take an overview about what you can do here!",
    "Have you ever wonder about the type of breed of a cat? which are their characteristics and more? well, not anymore! you can find all the information related to cat breeds here!",
    "Besides of learning you can also have fun!, we all can agree that watching funny cat pictures is relaxing!, guess what? you can also do that in here!You can either see them divided by category or just have a random picture!."]
    func newVC(viewControllerID:String,index:Int)->UIViewController{
        let controller=UIStoryboard(name:"Main",bundle: nil).instantiateViewController(withIdentifier: viewControllerID)
        if let  lottiePage  = controller as? LottieViewController{
            lottiePage.descriptiontext=textDescriptions[index-1]
            lottiePage.lottieName="slide-\(index)"
        }
        return controller
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource=self
        if  let firstViewController = orderViewControllers.first{
            setViewControllers([firstViewController],
                               direction:.forward,
                               animated: true,
                               completion:nil)
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex=orderViewControllers.index(of:viewController) else {
            return nil
        }
        let previousIndex = viewControllerIndex-1
        
        guard previousIndex >= 0 else{
            return orderViewControllers.last
        }
        
        guard orderViewControllers.count>previousIndex else{
            return nil
        }
        
        return orderViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex=orderViewControllers.index(of:viewController) else {
            return nil
        }
        let nextIndex = viewControllerIndex + 1
        
        guard orderViewControllers.count != nextIndex  else{
            
            return orderViewControllers.first
        }
        
        guard orderViewControllers.count>nextIndex else{
            return nil
        }
        
        return orderViewControllers[nextIndex]
    }
    
    
    
}
