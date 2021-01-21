//
//  PersonFollowingViewModel.swift
//  MVVMExample
//
//  Created by Bikram Sapkota on 12/29/20.
//

import UIKit

/*
Always Make the viewmodel class type because we need it to be reference type, if any property get changed
 in any instance of view model we need it to be reflected in all instances.
 
 ViewModel only use the property which is needed. Model migh have too many properties it might need to represent json object.
*/

class PersonFollowingViewModel {
    let name:String
    let userName:String?
    let userImage:UIImage?
    var following:Bool

    init(with model:Person) {
        self.name = model.name
        self.userName = model.userName
        self.userImage = UIImage(systemName: "person")
        self.following = false
    }
}
