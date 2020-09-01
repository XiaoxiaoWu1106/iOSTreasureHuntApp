//
//  ViewController.swift
//  TreasureHuntingiOS
//
//  Created by Xiaoxiao Wu on 22.8.2020.
//  Copyright © 2020 Xiaoxiao Wu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        JSONParser.init().parseHunt(fileName: "demo_hunt")
    }


}

