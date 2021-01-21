//
//  Models.swift
//  MVVMExample
//
//  Created by Bikram Sapkota on 12/28/20.
//

import UIKit

enum Gender{
    case male, female, unspecified
}

struct Person:Hashable {
    let name:String
    let userName:String
    let address:String?
    let userImage:UIImage?
    let gender: Gender
    
    init(name:String,
         userName:String,
         address:String? = nil,
         userImage:UIImage? = nil,
         gender:Gender = Gender.unspecified) {
        self.name = name
        self.userName = userName
        self.address = address
        self.gender = gender
        self.userImage = UIImage(systemName: "person")
    }
}

