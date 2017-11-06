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

        // set delegate
        //Appodeal.setRewardedVideoDelegate(self)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        if shouldShowAd {
            
            //Appodeal.showAd(AppodealShowStyle.rewardedVideo, rootViewController: self)
        }
        else {
            
            dismiss(animated: true, completion: nil)
        }
    }
    /*
    func rewardedVideoDidFinish(_ rewardAmount: UInt, name rewardName: String!){
        //NSLog("video ad was fully watched")
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        appDelegate.endDate = NSDate.init(timeIntervalSinceNow: (60.0 * 60.0))
        appDelegate.shouldShowRewardGraph = true
        
        shouldShowAd = false
        
    }
 */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
