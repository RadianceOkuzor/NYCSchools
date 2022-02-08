//
//  ListOfSchoolsTableVC.swift
//  20220127-RadianceOkuzor-NYCSchools
//
//  Created by Radiance Okuzor on 1/27/22.
//

import UIKit
import Cache

class ListOfSchoolsTableVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var filterView: UIStackView!
    @IBOutlet weak var aToZButton: UIButton!
    @IBOutlet weak var mathButtn: UIButton!
    @IBOutlet weak var readingButton: UIButton!
    @IBOutlet weak var writtingButton: UIButton!
    
    // filter buttons
   
    private var highSchoolViewModel : HighSchoolViewModel!
    var highschools:[Highschool] = [Highschool]() // collection of all the schools
    var tableHeader = ""
    var isConnected:Bool = true
    

    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        //Display a list of NYC Highscools
        self.title = "HOMIE Assessment"
        // check internet connectivity and based on that use the cache data or the backend data
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            self.isConnected = appDelegate.internetIsConnected
            if appDelegate.internetIsConnected {
                // we have wifi go ahead and hit the backed
                self.highSchoolViewModel = HighSchoolViewModel()
                callToViewModelForUIUpdate()
            } else {
                // no data use the cache
                print("pulling from cache data")
                self.highSchoolViewModel = HighSchoolViewModel()
                self.highschools =  self.highSchoolViewModel.cacheData()
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.activityIndicator.stopAnimating()
                }
            }
        } else {
            print("invalid delegate type")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableHeader = "NYC Schools A to Z"
    }
    
   // filter the list of highschools in alphabetical order
    @IBAction func aToZPressed(_ sender: UIButton) {
        activityIndicator.startAnimating()
        menuOpenClose()
        highschools = self.highSchoolViewModel.filterSchools(filter: "alphabetical")
        tableView.reloadData()
        tableHeader = "NYC Schools A to Z"
        activityIndicator.stopAnimating()
    }
    
    @IBAction func mathScorePressed(_ sender: UIButton) {
        // when pressed show from highest to lowest the math scores
        menuOpenClose()
        activityIndicator.startAnimating()
        // show list in high to low order and change label to low to high
        if sender.titleLabel?.text == "MATH SCORES ⇣" {
            sender.setTitle("MATH SCORES ⇡", for: .normal)
            highschools = self.highSchoolViewModel.filterSchools(filter: "mathHigh")
            tableView.reloadData()
            tableHeader = "NYC Schools Math Scores Highest to Lowest"
            activityIndicator.stopAnimating()
        } else {
            // show list in low to high order and change label to high to low
            sender.setTitle("MATH SCORES ⇣", for: .normal)
            highschools = self.highSchoolViewModel.filterSchools(filter: "mathLow")
            tableView.reloadData()
            tableHeader = "NYC Schools Math Scores Lowest to Highest"
            activityIndicator.stopAnimating()
        }
    }
    
    @IBAction func readingScorePressed(_ sender: UIButton) {
        menuOpenClose()
        activityIndicator.startAnimating()
        if sender.titleLabel?.text == "READING SCORES ⇣" {
            // show list in high to low order and change label to low to high
            sender.setTitle("READING SCORES ⇡", for: .normal)
            highschools = self.highSchoolViewModel.filterSchools(filter: "readingHigh")
            tableView.reloadData()
            tableHeader = "NYC Schools Reading Scores Highest to Lowest"
            activityIndicator.stopAnimating()
        } else {
            // show list in low to high order and change label to high to low
            sender.setTitle("READING SCORES ⇣", for: .normal)
            highschools = self.highSchoolViewModel.filterSchools(filter: "readingLow")
            tableView.reloadData()
            tableHeader = "NYC Schools Reading Scores Lowest to Highest"
            activityIndicator.stopAnimating()
        }
    }
    
    @IBAction func writingScorePressed(_ sender: UIButton) {
        menuOpenClose()
        activityIndicator.startAnimating()
        if sender.titleLabel?.text == "WRITING SCORES ⇣" {
            // show list in high to low order and change label to low to high
            sender.setTitle("WRITING SCORES ⇡", for: .normal)
            highschools = self.highSchoolViewModel.filterSchools(filter: "writtingHigh")
            tableView.reloadData()
            tableHeader = "NYC Schools Math Scores Highest to Lowest"
            activityIndicator.stopAnimating()
        } else {
            // show list in low to high order and change label to high to low
            sender.setTitle("WRITING SCORES ⇣", for: .normal)
            highschools = self.highSchoolViewModel.filterSchools(filter: "writtingLow")
            tableView.reloadData()
            tableHeader = "NYC Schools Math Scores Lowest to Highest"
            activityIndicator.stopAnimating()
        }
    }
    
    @IBAction func filterPressed(_ sender: UIButton) {
        menuOpenClose()
    }
    
    func menuOpenClose(){
        UIView.animate(withDuration: 0.2) {
            self.aToZButton.isHidden =  (self.aToZButton.isHidden) ? false : true
        }
        UIView.animate(withDuration: 0.2) {
            self.mathButtn.isHidden =  (self.mathButtn.isHidden) ? false : true
        }
        UIView.animate(withDuration: 0.2) {
            self.readingButton.isHidden =  (self.readingButton.isHidden) ? false : true
        }
        UIView.animate(withDuration: 0.2) {
            self.writtingButton.isHidden =  (self.writtingButton.isHidden) ? false : true
        }
    }
    
    func callToViewModelForUIUpdate(){
        // this is binded to viewmodel and is only triggered upon the completion of the data request from the server 
        self.highSchoolViewModel.bindHighSchoolViewModelToController = {self.updateDataSource()}
    }
    
    func updateDataSource(){
        highschools = self.highSchoolViewModel.highschoolData
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.activityIndicator.stopAnimating()
        }
    }

    // MARK: - Table view data source
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSchoolDetails" {
            if let vc = segue.destination as? SchoolDataVC {
                vc.highSchool = self.highschools[self.tableView.indexPathForSelectedRow?.row ?? 0]
            }
        }
    }

}

extension ListOfSchoolsTableVC {
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return highschools.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "schoolListCell", for: indexPath) as? SchoolNameTableViewCell else {
            return UITableViewCell()
        }

        // Configure the cell...
        cell.schoolNameLabel.text = highschools[indexPath.row].schoolName
        cell.cellNumber.text = String(indexPath.row+1)

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showSchoolDetails", sender: self)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tableHeader
    }
}
