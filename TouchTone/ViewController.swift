//
//  ViewController.swift
//  TouchTone
//
//  Created by Binnur Al-Kazily on 6/4/19.
//  Copyright © 2019 Binnur Al-Kazily. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var toneGenerator: ToneGenerator = ToneGenerator()

    @IBOutlet weak var touchButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        print("viewDidLoad")
        // start AudioUnit
        //toneGenerator.initAudioUnit()

        toneGenerator.startEngine()
    }

    override func viewDidDisappear(_ animated: Bool) {
        print("viewDidDissapear")
        toneGenerator.stopEngine()
    }

    @IBAction func touchDown(_ sender: Any) {
        touchButton.isHighlighted = true
//        toneGenerator.play()
        toneGenerator.unmuteEngine()
    }

    @IBAction func touchUpInside(_ sender: Any) {
        touchButton.isHighlighted = false
//        toneGenerator.stop()
        toneGenerator.muteEngine()
    }

}

