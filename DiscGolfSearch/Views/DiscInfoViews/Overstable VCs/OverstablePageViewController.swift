//
//  StabilityViewController.swift
//  DiscGolfSearch
//
//  Created by Kinney Kare on 10/1/23.
//

import UIKit

class OverstablePageViewController: UIPageViewController {
    
    var pages = [UIViewController]()
    let pageControl = UIPageControl()
    let initialPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        style()
        layout()
    }
    
    
    
    func setup() {
        dataSource = self
        delegate = self
        
        pageControl.addTarget(self, action: #selector(pageControlTapped(_:)), for: .valueChanged)
        
        // create an array of viewController
        let storyboard = UIStoryboard(name: "StabilityInfo", bundle: nil) // Update "Main" to your storyboard name
        
        if let page1 = storyboard.instantiateViewController(withIdentifier: "overstableVC1") as? OverstableVC1,
           let page2 = storyboard.instantiateViewController(withIdentifier: "overstableVC2") as? OverstableVC2,
           let page3 = storyboard.instantiateViewController(withIdentifier: "overstableVC3") as? OverstableVC3,
           let page4 = storyboard.instantiateViewController(withIdentifier: "overstableVC4") as? OverstableVC4,
           let page5 = storyboard.instantiateViewController(withIdentifier: "overstableVC5") as? OverstableVC5 {
            pages.append(page1)
            pages.append(page2)
            pages.append(page3)
            pages.append(page4)
            pages.append(page5)
        }
        
        // set initial viewController to be displayed
        // Note: We are not passing in all the viewControllers here. Only the one to be displayed.
        setViewControllers([pages[initialPage]], direction: .forward, animated: true, completion: nil)
    }
    
    func style() {
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        //pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .systemGray2
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = initialPage
    }
    
    func layout() {
        view.addSubview(pageControl)
        
        // Constrain pageControl above the tab bar
        let safeArea = self.view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            pageControl.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            pageControl.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            // You can adjust the height as needed
            pageControl.heightAnchor.constraint(equalToConstant: 20),
            // Match the width of the view controller's view
            pageControl.widthAnchor.constraint(equalTo: safeArea.widthAnchor)
        ])
    }
}


// MARK: - Actions
extension OverstablePageViewController {
    
    // How we change page when pageControl tapped.
    // Note - Can only skip ahead on page at a time.
    @objc func pageControlTapped(_ sender: UIPageControl) {
        setViewControllers([pages[sender.currentPage]], direction: .forward, animated: true, completion: nil)
    }
}

// MARK: - DataSources
extension OverstablePageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        
        if currentIndex == 0 {
            return pages.last               // wrap to last
        } else {
            return pages[currentIndex - 1]  // go previous
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        
        if currentIndex < pages.count - 1 {
            return pages[currentIndex + 1]  // go next
        } else {
            return pages.first              // wrap to first
        }
    }
}

// MARK: - Delegates
extension OverstablePageViewController: UIPageViewControllerDelegate {
    
    // How we keep our pageControl in sync with viewControllers
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        guard let viewControllers = pageViewController.viewControllers else { return }
        guard let currentIndex = pages.firstIndex(of: viewControllers[0]) else { return }
        
        pageControl.currentPage = currentIndex
    }
}
