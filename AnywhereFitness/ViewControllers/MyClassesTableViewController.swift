//
//  MyClassesTableViewController.swift
//  AnywhereFitness
//
//  Created by Lambda_School_Loaner_204 on 1/7/20.
//  Copyright © 2020 Lambda_School_Loaner_219. All rights reserved.
//

import UIKit

class MyClassesTableViewController: UITableViewController {

    var userController: UserController?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView?.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }

    private func updateViews() {
        self.navigationItem.title = "Welcome \(userController?.getUser()?.username ?? "No User")!"
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userController?.getClassesAttending().count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyClassesCell", for: indexPath) as? ClassTableViewCell else { return UITableViewCell() }

        cell.fitnessClass = userController?.getClassAttending(indexPath.row)

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
            guard   let classSwipedToDelete = userController?.getClassesAttending()[indexPath.row] else {return}

            userController?.deleteClass(classSwipedToDelete)
            tableView.deleteRows(at:[indexPath], with: UITableView.RowAnimation.automatic)
            tableView.reloadData()
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
        if segue.identifier == "ShowMyClassDetailSegue" {
            if let indexPath = tableView.indexPathForSelectedRow,
                let classDetailVC = segue.destination as? ClassDetailViewController {
                classDetailVC.userController = self.userController
                classDetailVC.fitnessClass = self.userController?.getClassAttending(indexPath.row)
            }
        }
    }

}
