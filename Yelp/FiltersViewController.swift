
//
//  FiltersViewController.swift
//  Yelp
//
//  Created by Apple on 2/20/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit
@objc protocol FiltersViewControllerDelegate {
    func filtersViewController(filtersViewController: FiltersViewController,didUpdateFilter filters:[String:AnyObject])
}
class FiltersViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,SwitchCellDelegate {

    var businesses: [Business]!
    weak var delegate: FiltersViewControllerDelegate?
    var switchStates = [Int:Bool]()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate=self
        tableView.dataSource=self
        self.tableView.reloadData()
        Business.searchWithTerm(term: "restaurant", completion: { (businesses: [Business]?, error: Error?) -> Void in
            self.businesses = businesses
            self.tableView.reloadData()
            if let businesses = businesses {
                for business in businesses {
                    print(business.categories!)
                }
            }
        }
        )

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func onCancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onSearchButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        var filters = [String: AnyObject]()
        delegate?.filtersViewController(filtersViewController: self, didUpdateFilter: filters)
        var selectedCategories = [String]()
        for (row,isSelected) in switchStates{
            if isSelected{selectedCategories.append(businesses[row].categories!)}
        }
        if selectedCategories.count > 0{
            filters["categories"] = selectedCategories as AnyObject?
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if businesses != nil{
            return businesses.count
        }
        else{
            return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SwitchCell", for: indexPath) as! SwitchCell
        cell.switchLabel.text = businesses[indexPath.row].categories as String!
        cell.delegate = self
        cell.onSwitch.isOn = switchStates[indexPath.row] ?? false
        return cell
    }
    
    func switchCell(switchCell: SwitchCell, didChangeValue value: Bool) {
        let indexPath = tableView.indexPath(for: switchCell)!
        switchStates[indexPath.row] = value
        print( "fiters got the switch event")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
