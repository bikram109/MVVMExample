//
//  TableViewController.swift
//  MVVMExample
//
//  Created by Bikram Sapkota on 12/28/20.
//

import UIKit


class TableViewController: UITableViewController {

    var models = [Person]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(PersonFollowingCell.self, forCellReuseIdentifier: "person")
        configureModel()
    }
    
    private func configureModel(){
        let names = ["bik","ram","rina","Tina","bik2","ram","rina"]
        for name in names{
            models.append(Person(name: name,address: "U12 test Road",gender: Gender.male))
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "person") as? PersonFollowingCell else{
            return UITableViewCell()
        }
        
        cell.configure(with: PersonFollowingViewModel(with: model))
        cell.delegage = self
        return cell
    }

}
extension TableViewController:personFollowingCellDelegate{
    func personFollowingTableVieCell(_ cell: PersonFollowingCell, didtap viewModel: PersonFollowingViewModel) {
        if viewModel.following{
            print("user:\(viewModel.name) is following: \(viewModel.following)")
        }
    }
}
