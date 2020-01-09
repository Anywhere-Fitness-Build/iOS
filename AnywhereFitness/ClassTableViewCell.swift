//
//  ClassTableViewCell.swift
//  AnywhereFitness
//
//  Created by Lambda_School_Loaner_204 on 1/8/20.
//  Copyright © 2020 Lambda_School_Loaner_219. All rights reserved.
//

import UIKit

class ClassTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var instructorLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var locationLabel: UILabel!

    var fitnessClass: FitnessClass? {
        didSet {
            updateViews()
        }
    }

    private func updateViews() {
        guard let fitnessClass = fitnessClass else { return }

        titleLabel.text = fitnessClass.name
        // have to somehow get the instructor name here!
        //instructorLabel.text = fitnessClass.
        dateLabel.text = fitnessClass.startTime
        locationLabel.text = fitnessClass.location
    }
}
