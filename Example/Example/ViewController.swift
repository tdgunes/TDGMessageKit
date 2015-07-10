//
//  ViewController.swift
//  Example
//
//  Created by Taha Doğan Güneş on 10/07/15.
//  Copyright (c) 2015 Taha Doğan Güneş. All rights reserved.
//

import UIKit
import TDGMessageKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        var upperMessageBox = TDGMessageBox(orientation: .Bottom)
        upperMessageBox.titleLabel.text = "TitleLabel Example Text"
        upperMessageBox.bodyLabel.text = "BodyLabel Example Text"
        upperMessageBox.view.alpha = 0.8
        upperMessageBox.addTo(self.view)
        upperMessageBox.toggle()
        
        
        var bottomMessageBox = TDGMessageBox(orientation: .Top)
        bottomMessageBox.titleLabel.text = "TitleLabel Example Text"
        bottomMessageBox.bodyLabel.text = "BodyLabel Example Text"
        bottomMessageBox.addTo(self.view)
        bottomMessageBox.toggle()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

