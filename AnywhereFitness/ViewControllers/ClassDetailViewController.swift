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
    @IBOutlet private weak var registeredUsersTextField: UITextField!
    @IBOutlet private weak var intensityPicker: UIPickerView!
    @IBOutlet private weak var registerButton: UIButton!
    @IBOutlet private weak var deleteClassButton: UIButton!
    @IBOutlet private weak var intensityLabel: UILabel!
    @IBOutlet private weak var saveBarButtonItem: UIBarButtonItem!

    // MARK: - Properties
    var userController: UserController?
    var fitnessClass: FitnessClassRepresentation?

    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
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
        if let fitnessClass = fitnessClass,
            let userController = userController,
            let user = userController.getUser(),
            let isInstructor = user.isInstructor {
            self.navigationItem.title = fitnessClass.name
            self.navigationItem.rightBarButtonItem = saveBarButtonItem
            classNameTextField.text = fitnessClass.name
            classTypeTextField.text = fitnessClass.type
            locationTextField.text = fitnessClass.location
            durationTextField.text = fitnessClass.duration
            startTimeLabel.text = fitnessClass.startTime
            registeredUsersTextField.text = String(fitnessClass.maxSize)
            registeredUsersLabel.text = "Class Size"
            print(fitnessClass.id)
            var intensity = abs(fitnessClass.intensity)
            if intensity > 10 {
                intensity = intensity / 10
            }
            intensityPicker.selectRow(intensity - 1, inComponent: 0, animated: false)
            intensityLabelView(intensity: Double(intensity))
            if !isInstructor {
                deleteClassButton.isHidden = true
                self.navigationItem.rightBarButtonItem = nil
            }
            registerButton.setTitle("Sign Up for Class!", for: .normal)

        } else {
            self.navigationItem.title = "Create a Class"
            self.navigationItem.rightBarButtonItem = nil
            intensityLabelView(intensity: 1)
            deleteClassButton.isHidden = true
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
        guard let userController = userController else { return }

        if let fitnessClass = fitnessClass {
            userController.joinAClass(fitnessClass)
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        } else {
            if let newFitnessClass = createClassFromFields() {
                userController.createFitnessClass(fitnessClass: newFitnessClass, completion: {
                    DispatchQueue.main.async {
                        self.navigationController?.popViewController(animated: true)
                    }
                })
            }
        }}

    @IBAction func deleteClassButtonTapped(sender: UIButton) {
        guard let userController = userController,
            let fitnessClass = fitnessClass else { return }
        userController.deleteClassFromServer(fitnessClass) { error in
            if let error = error {
                print(error)
            }
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }

    @IBAction func saveClassButtonTapped(sender: UIBarButtonItem) {
        guard let userController = userController,
            let newFitnessClass = createClassFromFields() else { return }

        fitnessClass = userController.updateClass(for: fitnessClass!, with: newFitnessClass)
        userController.updateServerClass(fitnessClass!, completion: { error in
            if let error = error {
                print(error)
            }
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        })
    }

    private func createClassFromFields() -> FitnessClass? {

        guard let classNameString = classNameTextField.text,
            !classNameString.isEmpty,
            let classTypeString = classTypeTextField.text,
            !classTypeString.isEmpty,
            let locationString = locationTextField.text,
            !locationString.isEmpty,
            let durationString = durationTextField.text,
            !durationString.isEmpty,
            let sizeString = registeredUsersTextField.text,
            !sizeString.isEmpty,
            let startTimeString = startTimeLabel.text else { return nil }

        let i = intensityPicker.selectedRow(inComponent: 0) + 1
        return FitnessClass(name: classNameString,
                            classType: classTypeString,
                            startTime: startTimeString,
                            duration: durationString,
                            intensity: Double(i) ,
                            location: locationString,
                            maxSize: Double(sizeString))
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

