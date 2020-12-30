//
//  ViewController.swift
//  MVVMExample
//
//  Created by Bikram Sapkota on 12/28/20.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {

    var models = [Person]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    private func configureModel(){
        let names = ["bik","ram","rina","Tina"]
        for name in names{
            models.append(Person(name: name))
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! UITableViewCell
        cell.textLabel?.text = model.name
        return cell
    }

}

struct Person {
    let name:String
}

