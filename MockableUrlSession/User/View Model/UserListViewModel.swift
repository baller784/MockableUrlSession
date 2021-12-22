//
//  UserListViewModel.swift
//  MockableUrlSession
//
//  Created by Daniel Marcenco on 21.12.2021.
//

import Foundation

protocol UserListViewModelDelegate: AnyObject {
    func shouldReloadTableView()
}

final class UserListViewModel {
    private var networkManager: NetworkManager
    private var items: [UserListCellViewModel] = []

    weak var delegate: UserListViewModelDelegate?

    init(manager: NetworkManager = NetworkManager()) {
        self.networkManager = manager
        fetchUsers()
    }

    var numberOfItems: Int { items.count }

    func item(at index: Int) -> UserListCellViewModel { items[index] }

    func fetchUsers() {
        UserListLoader.fetchUsers(
            manager: networkManager,
            completion: { [weak self] users in
                let viewModels = users.compactMap { UserListCellViewModel(user: $0) }

                self?.items.append(contentsOf: viewModels)

                DispatchQueue.main.async {
                    self?.delegate?.shouldReloadTableView()
                }
            }
        )
    }
}
