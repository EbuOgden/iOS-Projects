//
//  ViewController.swift
//  PageScroll
//
//  Created by Ebubekir on 11/17/16.
//  Copyright © 2016 Ebubekir. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    var images = [UIImageView]()
    
    override func viewDidLoad() {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidLoad()
        
        let leftSwipe = UISwipeGestureRecognizerDirection.left // Left Swipe Recognizer
        
        let rightSwipe = UISwipeGestureRecognizerDirection.right // Right Swipe Recognizer
        
        
        let gestureRecognizerLeft = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.leftSwipeMethod)) // Swipe Recognizer for Left Side!
        gestureRecognizerLeft.direction = leftSwipe
        
        let gestureRecognizerRight = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.rightSwipeMethod)) // Swipe Recognizer for Right Side!
        gestureRecognizerRight.direction = rightSwipe

        view.addGestureRecognizer(gestureRecognizerLeft)
        
        view.addGestureRecognizer(gestureRecognizerRight)
        
        let viewWidth = view.frame.size.width
        
        let scrollViewWidth = scrollView.frame.size.width
        
        var contentWidth : CGFloat = 0.0
        
        for x in 0...2 {
            
            let image = UIImage(named: "icon\(x).png")
            
            let imageView = UIImageView(image: image)
            
            images.append(imageView)
            
            var newX : CGFloat = 0.0
            
            newX = scrollViewWidth / 2 + scrollViewWidth * CGFloat(x)
            
            contentWidth += newX
            
            scrollView.addSubview(imageView)
            
            imageView.frame = CGRect(x: newX - 75, y: view.frame.midY - 75, width: 150, height: 150)
            
        }
        
        contentWidth -= viewWidth
        
        scrollView.clipsToBounds = false
        
        scrollView.contentSize = CGSize(width: contentWidth, height: view.frame.size.height)

    }
    
    func leftSwipeMethod(recognizer : UISwipeGestureRecognizer){ // Swipe Left Method
        var locationX = CGPoint(x: recognizer.location(in: self.view).x, y: 0)
        let scrollViewX = scrollView.frame.origin.x
        let contentSize = scrollView.contentSize.width
        
        locationX.x += scrollViewX
        
        if(locationX.x > contentSize - 150){ // Protection for out of box!
            locationX.x = (contentSize - 150)
        }
        
        scrollView.setContentOffset(locationX, animated: true)
        
    }
    
    func rightSwipeMethod(recognizer : UISwipeGestureRecognizer){// Swipe Right Method
        var locationX = CGPoint(x: recognizer.location(in: self.view).x, y: 0)
        let scrollViewX = scrollView.frame.origin.x
        
        locationX.x -= scrollViewX
        
        if(locationX.x < 0){
            locationX.x = 0
        }
        
        scrollView.setContentOffset(locationX, animated: true)

    }


}

