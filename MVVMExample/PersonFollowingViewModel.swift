//
//  PersonFollowingViewModel.swift
//  MVVMExample
//
//  Created by Bikram Sapkota on 12/29/20.
//

import UIKit

struct PersonFollowingViewModel {
    let name:String
    let userName:String?
    let userImage:UIImage?
    var following:Bool
    let addr:String?
    
    init(with model:Person) {
        self.name = model.name
        self.userImage = UIImage(systemName: "person")
        self.following = false
        self.userName = model.userName
        self.addr = model.address
    }
}
