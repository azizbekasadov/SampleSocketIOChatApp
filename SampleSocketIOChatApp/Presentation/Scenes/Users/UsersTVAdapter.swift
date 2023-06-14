//
//  UsersTVAdapter.swift
//  SampleSocketIOChatApp
//
//  Created by Azizbek Asadov on 14/06/23.
//

import UIKit

typealias Users = [[String: AnyObject]]

protocol UsersTVAdapter: AnyObject {
        
    init(tableView: UITableView)
}

final class UsersTVAdapterImpl: NSObject {
    
    // MARK: - Lifecycle
    
    init(tableView: UITableView) {
        self.tableView = tableView
        super.init()
        
        configure()
    }
    
    // MARK: - Private
    
    private let tableView: UITableView
    
    private var users: Users = []
    
    private func configure() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "UserCell", bundle: nil), forCellReuseIdentifier: "UserCell")
        tableView.isHidden = true
        tableView.tableFooterView = UIView(frame: CGRectZero)
    }
}

extension UsersTVAdapterImpl: UsersTVAdapter {
    
}

// MARK: - UITableViewDelegate

extension UsersTVAdapterImpl: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        return 50.0
    }
}

// MARK: - UITableViewDataSource

extension UsersTVAdapterImpl: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as! UserCell
        
        return cell
    }
}
