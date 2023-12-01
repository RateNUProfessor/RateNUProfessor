//
//  SearchBottomSheetController.swift
//  RateNUProfessor
//
//  Created by 陈可轩 on 2023/11/28.
//

import UIKit

class SearchProfessorBottomSheetController: UIViewController {

    let searchSheet = SearchBottomSheetView()
    let notificationCenter = NotificationCenter.default
    
    //the list of names...
    var namesDatabase = [Professor]()
    
    //the array to display the table view...
    var namesForTableView = [Professor]()
    
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
extension SearchProfessorBottomSheetController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return namesForTableView.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: Configs.searchTableViewID, for: indexPath) as! SearchTableCell
        
        cell.labelTitle.text = namesForTableView[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //MARK: name selected....
        let selectedProfessor = namesForTableView[indexPath.row]
        notificationCenter.post(name: .professorSelected, object: selectedProfessor)
        //showProfessorCommentScreen(ProfessorSelected: namesForTableView[indexPath.row])
        //dismiss the bottom search sheet...
        self.dismiss(animated: true)
    }
    
//    func showProfessorCommentScreen(ProfessorSelected : Professor) {
//        // show corresponding Comment Page
//        let commentScreen = CommentScreenViewController()
//        navigationController?.pushViewController(commentScreen, animated: true)
//
//    }
}

//MARK: adopting the search bar protocol...
extension SearchProfessorBottomSheetController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == ""{
            namesForTableView = namesDatabase
        }else{
            self.namesForTableView.removeAll()

            for professor in namesDatabase{
                if professor.name.contains(searchText){
                    self.namesForTableView.append(professor)
                }
            }
        }
        self.searchSheet.tableViewSearchResults.reloadData()
    }
}
