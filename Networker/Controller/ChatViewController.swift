//
//  ChatViewController.swift
//  Helperapp
//
//  Created by Quan Zhuxian on 09/13/17.
//  Copyright © 2017 shark. All rights reserved.
//

import UIKit
import ChattoAdditions
import Chatto

class ChatViewController: BaseChatViewController {
    
    
    var messageSender = MessageSender()
    var dataSource = MessageDataSource(messages: [], pageSize: 20)
    
    static var otherImage: UIImage?
    static var myImage: UIImage?
    var deal = DealModel()
    var other: UserModel {
        get {
            if deal.deal_worker.user_id == currentUser?.user_id {
                return deal.deal_client
            }
            else {
                return deal.deal_worker
            }
        }
    }
    
    var currentRoom: String {
        get {
            if let user = currentUser {
                if user.user_id > other.user_id {
                    return "\(other.user_id)_\(user.user_id)"
                }
                else {
                    return "\(user.user_id)_\(other.user_id)"
                }
            }
            return ""
        }
    }
    
    lazy private var baseMessageHandler: BaseMessageHandler = {
        return BaseMessageHandler(messageSender: self.messageSender)
    }()
    
    
    var allLoaded = false
    
    var isLoading = false
    
    var pendingMessages = [DemoMessageModelProtocol]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
         self.title = "Messages"
        if deal.deal_worker.user_id != 0 {
            messageSender.roomName = currentRoom
            self.chatDataSource = dataSource
            dataSource.roomName = currentRoom
            super.chatItemsDecorator = ChatItemsDemoDecorator()
            let addIncomingMessageButton = UIBarButtonItem(title: "Confirm", style: .done, target: self, action: #selector(gotoJobDetailPage))
            
            self.navigationItem.rightBarButtonItem = addIncomingMessageButton
            //let cancelButton =
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(gotoJobDetailPage))
           
            loadFirstMesssages()
            setMessageListener()
            NotificationCenter.default.addObserver(self, selector: #selector(gotMessage(_:)), name: NSNotification.Name(rawValue: "Message Received"), object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(processPendingMessages), name: NSNotification.Name(rawValue: "Loading Completed"), object: nil)
            
            let otherImageView = UIImageView()
            self.view.addSubview(otherImageView)
            let myImageView = UIImageView()
            self.view.addSubview(myImageView)
            if let user = currentUser {
                otherImageView.sd_setImage(with: URL(string: other.user_profileimageurl), completed: { (image, error, _, _) in
                    ChatViewController.otherImage = image
                })
                myImageView.sd_setImage(with: URL(string: user.user_profileimageurl), completed: { (image, error, _, _) in
                    ChatViewController.myImage = image
                })
                
            }
        }
        
    }
    
    func loadFirstMesssages() {
        self.showLoadingView()
        isLoading = true
        FirebaseUtils.readChatOnce(roomId: currentRoom, timestamp: Int64(Date().timeIntervalSince1970 * 1000) + 1) { (resultMessage, messages) in
            self.hideLoadingView()
            self.isLoading = false
            if resultMessage == "success" {
                self.dataSource.loadFirstMessage(messages)
                if messages.count < 20 {
                    self.allLoaded = true
                }
            }
            else {
                self.showToastWithDuration(string: resultMessage, duration: 3.0)
            }
        }
    }
    
    
    func setMessageListener() {
        FirebaseUtils.setObserver(roomId: currentRoom)
        
    }
    
    var chatInputPresenter: BasicChatInputBarPresenter!
    
    override func createChatInputView() -> UIView {
        let chatInputView = ChatInputBar.loadNib()
        var appearance = ChatInputBarAppearance()
        appearance.sendButtonAppearance.title = "Send"
        appearance.textInputAppearance.placeholderText = "Type a message"
        
        self.chatInputPresenter = BasicChatInputBarPresenter(chatInputBar: chatInputView, chatInputItems: self.createChatInputItems(), chatInputBarAppearance: appearance)
        chatInputView.maxCharactersCount = 1000
        return chatInputView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = false
    }
    
    
    override func createPresenterBuilders() -> [ChatItemType: [ChatItemPresenterBuilderProtocol]] {
        
        let textMessagePresenter = TextMessagePresenterBuilder(
            viewModelBuilder: DemoTextMessageViewModelBuilder(),
            interactionHandler: DemoTextMessageHandler(baseHandler: self.baseMessageHandler)
        )
        textMessagePresenter.baseMessageStyle = BaseMessageCollectionViewCellAvatarStyle()
        
        let photoMessagePresenter = PhotoMessagePresenterBuilder(
            viewModelBuilder: DemoPhotoMessageViewModelBuilder(),
            interactionHandler: DemoPhotoMessageHandler(baseHandler: self.baseMessageHandler)
        )
        photoMessagePresenter.baseCellStyle = BaseMessageCollectionViewCellAvatarStyle()
        
        return [
            DemoTextMessageModel.chatItemType: [
                textMessagePresenter
            ],
            DemoPhotoMessageModel.chatItemType: [
                photoMessagePresenter
            ],
            SendingStatusModel.chatItemType: [SendingStatusPresenterBuilder()],
            TimeSeparatorModel.chatItemType: [TimeSeparatorPresenterBuilder()]
        ]
    }
    
    func gotoJobDetailPage() {
        
    }
    
    func createChatInputItems() -> [ChatInputItemProtocol] {
        var items = [ChatInputItemProtocol]()
        items.append(self.createTextInputItem())
        //items.append(self.createPhotoInputItem())
        return items
    }
    
    private func createTextInputItem() -> TextChatInputItem {
        let item = TextChatInputItem()
        item.textInputHandler = { [weak self] text in
            self?.dataSource.addTextMessage(text, isIncoming: false, status: .sending)
        }
        return item
    }
    
    func gotMessage(_ notification: Notification) {
        if let object = notification.object {
            let message = object as! DemoMessageModelProtocol
            if self.dataSource.chatItems.count > 0 {
                if dataSource.chatItems[dataSource.chatItems.count - 1].uid == message.uid {
                    return
                }
            }
            if isLoading {
                self.pendingMessages.append(message)
            }
            else {
                self.dataSource.loadIncomingMessages(message)
            }
        }
    }
    
    func processPendingMessages() {
        for message in pendingMessages {
            self.dataSource.loadIncomingMessages(message)
        }
        pendingMessages = []
    }
    /*
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if (indexPath.row == 0 && !allLoaded) && !self.isLoading{
            loadPrevMesssages()
        }
    }*/
    
}


