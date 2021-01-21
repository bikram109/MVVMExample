//
//  TableViewController.swift
//  MVVMExample
//
//  Created by Bikram Sapkota on 12/28/20.
//

import UIKit


class ViewController: UIViewController,UITableViewDelegate, UISearchResultsUpdating {
   
    var tableView:UITableView = {
        let tableview = UITableView()
        return tableview
    }()
    
    enum Section {
        case first
    }
    
    var searchController = UISearchController(searchResultsController: nil)
    
    var dataSource:UITableViewDiffableDataSource<Section,Person>!
    var filteredModels = [Person]()
    var models = [Person]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(tableView)
        self.tableView.frame = self.view.bounds
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .done, target: self, action:#selector(addFollowingUser))
        
        
        tableView.delegate = self
        tableView.register(PersonFollowingCell.self, forCellReuseIdentifier: PersonFollowingCell.reuseIdentifier)
        
        dataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { (tableView, indexpath, model) -> PersonFollowingCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: PersonFollowingCell.reuseIdentifier) as! PersonFollowingCell
            cell.conguration(with: PersonFollowingViewModel(with: model))
            cell.delegage = self
            return cell
        })
        
        configureSearchController()
        getUsers()
        filteredModels = models
        updateDataSource()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
         filteredModels = filteredPerson(for: searchController.searchBar.text)
        updateDataSource()
    }
    
    func filteredPerson(for queryOrNil: String?) -> [Person] {
        let persons = models
      guard let query = queryOrNil, !query.isEmpty
        else {
          return persons
      }
      return persons.filter {
        let matches = $0.name.lowercased().contains(query.lowercased())
        return matches
      }
    }
    
    func configureSearchController() {
      searchController.searchResultsUpdater = self
      searchController.obscuresBackgroundDuringPresentation = false
      searchController.searchBar.placeholder = "Search users"
      navigationItem.searchController = searchController
      definesPresentationContext = true
    }
    
    @objc func addFollowingUser(){
        let alert = UIAlertController(title: "Add Following", message: nil, preferredStyle: .alert)
        alert.addTextField { (name) in
            name.placeholder = "name"
        }
        alert.addTextField { (userName) in
            userName.placeholder = "user name"
        }
        alert.addAction(UIAlertAction(title: "Submit", style: .default, handler: { _ in
            let nameTxt = alert.textFields![0] as UITextField
            let userTxt = alert.textFields![1] as UITextField
            guard let name = nameTxt.text, !name.isEmpty else{
                return
            }
            guard let userName = userTxt.text, !userName.isEmpty else{
                return
            }
            self.addFollowingPerson(with: name, userName: userName)
        }))
        present(alert, animated: true, completion: nil)
    }
    
    private func addFollowingPerson( with name:String, userName:String){
        let contains = models.contains{ $0.name == name }
        if contains{
            // user already added in list
            self.alreadyHas(person: Person(name: name, userName:userName ))
        }else{
            models.append(Person(name: name, userName: userName,address: "", gender: Gender.male))
            filteredModels = models
            self.updateDataSource()
        }
    }
    
    func alreadyHas(person:Person){
        let alert = UIAlertController(title: person.name, message: "Already exist in list!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    
    func updateDataSource()  {
        var snapShot = NSDiffableDataSourceSnapshot<Section,Person>()
        snapShot.appendSections([.first])
        snapShot.appendItems(filteredModels)
        dataSource.apply(snapShot)
    }
}

extension ViewController:personFollowingCellDelegate{
    func personFollowingTableVieCell(_ cell: PersonFollowingCell, didtap viewModel: PersonFollowingViewModel) {
        if viewModel.following{
            print("user:\(viewModel.name) is following: \(viewModel.following)")
        }
    }
}
extension ViewController:DataHandling{
    func getUsers() {
        let names = ["bik","ram","rina","Tina","bik2"]
        for name in names{
            models.append(Person(name: name, userName: name,address: "U12 test Road",gender: Gender.male))
        }
    }
}
