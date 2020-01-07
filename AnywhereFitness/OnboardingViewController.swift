//
//  OnboardingViewController.swift
//  AnywhereFitness
//
//  Created by Lambda_School_Loaner_204 on 1/6/20.
//  Copyright © 2020 Lambda_School_Loaner_219. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController, WalkthroughViewControllerDelegate {

    let walkthroughs = [
        WalkthroughModel(title: "Quick Overview", subtitle: "Quickly visualize important business metrics. The overview in the home tab shows the most important metrics to monitor how your business is doing in real time.", icon: "analytics-icon"),
        WalkthroughModel(title: "Analytics", subtitle: "Dive deep into charts to extract valuable insights and come up with data driven product initiatives, to boost the success of your business.", icon: "bars-icon"),
        WalkthroughModel(title: "Dashboard Feeds", subtitle: "View your sales feed, orders, customers, products and employees.", icon: "activity-feed-icon"),
        WalkthroughModel(title: "Get Notified", subtitle: "Receive notifications when critical situations occur to stay on top of everything important.", icon: "bell-icon"),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        let walkthroughVC = self.walkthroughVC()
        walkthroughVC.delegate = self
        self.addChildViewControllerWithView(walkthroughVC)
    }

    func walkthroughViewControllerDidFinishFlow(_ vc: WalkthroughViewController) {
        onboardingSkipOrLastPageTransition(vc)
    }

    fileprivate func walkthroughVC() -> WalkthroughViewController {
        let viewControllers = walkthroughs.map { WalkthroughPageViewController(model: $0, nibName: "WalkthroughPageViewController", bundle: nil) }
        return WalkthroughViewController(nibName: "WalkthroughViewController",
                                            bundle: nil,
                                            viewControllers: viewControllers)
    }

    private func onboardingSkipOrLastPageTransition(_ viewController: UIViewController) {
        UIView.transition(with: self.view, duration: 1, options: .transitionFlipFromLeft, animations: {
            viewController.view.removeFromSuperview()

            let storyboard = UIStoryboard(name: "Launch", bundle: nil)
            let viewControllerToBePresented = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
            self.addChildViewControllerWithView(viewControllerToBePresented)
            self.view.addSubview(viewControllerToBePresented.view)

        }, completion: nil)
    }
}

