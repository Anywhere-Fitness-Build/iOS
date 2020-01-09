//
//  ClassDetailViewController.swift
//  AnywhereFitness
//
//  Created by Lambda_School_Loaner_204 on 1/7/20.
//  Copyright © 2020 Lambda_School_Loaner_219. All rights reserved.
//

import UIKit

enum IntensityLevel: String {
    case low = "Low"
    case medium = "Medium"
    case high = "High"
}

class ClassDetailViewController: UIViewController, ClassDateViewControllerDelegate {

    // MARK: - IBOutlets
    @IBOutlet private weak var classNameTextField: UITextField!
    @IBOutlet private weak var classTypeTextField: UITextField!
    @IBOutlet private weak var locationTextField: UITextField!
    @IBOutlet private weak var durationTextField: UITextField!
    @IBOutlet private weak var startTimeLabel: UILabel!
    @IBOutlet private weak var registeredUsersLabel: UILabel!
    @IBOutlet private weak var intensityPicker: UIPickerView!
    @IBOutlet private weak var registerButton: UIButton!
    @IBOutlet private weak var intensityLabel: UILabel!

    // MARK: - Properties
    var fitnessClass: FitnessClass?

    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, h:mm a"
        formatter.timeZone = TimeZone.autoupdatingCurrent
        return formatter
    }

    let intensityPickerList = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]

    override func viewDidLoad() {
        super.viewDidLoad()

        intensityPicker.dataSource = self
        intensityPicker.delegate = self

        updateViews()
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
            intensityPicker.selectedRow(inComponent: Int(fitnessClass.intensity))
            intensityLabelView(intensity: fitnessClass.intensity)
            // register button will change based on user
        }


    }

    private func intensityLabelView(intensity: Double) {
        if intensity < 3 {
            intensityLabel.text = IntensityLevel.low.rawValue
            intensityLabel.textColor = UIColor.green
        } else if intensity > 2 && intensity < 7 {
            intensityLabel.text = IntensityLevel.medium.rawValue
            intensityLabel.textColor = UIColor.orange
        } else {
            intensityLabel.text = IntensityLevel.high.rawValue
            intensityLabel.textColor = UIColor.red
        }
    }

    @IBAction func registerButtonTapped() {
        guard let classNameString = classNameTextField.text,
            !classNameString.isEmpty,
            let classTypeString = classTypeTextField.text,
            !classTypeString.isEmpty,
            let locationString = locationTextField.text,
            !locationString.isEmpty,
            let durationString = durationTextField.text,
            !durationString.isEmpty,
            let startTimeString = startTimeLabel.text else { return }



        let _ = FitnessClass(name: classNameString,
                             classType: classTypeString,
                             startTime: startTimeString,
                             duration: durationString,
                             intensity: Double(intensityPicker.selectedRow(inComponent: 1)),
                             location: locationString)

        self.navigationController?.popViewController(animated: true)

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
    }
}

extension ClassDetailViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return intensityPickerList.count
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        intensityLabelView(intensity: Double(row))
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return intensityPickerList[row]
    }
}
