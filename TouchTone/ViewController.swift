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

        // start AudioUnit
        //toneGenerator.startAudioUnit()
    }

    @IBAction func touchDown(_ sender: Any) {
        print("touch started")
        touchButton.isHighlighted = true
        toneGenerator.play()
    }

    @IBAction func touchUpInside(_ sender: Any) {
        print("touch ended")
        touchButton.isHighlighted = false
        toneGenerator.stop()
    }

}

