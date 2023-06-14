//
//  ChatInputViewAdapter.swift
//  SampleSocketIOChatApp
//
//  Created by Azizbek Asadov on 14/06/23.
//

import UIKit

protocol ChatInputViewAdapter: AnyObject {
    
    init(textView: UITextView)
}

final class ChatInputViewAdapterImpl: NSObject {
    
    // MARK: - Lifecycle
    
    init(textView: UITextView) {
        self.textView = textView
        super.init()
        
        self.textView.delegate = self
    }
    
    // MARK: - Private
    
    private let textView: UITextView
}

// MARK: - ChatInputViewAdapter

extension ChatInputViewAdapterImpl: ChatInputViewAdapter {}


// MARK: - UITextViewDelegate
extension ChatInputViewAdapterImpl: UITextViewDelegate {
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return true
    }
}
