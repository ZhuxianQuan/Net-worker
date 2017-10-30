/*
 The MIT License (MIT)

 Copyright (c) 2015-present Badoo Trading Limited.

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
*/

import Foundation
import Chatto
import ChattoAdditions




extension TextMessageModel {
    static var chatItemType: ChatItemType {
        return "text"
    }
}

extension PhotoMessageModel {
    static var chatItemType: ChatItemType {
        return "photo"
    }
}



class MessageDataSource: ChatDataSourceProtocol {
    
    
    let preferredMaxWindowSize = 20
    
    var roomName : String!
    
    var slidingWindow: SlidingDataSource<ChatItemProtocol>!

    init(messages: [ChatItemProtocol], pageSize: Int) {
        self.slidingWindow = SlidingDataSource(items: messages, pageSize: pageSize)
    }
   

    lazy var messageSender: MessageSender = {
        let sender = MessageSender()
        sender.roomName = self.roomName
        sender.onMessageChanged = { [weak self] (message) in
            guard let sSelf = self else { return }
            sSelf.delegate?.chatDataSourceDidUpdate(sSelf)
        }
        return sender
    }()

    var hasMoreNext: Bool {
        return self.slidingWindow.hasMore()
    }

    var hasMorePrevious: Bool {
        return self.slidingWindow.hasPrevious()
    }

    var chatItems: [ChatItemProtocol] {
        return self.slidingWindow.itemsInWindow
    }

    weak var delegate: ChatDataSourceDelegateProtocol?

    func loadNext() {
        self.slidingWindow.loadNext()
        self.slidingWindow.adjustWindow(focusPosition: 1, maxWindowSize: self.preferredMaxWindowSize)
        self.delegate?.chatDataSourceDidUpdate(self, updateType: .pagination)
    }

    func loadPrevious() {
        self.slidingWindow.loadPrevious()
        self.slidingWindow.adjustWindow(focusPosition: 0, maxWindowSize: self.preferredMaxWindowSize)
        self.delegate?.chatDataSourceDidUpdate(self, updateType: .pagination)
    }

    func addTextMessage(_ text: String, isIncoming: Bool, status: MessageStatus) {
        let currentTime = Date()
        let uid = String(format: "%ld_%@", Int64(currentTime.timeIntervalSince1970 * 1000), messageSender.senderId)
        let messageModel = MessageModel(uid: uid, senderId: messageSender.senderId, type: "text", isIncoming: isIncoming, date: currentTime, status: status)
        let message = DemoTextMessageModel(messageModel: messageModel, text: text)
        self.messageSender.sendMessage(message)
        self.slidingWindow.insertItem(message, position: .bottom)
        self.delegate?.chatDataSourceDidUpdate(self)
    }
    
    func loadPrevMessages(_ messages: [DemoMessageModelProtocol]) {
        for message in messages.reversed() {
            self.slidingWindow.insertItem(message, position: .top)
        }
        self.delegate?.chatDataSourceDidUpdate(self, updateType: .pagination)
    }
    
    func loadFirstMessage(_ messages: [DemoMessageModelProtocol]) {
        for message in messages.reversed() {
            self.slidingWindow.insertItem(message, position: .top)
        }
        self.delegate?.chatDataSourceDidUpdate(self, updateType: .firstLoad)
    }
    
    func loadIncomingMessages(_ message: DemoMessageModelProtocol) {
        self.slidingWindow.insertItem(message, position: .bottom)
        self.delegate?.chatDataSourceDidUpdate(self)
        //self.slidingWindow.adjustWindow(focusPosition: 1, maxWindowSize: self.preferredMaxWindowSize)
        //self.delegate?.chatDataSourceDidUpdate(self, updateType: .pagination)
    }
    

    
    func adjustNumberOfMessages(preferredMaxCount: Int?, focusPosition: Double, completion:(_ didAdjust: Bool) -> Void) {
        let didAdjust = self.slidingWindow.adjustWindow(focusPosition: focusPosition, maxWindowSize: preferredMaxCount ?? self.preferredMaxWindowSize)
        completion(didAdjust)
    }
}
