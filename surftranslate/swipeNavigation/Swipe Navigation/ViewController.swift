//
//  ViewController.swift
//  Swipe Navigation
//
//  Created by Michelle Truong on 6/7/16.
//  Copyright © 2016 Michelle Truong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!// Master View Controller it handles scroll view
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc0 = ViewController0(nibName: "ViewController0", bundle: nil)
        
        self.addChildViewController(vc0)
        self.scrollView.addSubview(vc0.view)
        vc0.didMoveToParentViewController(self)
        
        let vc1 = ViewController1(nibName: "ViewController1", bundle: nil)
        var frame1 = vc1.view.frame
        frame1.origin.x = self.view.frame.size.width
        vc1.view.frame = frame1
        
        self.addChildViewController(vc1)
        self.scrollView.addSubview(vc1.view)
        vc1.didMoveToParentViewController(self)
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

