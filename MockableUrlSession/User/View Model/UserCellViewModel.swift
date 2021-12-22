//
//  UserCellViewModel.swift
//  MockableUrlSession
//
//  Created by Daniel Marcenco on 21.12.2021.
//

import Foundation

struct UserListCellViewModel {
    var name: String
    var description: String
    var profileImageUrl: URL

    init(user: User) {
        name = "\(user.name.first) \(user.name.last)"
        description = user.phone
        profileImageUrl = URL(string: user.picture.medium)!
    }
}
