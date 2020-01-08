//
//  ClassDetailViewController.swift
//  AnywhereFitness
//
//  Created by Lambda_School_Loaner_204 on 1/7/20.
//  Copyright © 2020 Lambda_School_Loaner_219. All rights reserved.
//

import UIKit

enum IntensityLevel: Int {
    case low
    case medium
    case high
}

class ClassDetailViewController: UIViewController, ClassDateViewControllerDelegate {

    // MARK: - IBOutlets
    @IBOutlet private weak var classNameTextField: UITextField!
    @IBOutlet private weak var classTypeTextField: UITextField!
    @IBOutlet private weak var locationTextField: UITextField!
    @IBOutlet private weak var durationTextField: UITextField!
    @IBOutlet private weak var startTimeLabel: UILabel!
    @IBOutlet private weak var registeredUsersLabel: UILabel!
    @IBOutlet private weak var intensitySegmentedControl: UISegmentedControl!
    @IBOutlet private weak var registerButton: UIButton!

    // MARK: - Properties
    var fitnessClass: FitnessClass?

    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        formatter.timeZone = TimeZone.autoupdatingCurrent
        return formatter
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
    }


    private func updateViews() {
        if let fitnessClass = fitnessClass {
            classNameTextField.text = fitnessClass.name
            classTypeTextField.text = fitnessClass.classType
            locationTextField.text = fitnessClass.location
            durationTextField.text = fitnessClass.duration
            startTimeLabel.text = fitnessClass.startTime
            registeredUsersLabel.text = "Regi"

            intensitySegmentedControl.selectedSegmentIndex = intensity(intensity: fitnessClass.intensity).rawValue
            // register button will change based on user
        }
    }

    private func intensity(intensity: Double) -> IntensityLevel {
        if intensity < 4 {
            return IntensityLevel.low
        } else if intensity > 3 && intensity < 7 {
            return IntensityLevel.medium
        } else {
            return IntensityLevel.high
        }
    }

    @IBAction func registerButtonTapped() {
        
    }

    func saveDateButtonWasPressed(date: Date) {
        startTimeLabel.text = dateFormatter.string(from: date)
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DatePickerSegue" {
            if let datePickerVC = segue.destination as? ClassDateViewController {
                datePickerVC.delegate = self
                datePickerVC.date = Date()
            }
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
}
