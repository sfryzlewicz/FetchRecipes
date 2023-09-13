//
//  ViewController.swift
//  FetchSomeRecipes
//
//  Created by Sara Fryzlewicz on 9/12/23.
//

import UIKit
import AlamofireImage

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //variables
    @IBOutlet weak var tableView: UITableView!
    
    var idMealArr = [[String:Any]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        
        let dessertUrl = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert")!
        let request = URLRequest(url: dessertUrl, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { [self] (data, response, error) in
             // This will run when the network request returns
             if let error = error {
                    print(error.localizedDescription)
             } else if let data = data {
                 let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                 //print(dataDictionary)
                 
                 self.idMealArr = dataDictionary["meals"] as! [[String:Any]]
                 
                 self.tableView.reloadData()
             }
        }
        task.resume()
    }
    
    //Recipes Table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return idMealArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell") as! RecipeCell
        
        let meals = idMealArr[indexPath.row]
        let mealStr = meals["strMeal"] as! String
        
        cell.titleLabel!.text = " " + mealStr + " "
        
        let imagePath = meals["strMealThumb"] as! String
        let imageURL = URL(string: imagePath)
        
        cell.foodView.af.setImage(withURL: imageURL!)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //find selected recipe
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)!
        let meals = idMealArr[indexPath.row]
        let id = meals["idMeal"] as! String
        let recipeIDURL=("https://www.themealdb.com/api/json/v1/1/lookup.php?i=" + id)
        
        //call to that recipe
        let recipeUrl = URL(string: recipeIDURL)!
        let request = URLRequest(url: recipeUrl, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
             // This will run when the network request returns
             if let error = error {
                    print(error.localizedDescription)
             } else if let data = data {
                 let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                 print(dataDictionary)
                 
                 let mealRecipeArr = dataDictionary["meals"] as! [[String:Any]]
                 
                 //self.tableView.reloadData()
             }
        }
        task.resume()
        
        //pass details to view controller
    }

}

