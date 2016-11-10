//
//  MealsTableTableViewController.swift
//  MyFirstIOSApp
//
//  Created by jie on 2016/11/9.
//  Copyright © 2016年 jie. All rights reserved.
//

import UIKit

class MealsTableTableViewController: UITableViewController {
    
    var meals = [Meal]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        loadMeals()
        
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    func loadMeals(){
        let photo1 = UIImage(named: "meal1")
        let meal1 = Meal(name: "First", photo: photo1, rating: 3)!
    
        let photo2 = UIImage(named: "meal2")
        let meal2 = Meal(name: "Second", photo: photo2, rating: 4)!
        
        let photo3 = UIImage(named: "meal3")
        let meal3 = Meal(name: "Third", photo: photo3, rating: 1)!
        
        meals += [meal1,meal2,meal3]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return meals.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RatingCell", for: indexPath) as! MealTableViewCell
        let meal = meals[indexPath.row]
       
        // Configure the cell...
        cell.nameLabel.text = meal.name
        cell.photoImageView.image = meal.photo!
        cell.ratingControl.rating = meal.rating
        cell.ratingControl.isEnable = false
        return cell
    }
    

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    @IBAction func unwindToMealList(_ sender:UIStoryboardSegue){
        if let sourceViewController = sender.source as? MealViewController,let meal = sourceViewController.meal {
            if let selectedCellRow = tableView.indexPathForSelectedRow {
                meals[selectedCellRow.row] = meal
                tableView.reloadRows(at: [selectedCellRow], with: .none)
            }else{
                let newIndexPath = IndexPath(row: meals.count, section: 0)
                meals.append(meal)
                tableView.insertRows(at: [newIndexPath], with: .bottom)
            }
        }
    }

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            meals.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if "ShowDetail" == segue.identifier {
            let mealDetailViewController = segue.destination as! MealViewController
            if let selectedCell = sender as? MealTableViewCell{
                let indexPath = tableView.indexPath(for: selectedCell)!
                let meal = meals[(indexPath as NSIndexPath).row]
                mealDetailViewController.meal = meal
            }
        }
    }
 
    
}
