//
//  TableViewController.swift
//  MVVMExample
//
//  Created by Bikram Sapkota on 12/28/20.
//

import UIKit


class ViewController: UIViewController,UITableViewDelegate {


    var tableView:UITableView = {
        let tableview = UITableView()
        return tableview
    }()
    
    enum Section {
        case first
    }
    
    var dataSource:UITableViewDiffableDataSource<Section,Person>!
    var models = [Person]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(tableView)
        self.tableView.frame = self.view.bounds
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .done, target: self, action:#selector(addFollowingUser))
        tableView.delegate = self
        tableView.register(PersonFollowingCell.self, forCellReuseIdentifier: "person")
        
        dataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { (tableView, indexpath, model) -> PersonFollowingCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: "person") as! PersonFollowingCell
            cell.configure(with: PersonFollowingViewModel(with: model))
            cell.delegage = self
            return cell
        })
        
        configureModel()
        updateDataSource()
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
            let username = alert.textFields![1] as UITextField
            guard let name = nameTxt.text, !name.isEmpty else{
                return
            }
            self.addFollowing(personName: name)
        }))
        present(alert, animated: true, completion: nil)
    }
    private func addFollowing( personName:String){
        let contains = models.contains{ $0.name == personName }
        if contains{
            // already added in list
            self.alreadyHas(person: Person(name: personName))
        }else{
            models.append(Person(name: personName, address: "", userName: "", gender: Gender.male))
            self.updateDataSource()
        }
    }
    
    func alreadyHas(person:Person){
        let alert = UIAlertController(title: person.name, message: "Already exist in list!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func configureModel(){
        let names = ["bik","ram","rina","Tina","bik2"]
        for name in names{
            models.append(Person(name: name,address: "U12 test Road",gender: Gender.male))
        }
    }
    
    func updateDataSource()  {
        var snapShot = NSDiffableDataSourceSnapshot<Section,Person>()
        snapShot.appendSections([.first])
        snapShot.appendItems(models)
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
