//
//  SearchBottomSheetController.swift
//  RateNUProfessor
//
//  Created by 陈可轩 on 2023/11/28.
//

import UIKit

class SearchBottomSheetController: UIViewController {

    let searchSheet = SearchBottomSheetView()
    
    // identify search by professor or courseNumber
    var category = String()
    
    //MARK: the list of names...
    var namesDatabase = [String]()
    
    //MARK: the array to display the table view...
    var namesForTableView = [String]()
    
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
        
        //MARK: sorting the names list...
        namesDatabase.sort()
        
        //MARK: setting up Table View data source and delegate...
        searchSheet.tableViewSearchResults.delegate = self
        searchSheet.tableViewSearchResults.dataSource = self
        
        //MARK: setting up Search Bar delegate...
        searchSheet.searchBar.delegate = self
        
        //MARK: initializing the array for the table view with all the names...
        namesForTableView = namesDatabase
    }
}

//MARK: adopting Table View protocols...
extension SearchBottomSheetController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return namesForTableView.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: Configs.searchTableViewID, for: indexPath) as! SearchTableCell
        
        cell.labelTitle.text = namesForTableView[indexPath.row]
        return cell
    }
}

//MARK: adopting the search bar protocol...
extension SearchBottomSheetController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == ""{
            namesForTableView = namesDatabase
        }else{
            self.namesForTableView.removeAll()

            for name in namesDatabase{
                if name.contains(searchText){
                    self.namesForTableView.append(name)
                }
            }
        }
        self.searchSheet.tableViewSearchResults.reloadData()
    }
}
