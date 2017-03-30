//
//  RewardVideoViewController.swift
//  90 DWT 1
//
//  Created by Grant, Jared on 1/11/17.
//  Copyright © 2017 Jared Grant. All rights reserved.
//

import UIKit

class RewardVideoViewController: UIViewController {

    var shouldShowAd = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        if shouldShowAd {
            
            // Fetch the rewarded video ad.
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone) {
                
                // iPhone
                // Rewarded Ad Unit
                MPRewardedVideo.presentAd(forAdUnitID: "f41f0c37b0aa4e939b052e74322a8719", from: self, with: nil)
            }
            else {
                
                // iPad
                // Rewarded Ad Unit
                MPRewardedVideo.presentAd(forAdUnitID: "895ad8786fb7436f86219a3bff896c1f", from: self, with: nil)
            }
            
            shouldShowAd = false
        }
        else {
            
            dismiss(animated: true, completion: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
