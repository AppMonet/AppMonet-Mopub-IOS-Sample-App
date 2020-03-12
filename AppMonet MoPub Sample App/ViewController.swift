//
//  ViewController.swift
//  AppMonet MoPub Sample App
//
//  Created by Jose Portocarrero on 3/11/20.
//  Copyright © 2020 Monet. All rights reserved.
//

import UIKit
import MoPub
import AppMonet_Mopub

class ViewController: UIViewController, MPAdViewDelegate, MPInterstitialAdControllerDelegate {
    var adView : MPAdView = MPAdView(adUnitId: "b03e6dccfe9e4abab02470a39c88d5dc")
    var interstitial : MPInterstitialAdController = MPInterstitialAdController(forAdUnitId: "a49430ee57ee4401a9eda6098726ce54")
    
    // Mark: MPAdViewDelegate
    
    func viewControllerForPresentingModalView() -> UIViewController! {
        return self
    }
    
    func adViewDidLoadAd(_ view: MPAdView!, adSize: CGSize) {
        NSLog("Ad View did load")
        self.showToast(controller: self, message: "Banner Loaded", seconds: 1)
    }
    
    func adView(_ view: MPAdView!, didFailToLoadAdWithError error: Error!) {
        NSLog("Ad View did fail")
        self.showToast(controller: self, message: "Banner Failed", seconds: 1)
    }
    
    // Mark: MPInterstitialAdControllerDelegate

    func interstitialDidFail(toLoadAd interstitial: MPInterstitialAdController!) {
        NSLog("Interstitial failed to load")
        self.showToast(controller: self, message: "Interstitial Failed", seconds: 1)
    }
    func interstitialDidLoadAd(_ interstitial: MPInterstitialAdController!) {
        NSLog("Interstitial did load")
        self.showToast(controller: self, message: "Interstitial Loaded", seconds: 1)
    }
    func interstitialWillAppear(_ interstitial: MPInterstitialAdController!) {
        NSLog("Interstitial will appear")
    }
    
    // MARK: LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.adView.frame = CGRect(x: (self.view.bounds.size.width - 300)/2,
                                   y: self.view.bounds.size.height - kMPPresetMaxAdSize250Height.height,
                                   width: 300,
                                   height: kMPPresetMaxAdSize250Height.height
        )
        self.adView.delegate = self
        self.interstitial.delegate = self
        self.view .addSubview(self.adView)
    }

    // MARK: Buttons
    
    @IBAction func loadMrect(_ sender: Any) {
        AppMonet.addBids(adView, andTimeout: 4000) {
            self.adView.loadAd()
        }
    }
    
    @IBAction func loadInterstitial(_ sender: Any) {
        interstitial .loadAd()
    }
    
    @IBAction func showInterstitial(_ sender: Any) {
        if(interstitial.ready){
            interstitial .show(from: self)
        } else {
            self .showToast(controller: self, message: "Interstitial is not ready", seconds: 1)
        }
    }
    
    // MARK: Private
    
    private func showToast(controller: UIViewController, message:String, seconds: Double){
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = UIColor.black
        alert.view.alpha = 0.6
        alert.view.layer.cornerRadius = 15
        
        controller.present(alert, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+seconds) {
            alert.dismiss(animated: true)
        }
    }
}
