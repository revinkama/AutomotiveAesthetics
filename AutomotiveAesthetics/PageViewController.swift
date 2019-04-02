//
//  PageViewController.swift
//  AutomotiveAesthetics
//
//  Created by Kevin Rama on 3/6/19.
//  Copyright © 2019 Kevin Rama. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    var pageControl = UIPageControl();
    
    func configPageControl() {
        pageControl = UIPageControl(frame: CGRect(x: 0, y: UIScreen.main.bounds.maxY - 50, width: UIScreen.main.bounds.width, height: 50));
        pageControl.numberOfPages = orderedViewControllers.count;
        pageControl.currentPage = 0;
        pageControl.tintColor = UIColor.white;
        pageControl.pageIndicatorTintColor = UIColor.lightGray;
        pageControl.currentPageIndicatorTintColor = UIColor.black;
        self.view.addSubview(pageControl);
    }
    
    lazy var orderedViewControllers: [UIViewController] = {
        return [self.newVC(viewController: "HOME1ST"),
                self.newVC(viewController: "HOME2ND")]
    }()
    
    func newVC(viewController: String) -> UIViewController{
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: viewController);
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let VCindex = orderedViewControllers.index(of: viewController) else {
            return nil;
        }
        
        let prevIndex = VCindex - 1
        
        guard prevIndex >= 0 else {
            return nil;
        }
        
        guard orderedViewControllers.count > prevIndex else {
            return nil
        }
        
        return orderedViewControllers[prevIndex];
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let VCindex = orderedViewControllers.index(of: viewController) else {
            return nil;
        }
        
        let nextIndex = VCindex + 1
        
        guard orderedViewControllers.count != nextIndex else {
            return nil;
        }
        
        guard orderedViewControllers.count > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex];
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let pageContentViewController = pageViewController.viewControllers![0];
        self.pageControl.currentPage = orderedViewControllers.index(of: pageContentViewController)!
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self;
        
        if let FVC = orderedViewControllers.first {
            setViewControllers([FVC],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
        
        self.delegate = self;
        configPageControl();
        
        // Do any additional setup after loading the view.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
