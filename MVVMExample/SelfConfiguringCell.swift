//
//  SelfConfiguringCell.swift
//  MVVMExample
//
//  Created by Bikram Sapkota on 1/10/21.
//

import Foundation

/* Property and method to configure the cell*/
protocol SelfConfiguringCell{
    static var reuseIdentifier: String{get}
    func conguration(with viewModel:PersonFollowingViewModel)
}

/* Handle the data related task */
protocol DataHandling {
    func getUsers()
}
