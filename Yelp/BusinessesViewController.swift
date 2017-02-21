//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController,UITableViewDataSource,
UITableViewDelegate,UISearchBarDelegate/*FiltersViewControllerDelegate*/{
    
    var businesses: [Business]!
    var searchBusinesses: [Business]!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate=self
        tableView.dataSource=self
        searchBar.delegate = self
        self.navigationItem.titleView = searchBar
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableViewAutomaticDimension
        
        Business.searchWithTerm(term: "restaurant", completion: { (businesses: [Business]?, error: Error?) -> Void in
            
            self.businesses = businesses
            self.searchBusinesses = self.businesses
            self.tableView.reloadData()
            if let businesses = businesses {
                for business in businesses {
                    print(business.name!)
                    print(business.address!)
                }
            }
            
            }
        )

        /* Example of Yelp search with more search options specified
         Business.searchWithTerm("Restaurants", sort: .Distance, categories: ["asianfusion", "burgers"], deals: true) { (businesses: [Business]!, error: NSError!) -> Void in
         self.businesses = businesses
         
         for business in businesses {
         print(business.name!)
         print(business.address!)
         }
         }
         */
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       /* if businesses != nil{
        return businesses!.count
        }
        else{
        return 0
        }*/
        if let searchBusinesses = searchBusinesses{
            return searchBusinesses.count
        }
        else{
            return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusninessCell", for: indexPath) as! BusninessCell
    //cell.business = businesses[indexPath.row]
    cell.business = searchBusinesses[indexPath.row]
    return cell
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchBusinesses = searchText.isEmpty ? self.businesses : self.businesses.filter({ (bussiness) -> Bool in
            return bussiness.name?.hasPrefix(searchText) ?? true
        })
        self.tableView.reloadData()
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
        viewDidLoad()
    }
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
    /* override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let navigationController = segue.destination.topLayoutGuide as! FiltersViewController
        let filtersViewController = navigationController.topLayoutGuide as! FiltersViewController
        filtersViewController.delegate = self
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
    func filtersViewController(filtersViewController: FiltersViewController, didUpdateFilter filters: [String : AnyObject]) {
        var categories = filters["categories"] as! [String]
        Business.searchWithTerm(term: "restaurant", completion: { (businesses: [Business]?, error: Error?) -> Void in
            self.businesses = businesses
            self.tableView.reloadData()
        
        }
        )

    }*/
    
}
