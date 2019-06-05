//
//  ViewController.swift
//  TouchTone
//
//  Created by Binnur Al-Kazily on 6/4/19.
//  Copyright © 2019 Binnur Al-Kazily. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var toneGenerator: ToneGenerator = ToneGenerator()


    @IBOutlet weak var touchButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func touchDown(_ sender: Any) {
        print("touch started")
        toneGenerator.start()
    }

    @IBAction func touchUpInside(_ sender: Any) {
        print("touch ended")
        toneGenerator.stop()
    }

}

