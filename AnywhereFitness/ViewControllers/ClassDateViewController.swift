//
//  ClassDateViewController.swift
//  AnywhereFitness
//
//  Created by Lambda_School_Loaner_204 on 1/8/20.
//  Copyright © 2020 Lambda_School_Loaner_219. All rights reserved.
//

import UIKit

protocol ClassDateViewControllerDelegate {
    func saveDateButtonWasPressed(date: Date)
}

class ClassDateViewController: UIViewController {

    @IBOutlet private weak var datePicker: UIDatePicker!

    var date: Date?
    var delegate: ClassDateViewControllerDelegate?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateViews()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    private func updateViews() {
        if let date = date {
            datePicker.setDate(date, animated: false)
        } else {
            datePicker.setDate(Date(), animated: false)
        }
    }

    @IBAction func saveDateButtonTapped(sender: UIButton) {
        delegate?.saveDateButtonWasPressed(date: datePicker.date)
        dismiss(animated: true, completion: nil)
    }
}
