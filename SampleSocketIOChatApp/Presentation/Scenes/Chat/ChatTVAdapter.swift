//
//  ChatTVAdapter.swift
//  SampleSocketIOChatApp
//
//  Created by Azizbek Asadov on 14/06/23.
//

import UIKit

protocol ChatTVAdapter: AnyObject {
    func set(_ messages: ChatMessage)
    func refresh()
    func scrollToBottom()
    
    init(tableView: UITableView)
}

//UITableViewDelegate, UITableViewDataSource
final class ChatTVAdapterImpl: NSObject {
    
    // MARK: - Lifecycle
    
    init(tableView: UITableView) {
        self.tableView = tableView
        super.init()
        
        configure()
    }
    
    // MARK: - Private
    
    private let tableView: UITableView
    
    private var chatMessages: ChatMessage = []
    
    private func configure() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "ChatCell", bundle: nil), forCellReuseIdentifier: "ChatCell")
        tableView.estimatedRowHeight = 90.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView(frame: .zero)
    }
}

// MARK: - ChatTVAdapter

extension ChatTVAdapterImpl: ChatTVAdapter {
    func set(_ messages: ChatMessage) {
        chatMessages = messages
        
        tableView.reloadData()
    }
    
    func refresh() {
        tableView.reloadData()
    }
    
    func scrollToBottom() {
        let delay = 0.1 * Double(NSEC_PER_SEC)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            if self.chatMessages.count > 0 {
                let lastRowIndexPath = IndexPath(row: self.chatMessages.count - 1, section: 0)
                self.tableView.scrollToRow(at: lastRowIndexPath, at: .bottom, animated: true)
            }
        }
    }
}

// MARK: - UITableViewDelegate

extension ChatTVAdapterImpl: UITableViewDelegate {
    
}

// MARK: - UITableViewDataSource

extension ChatTVAdapterImpl: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        chatMessages.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath)
        
        return cell
    }
}
