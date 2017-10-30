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

public protocol DemoMessageModelProtocol: MessageModelProtocol {
    var status: MessageStatus { get set }
}

public class MessageSender {
    
    var senderId: String {
        get {
            if let user = currentUser {
                return "\(user.user_id)"
            }
            return "0"
        }
    }
    
    var roomName: String!

    public var onMessageChanged: ((_ message: DemoMessageModelProtocol) -> Void)?
    

    public func sendMessage(_ message: DemoMessageModelProtocol) {
        //self.fakeMessageStatus(message)
        print("messages sent")
        
        if message.type == "text" {
            let textMessage = message as! DemoTextMessageModel
            var messageObject = [String: AnyObject]()
            messageObject["uid"] = textMessage.uid as AnyObject
            messageObject["text"] = textMessage.text as AnyObject
            messageObject["senderId"] = textMessage.senderId as AnyObject
            messageObject["type"] = textMessage.type as AnyObject
            messageObject["timestamp"] = Int64(textMessage.date.timeIntervalSince1970 * 1000) as AnyObject
            FirebaseUtils.sendMessage(messageObject, roomId: roomName, completion: { (resultMessage) in
                if resultMessage == Constants.PROCESS_SUCCESS {
                    self.updateMessage(message, status: .success)
                }
                else {
                    self.updateMessage(message, status: .failed)
                }
            })
            
        }
        self.updateMessage(message, status: .sending)
    }
    
    private func updateMessage(_ message: DemoMessageModelProtocol, status: MessageStatus) {
        if message.status != status {
            message.status = status
            self.notifyMessageChanged(message)
        }
    }

    private func notifyMessageChanged(_ message: DemoMessageModelProtocol) {
        self.onMessageChanged?(message)
    }
}
