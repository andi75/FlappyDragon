//
//  ViewController.swift
//  FlappyDragon
//
//  Created by Andreas Umbach on 23.09.2015.
//  Copyright © 2015 Andreas Umbach. All rights reserved.
//

import UIKit
import SpriteKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let scene = GameScene()
        (self.view as! SKView).presentScene(scene)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

