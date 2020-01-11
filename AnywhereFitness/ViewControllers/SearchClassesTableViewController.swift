//
//  SearchClassesTableViewController.swift
//  AnywhereFitness
//
//  Created by Lambda_School_Loaner_204 on 1/7/20.
//  Copyright © 2020 Lambda_School_Loaner_219. All rights reserved.
//

import UIKit

class SearchClassesTableViewController: UITableViewController {

    @IBOutlet private weak var addClassBarButtton: UIBarButtonItem!

    var userController: UserController?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView?.reloadData()
        self.tabBarController?.tabBar.isHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if isUserAnInstructor() {
            self.navigationItem.rightBarButtonItem = addClassBarButtton
        } else {
            self.navigationItem.rightBarButtonItem = nil
        }
    }

    private func isUserAnInstructor() -> Bool {
        guard let userController = userController,
            let user = userController.getUser(),
            let _ = user.isInstructor else { return false }
        return true
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userController?.getAllClasses().count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ClassCell", for: indexPath) as? ClassTableViewCell else { return UITableViewCell() }

        cell.fitnessClass = userController?.getClass(indexPath.row)

        return cell
    }


    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */

    
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
    
     }
     }
     

    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

     }
     */

    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let classDetailVC = segue.destination as? ClassDetailViewController {
            if segue.identifier == "ShowCreateClassSegue" {
                classDetailVC.userController = self.userController
            } else if segue.identifier == "ShowClassDetailSegue" {
                classDetailVC.userController = self.userController
                if let indexPath = tableView.indexPathForSelectedRow {
                    classDetailVC.fitnessClass = self.userController?.getClass(indexPath.row)
                }
            }
        }
    }


}
