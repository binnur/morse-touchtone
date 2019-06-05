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
        print("touch down")
        toneGenerator.start()
    }

    @IBAction func touchUpInside(_ sender: Any) {
        print("touch release")
        toneGenerator.stop()
    }

    @IBAction func touchDownRepeat(_ sender: Any) {
        // double click -- triggered w/ touch down combined w/ a repeat
        print("touchDownRepeat")
    }

    @IBAction func touchCancel(_ sender: Any) {
        // not triggered
        print("touchCancel")
    }

    @IBAction func touchUpOutside(_ sender: Any) {
        // not triggered
        print("touchUpOutside")
    }

    @IBAction func touchPrimaryAction(_ sender: Any) {
        // triggered when touch down (includes double click) + up complete
        print("touch primary action triggered!")
    }

}

