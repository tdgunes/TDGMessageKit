//
//  TDGMessageBox.swift
//  Deformity
//
//  Created by Taha Doğan Güneş on 07/07/15.
//  Copyright (c) 2015 Taha Doğan Güneş. All rights reserved.
//

import UIKit

extension Int {
    var toRadians : CGFloat {
        return CGFloat(self) * CGFloat(M_PI) / 180.0
    }
    
}


public class TDGMessageBox: UIView  {
    
    public typealias OnTapCallBack =  ()->()
    
    @IBOutlet public weak var titleLabel: UILabel!
    @IBOutlet public weak var imageView: UIImageView!
    @IBOutlet public weak var bodyLabel: UILabel!
    
    
    public var onTap: OnTapCallBack?
    var view: UIView!
    let height = CGFloat(52)
    public var orientation: Orientation?
    
    public enum Orientation {
        case Top
        case Bottom
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "TDGMessageBox", bundle: bundle)
        
        let view = nib.instantiateWithOwner(self, options: nil).first as! UIView
        return view
    }
    
    
    func finalizeXibSetup() {
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        addSubview(view)
    }
    
    public convenience init(orientation:Orientation) {
        self.init(frame:CGRectZero)
        self.orientation = orientation
        self.setupRecognizers()
    }
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        finalizeXibSetup()
    }
    
    public required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        finalizeXibSetup()
    }
    
    public func addTo(view:UIView){
        self.hidden = true
        
        view.addSubview(self)
        self.calculateFrame()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "deviceOrientationDidChangeNotification:", name: UIDeviceOrientationDidChangeNotification, object: nil)
    }
    func calculateFrame() {
        
        if let oriented = self.orientation {
            let screenWidth = self.getScreenWidth()
            let statusBarHeight = self.getStatusBarHeight()
            switch oriented {
            case .Top:
                var viewYPosition = -self.height
                if (!self.hidden) {
                    viewYPosition = statusBarHeight
                }
                self.frame = CGRectMake(CGFloat(0), statusBarHeight, screenWidth, self.height)
                break
            
            case .Bottom:
                let screenHeight = self.getScreenHeight()
                var viewYPosition = screenHeight
                if (!self.hidden) {
                    viewYPosition -= self.height
                }

                self.frame = CGRectMake(CGFloat(0), viewYPosition, screenWidth, self.height)
                break
            }
            
        }
    }
    
    func setupRecognizers() {
        var recognizer = UITapGestureRecognizer(target: self, action: "handleTapFrom:")
        recognizer.numberOfTapsRequired = 1
        self.addGestureRecognizer(recognizer)
        
    }
    
    func handleTapFrom(recognizer:UITapGestureRecognizer) {
        println("Tap to messageBox")
        
        if let callback = self.onTap {
            callback()
        }
    }
    
    public func toggle() {
        if let oriented = self.orientation {
            switch oriented {
            case .Bottom:
                println("animateButtomUp()")
                if self.hidden {
                    self.animateBottomUp()
                } else {
                    self.animateBottomDown()
                }

                break
                
            case .Top:
                
                if self.hidden {
                    self.animateTopDown()
                } else {
                    self.animateTopUp()
                }
                
                
                break
            }
            
            
        }
    }
    
    public func focus() {
        let normal:CGAffineTransform =  CGAffineTransformRotate(CGAffineTransformIdentity, 0.toRadians)
        let leftWooble:CGAffineTransform = CGAffineTransformRotate(CGAffineTransformIdentity, -1.toRadians)
        let rightWooble:CGAffineTransform = CGAffineTransformRotate(CGAffineTransformIdentity, 1.toRadians)
        
        self.transform = leftWooble
        
        UIView.animateWithDuration(0.120, delay: 0.0, options: UIViewAnimationOptions.Autoreverse , animations: {
            self.transform = rightWooble
        }, completion: { finished in
            self.transform = normal
        })
    }
    
    public func hide() {
        if let oriented = self.orientation {
            switch oriented {
            case .Bottom:
                println("animateButtomDown()")
                if !self.hidden {
                    self.animateBottomDown()
                }
                
                break
                
            case .Top:
                if !self.hidden {
                    self.animateTopUp()
                }
                break
            }
            
            
        }
    }
    
    public func whiten() {
        self.titleLabel.textColor = UIColor.whiteColor()
        self.bodyLabel.textColor = UIColor.whiteColor()
        self.imageView.tintColor = UIColor.whiteColor()
        self.imageView.image = self.imageView.image!.imageWithRenderingMode(.AlwaysTemplate)
    }
    
    func deviceOrientationDidChangeNotification(notification:NSNotification) {
        self.calculateFrame()
    }

    private func animateBottomDown(){
        UIView.animateWithDuration(0.5, delay: 0.1, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.frame.origin.y += self.frame.size.height
            
        }, completion: {finished in
            self.hidden = true

        })
    }
    
    private func animateBottomUp() {
        self.hidden = false
        UIView.animateWithDuration(0.5, delay: 0.1, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.frame.origin.y -= self.frame.size.height
            }, completion: {finished in


        } )
    }
    
    private func animateTopDown() {
        self.hidden = false
        
        UIView.animateWithDuration(0.5, delay: 0.1, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.frame.origin.y += self.frame.size.height
            }, completion: {finished in

                
        } )
    }
    
    private func animateTopUp() {
        UIView.animateWithDuration(0.5, delay: 0.1, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.frame.origin.y -= self.frame.size.height
            
            }, completion: {finished in
                self.hidden = true
                
        })
    }
    
    private func getScreenHeight() ->CGFloat {
        return UIScreen.mainScreen().bounds.size.height
    }
    
    private func getScreenWidth() ->CGFloat {
        return UIScreen.mainScreen().applicationFrame.width
    }
    
    private func getStatusBarHeight()->CGFloat {
        return UIApplication.sharedApplication().statusBarFrame.size.height
    }

}
