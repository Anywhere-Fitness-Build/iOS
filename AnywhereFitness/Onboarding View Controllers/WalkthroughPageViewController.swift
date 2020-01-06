//
//  WalkthroughPageViewController.swift
//  AnywhereFitness
//
//  Created by Lambda_School_Loaner_204 on 1/6/20.
//  Copyright © 2020 Lambda_School_Loaner_219. All rights reserved.
//

import UIKit

class WalkthroughPageViewController: UIViewController {
    @IBOutlet var containerView: UIView!
    @IBOutlet var imageContainerView: UIView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!
    
    let model: WalkthroughModel
    
    init(model: WalkthroughModel,
         nibName nibNameOrNil: String?,
         bundle nibBundleOrNil: Bundle?) {
        self.model = model
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = UIImage.localImage(model.icon, template: true)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.tintColor = .white
        imageContainerView.backgroundColor = .clear
        
        titleLabel.text = model.title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        titleLabel.textColor = .white
        
        subtitleLabel.attributedText = NSAttributedString(string: model.subtitle)
        subtitleLabel.font = UIFont.systemFont(ofSize: 14.0)
        subtitleLabel.textColor = .white
        
        containerView.backgroundColor = UIColor(hexString: "#3068CC")
    }
}
