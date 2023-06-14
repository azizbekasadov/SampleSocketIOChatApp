//
//  UsersViewController.swift
//  SampleSocketIOChatApp
//
//  Created by Azizbek Asadov on 14/06/23.
//

import UIKit

final class UsersViewController: UIViewController {
    
    // MARK: - Lifecycle
    
    var nickname: String!
    
    var configurationOK = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if !configurationOK {
            configureNavigationBar()
            configurationOK = true
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    func configureNavigationBar() {
        navigationItem.title = "SocketChat"
    }
    
    // MARK: - Private
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var joinChatButton: UIButton!
    
    private lazy var adapter: UsersTVAdapter = UsersTVAdapterImpl(tableView: tableView)
    
    @IBAction private func handleExitPressed(_ sender: Any) {
        
    }
}
