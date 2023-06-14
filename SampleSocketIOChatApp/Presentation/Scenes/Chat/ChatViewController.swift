//
//  ChatViewController.swift
//  SampleSocketIOChatApp
//
//  Created by Azizbek Asadov on 14/06/23.
//

import UIKit

typealias ChatMessage = [[String: AnyObject]]

protocol ChatDisplayLogic: AnyObject {
    func setNickName(_ name: String?)
    func didLoadMessages(_ messages: ChatMessage)
}

final class ChatViewController: UIViewController {
    
    // MARK: - Lifecycle
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    var nickname: String!
    
    var bannerLabelTimer: Timer!
    
    // MARK: - Internal
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureNewsBannerLabel()
//        configureOtherUserActivityLabel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupKeyboard()
        setupSwipeGesture()
    }
    
    // MARK: - Private
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var inputTextView: UITextView!
    @IBOutlet private weak var inputContainerView: UIView!
    @IBOutlet private weak var conBottomEditor: NSLayoutConstraint!
    @IBOutlet private weak var lblNewsBanner: UILabel!
    
    private lazy var adapter: ChatTVAdapter = ChatTVAdapterImpl(tableView: self.tableView)
    private lazy var inputAdapter: ChatInputViewAdapter = ChatInputViewAdapterImpl(textView: self.inputTextView)

    private func configureNewsBannerLabel() {
        lblNewsBanner.layer.cornerRadius = 15.0
        lblNewsBanner.clipsToBounds = true
        lblNewsBanner.alpha = 0.0
    }
    
    private func showBannerLabelAnimated() {
        UIView.animate(withDuration: 0.75, delay: 0, options: .curveEaseOut, animations: {
            self.lblNewsBanner.alpha = 1.0
        }) { isFinished in
            self.bannerLabelTimer = Timer(
                timeInterval: 2,
                target: self,
                selector: #selector(ChatViewController.hideBannerLabel),
                userInfo: nil,
                repeats: false
            )
        }
    }
    
    @objc
    private func hideBannerLabel() {
        if bannerLabelTimer != nil {
            bannerLabelTimer.invalidate()
            bannerLabelTimer = nil
        }
        
        UIView.animate(withDuration: 0.75, delay: 0) {
            self.lblNewsBanner.alpha = 0.0
        }
    }
}

// MARK: - Keyboard handler

extension ChatViewController {
    private func setupKeyboard() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleKeyboardDidShowNotification),
            name: UIResponder.keyboardDidShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleKeyboardDidHideNotification),
            name: UIResponder.keyboardDidHideNotification,
            object: nil
        )
    }
    
    @objc
    private func handleKeyboardDidShowNotification(notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            conBottomEditor.constant = keyboardHeight
            view.layoutIfNeeded()
        }
    }
    
    @objc
    private func handleKeyboardDidHideNotification(notification: NSNotification) {
        conBottomEditor.constant = 0
        view.layoutIfNeeded()
    }
    
    @objc
    private func dismissKeyboard() {
        if inputTextView.isFirstResponder {
            inputTextView.resignFirstResponder()
        }
    }
}

// MARK: - UIGestureRecognizerDelegate

extension ChatViewController: UIGestureRecognizerDelegate {
    private func setupSwipeGesture() {
        let swipeGestureRecognizer = UISwipeGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard)
        )
        swipeGestureRecognizer.direction = .down
        swipeGestureRecognizer.delegate = self
        view.addGestureRecognizer(swipeGestureRecognizer)
    }
    
    func gestureRecognizer(
        _ gestureRecognizer: UIGestureRecognizer,
        shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer
    ) -> Bool {
        return true
    }
    
}

