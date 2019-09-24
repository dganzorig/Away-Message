//
//  SuggestionsPageViewController.swift
//  Away Message
//
//  Created by Dona Ganzorig on 9/24/19.
//  Copyright © 2019 Dona Ganzorig. All rights reserved.
//

import UIKit

class SuggestionsPageViewController: UIPageViewController {
    
    var categoryEntry: CategoryEntry?
    var pageControl = UIPageControl()
    
    lazy var orderedViewControllers: [UIViewController] = {
        // Set up Suggestions ViewController
        let suggestionsVC = self.newVC(viewController: "sbSuggestions") as! CategorySuggestionViewController
        suggestionsVC.categoryEntry = self.categoryEntry
        
        // Set up Suggestion Submit ViewController
        let suggestionSubmitVC = self.newVC(viewController: "sbSuggestionSubmit") as! SubmitSuggestionViewController
        
        let popularSuggestionsVC = self.newVC(viewController: "sbPopularSuggestions") as! PopularSuggestionsViewController
        
        // Now return them in an ordered array
        return [ suggestionsVC, suggestionSubmitVC, popularSuggestionsVC ]
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.dataSource = self
        
        if let firstViewController = self.orderedViewControllers.first {
            self.setViewControllers([firstViewController],
                                    direction: .forward,
                                    animated: true,
                                    completion: nil)
        }
        
        self.delegate = self
        self.configurePageControl()
    }
    
    func newVC(viewController: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: viewController)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let pageContentViewController = pageViewController.viewControllers![0]
        self.pageControl.currentPage = orderedViewControllers.firstIndex(of: pageContentViewController)!
    }
    
    func configurePageControl() {
        let height: CGFloat = 70.0
        pageControl = UIPageControl(frame: CGRect(x: 0, y: UIScreen.main.bounds.maxY - height, width: UIScreen.main.bounds.width, height: height))
        pageControl.numberOfPages = orderedViewControllers.count
        pageControl.currentPage = 0
        pageControl.tintColor = UIColor.black
        pageControl.pageIndicatorTintColor = UIColor(red: 0.0 / 255.0, green: 0.0 / 255.0, blue: 153.0 / 255.0, alpha: 0.6)
        pageControl.currentPageIndicatorTintColor = UIColor(red: 0.0 / 255.0, green: 0.0 / 255.0, blue: 153.0 / 255.0, alpha: 1.0)
        self.view.addSubview(pageControl)
    }

}

extension SuggestionsPageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        // make sure we can know our index based on current view controller
        guard let viewControllerIndex = self.orderedViewControllers.firstIndex(of: viewController) else {
            return nil
        }
        // so now we can calculate previous index we should transition to
        let prevIndex = viewControllerIndex - 1
        // if we fall through transitioning left, then wrap around to last view controller
        guard prevIndex >= 0 else {
            return self.orderedViewControllers.last
        }
        // if index falls past available view controllers (higher), then return nothing (odd fallback state)
        guard self.orderedViewControllers.count > prevIndex else {
            return nil
        }
        
        return self.orderedViewControllers[prevIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        // make sure we can know our index based on current view controller
        guard let viewControllerIndex = self.orderedViewControllers.firstIndex(of: viewController) else {
            return nil
        }
        // so now we can calculate the next index we should transition to
        let nextIndex = viewControllerIndex + 1
        // if we fall through transitioning right for first time, then wrap around to first view controller
        guard self.orderedViewControllers.count != nextIndex else {
            return orderedViewControllers.first
        }
        // if index falls past available view controllers, then return nothing (odd fallback state)
        guard self.orderedViewControllers.count > nextIndex else {
            return nil
        }
        
        return self.orderedViewControllers[nextIndex]
        
    }
    
}
