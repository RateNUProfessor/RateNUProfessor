//
//  RateNUProfessor
//
//  Created by 陈可轩 on 2023/11/28.
//

import UIKit

class SearchCourseNumberBottomSheetController: UIViewController {

    let searchSheet = SearchBottomSheetView()
    let notificationCenter = NotificationCenter.default
    
    var namesDatabase = [Course]()
    var namesForTableView = [Course]()
    
    override func loadView() {
        view = searchSheet
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // update the names listed in the button sheet
        self.namesForTableView = namesDatabase
        self.searchSheet.tableViewSearchResults.reloadData()
        print(namesDatabase)
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //sorting the names list...
        //namesDatabase.sort()
        
        //setting up Table View data source and delegate...
        searchSheet.tableViewSearchResults.delegate = self
        searchSheet.tableViewSearchResults.dataSource = self
        
        // setting up Search Bar delegate...
        searchSheet.searchBar.delegate = self
        
        //initializing the array for the table view with all the names...
        namesForTableView = namesDatabase
    }
}

extension SearchCourseNumberBottomSheetController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return namesForTableView.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: Configs.searchTableViewID, for: indexPath) as! SearchTableCell
        
        cell.labelTitle.text = namesForTableView[indexPath.row].courseID
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCourse = self.namesForTableView[indexPath.row]
        notificationCenter.post(name: .courseNumberSelected, object: selectedCourse)
        dismiss(animated: true, completion: nil)
    }
}

extension SearchCourseNumberBottomSheetController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == ""{
            namesForTableView = namesDatabase
        }else{
            self.namesForTableView.removeAll()

            for course in namesDatabase{
                if course.courseID.contains(searchText){
                    self.namesForTableView.append(course)
                }
            }
        }
        self.searchSheet.tableViewSearchResults.reloadData()
    }
}
