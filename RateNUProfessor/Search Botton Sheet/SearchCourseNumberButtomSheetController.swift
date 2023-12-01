//
//  RateNUProfessor
//
//  Created by 陈可轩 on 2023/11/28.
//

import UIKit

class SearchCourseNumberBottomSheetController: UIViewController {

    let searchSheet = SearchBottomSheetView()
    let notificationCenter = NotificationCenter.default
    
    //MARK: the list of names...
    var namesDatabase = [Course]()
    
    //MARK: the array to display the table view...
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

//MARK: adopting Table View protocols...
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
        // course selected....
//        notificationCenter.post(name: .courseNumberSelected, object: namesForTableView[indexPath.row])
        // showSearchResultScreen(CourseNumber: namesForTableView[indexPath.row])
        //dismiss the bottom search sheet...
        
        let selectedCourse = self.namesForTableView[indexPath.row]
        notificationCenter.post(name: .courseNumberSelected, object: selectedCourse)
        dismiss(animated: true, completion: nil)
    }
    
    // TODO: 尚未完成，如果根据课号搜索，进入Search Result Screen, 列出所有教这个课的老师，再点击对应老师，进入Comment Screen
//    func showSearchResultScreen(CourseNumber : Course) {
//    }
}

//MARK: adopting the search bar protocol...
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
