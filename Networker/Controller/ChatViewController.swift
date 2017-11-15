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
    
    var onlineHandle: UInt = 0
    var messageHandle: UInt = 0
    
    var pendingMessages = [DemoMessageModelProtocol]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.title = "Messages"
        messageSender.roomName = currentRoom
        self.chatDataSource = dataSource
        dataSource.roomName = currentRoom
        super.chatItemsDecorator = ChatItemsDemoDecorator()
        
        setNavRightButton()
            //let cancelButton =
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "icon_back"), style: .done, target: self, action: #selector(backButtonTapped))
                //UIBarButtonItem(title: "back", style: .done, target: self, action: #selector(backButtonTapped))
           
        loadFirstMesssages()
        setMessageListener()
        NotificationCenter.default.addObserver(self, selector: #selector(gotMessage(_:)), name: NSNotification.Name(rawValue: "Message Received"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(processPendingMessages), name: NSNotification.Name(rawValue: "Loading Completed"), object: nil)
        
        let otherImageView = UIImageView()
        self.view.addSubview(otherImageView)
        let myImageView = UIImageView()
        self.view.addSubview(myImageView)
        
        NotificationCenter.default.addObserver(self, selector: #selector(gotoOthersProfile), name: NSNotification.Name(rawValue: "AvartarTapped"), object: nil)
        if let user = currentUser {
            otherImageView.sd_setImage(with: URL(string: other.user_profileimageurl), completed: { (image, error, _, _) in
                ChatViewController.otherImage = image
            })
            myImageView.sd_setImage(with: URL(string: user.user_profileimageurl), completed: { (image, error, _, _) in
                ChatViewController.myImage = image
            })
            
        }
        
    }
    
    func gotoOthersProfile() {
        if deal.deal_client.user_id == other.user_id {
            if other.user_ratings.count == 0 {
                
                self.showLoadingView()
                
                ApiFunctions.getClientReviews(other.user_id, completion: { (message, avg_marks, ratings) in
                    self.hideLoadingView()
                    self.deal.deal_client.user_avgmarks = avg_marks
                    self.deal.deal_client.user_ratings = ratings
                    let userDetailVC = BaseViewController().getStoryboard(id: 6).instantiateViewController(withIdentifier: "ClientProfileViewController") as! ClientProfileViewController
                    userDetailVC.deal = self.deal
                    self.navigationController?.pushViewController(userDetailVC, animated: true)
                })
            }
            else {
                
                let userDetailVC = BaseViewController().getStoryboard(id: 6).instantiateViewController(withIdentifier: "ClientProfileViewController") as! ClientProfileViewController
                userDetailVC.deal = deal
                self.navigationController?.pushViewController(userDetailVC, animated: true)
                
            }
            
        }
        else {
            if other.user_ratings.count == 0 {
                self.showLoadingView()
                ApiFunctions.getWorkerReviews(other.user_id , completion: { (message, avg_marks, reviews, skill_marks) in
                    self.hideLoadingView()
                    for skill in self.deal.deal_worker.user_skill_array {
                        if let skill_mark = skill_marks[skill.skill_id] {
                            skill.skill_ratings = skill_mark
                        }
                    }
                    self.deal.deal_worker.user_ratings = reviews
                    self.deal.deal_worker.user_avgmarks = avg_marks
                    
                    let userDetailVC = BaseViewController().getStoryboard(id: 6).instantiateViewController(withIdentifier: "WorkerViewController") as! WorkerViewController
                    userDetailVC.deal = self.deal
                    self.navigationController?.pushViewController(userDetailVC, animated: true)
                })
            }
            else {
                let userDetailVC = BaseViewController().getStoryboard(id: 6).instantiateViewController(withIdentifier: "WorkerViewController") as! WorkerViewController
                userDetailVC.deal = self.deal
                self.navigationController?.pushViewController(userDetailVC, animated: true)
            }
        }
    }
    
    func setNavRightButton() {
        
        var addIncomingMessageButton = UIBarButtonItem()
        switch deal.deal_status {
        case 1:
            if deal.deal_client.user_id == currentUser?.user_id {
                addIncomingMessageButton = UIBarButtonItem(title: "Confirm", style: .done, target: self, action: #selector(gotoJobDetailPage))
                self.navigationItem.rightBarButtonItem = addIncomingMessageButton
            }
            else {
                addIncomingMessageButton = UIBarButtonItem(title: "Confirm", style: .done, target: self, action: #selector(gotoJobDetailPage))
            }
        case 2:
            addIncomingMessageButton = UIBarButtonItem(title: "Confirm", style: .done, target: self, action: #selector(gotoJobDetailPage))
        case 3:
            addIncomingMessageButton = UIBarButtonItem(title: "Confirm", style: .done, target: self, action: #selector(gotoJobDetailPage))
            break
        default:
            addIncomingMessageButton = UIBarButtonItem(title: "Confirm", style: .done, target: self, action: #selector(gotoJobDetailPage))
            break
        }
        
        
    }
    
    func backButtonTapped() {
        if self.tabBarController?.selectedIndex == 0 {
            self.navigationController?.popToRootViewController(animated: true)
            self.navigationController?.isNavigationBarHidden = true
        }
        else {
            self.navigationController?.popViewController(animated: true)
            self.navigationController?.isNavigationBarHidden = true
        }
        self.navigationController?.popViewController(animated: true)
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
    
    
    func loadPrevMesssages() {
        isLoading = true
        FirebaseUtils.readChatOnce(roomId: currentRoom, timestamp: Int64((chatDataSource?.chatItems[0] as! DemoMessageModelProtocol).date.timeIntervalSince1970 * 1000 - 1)) { (resultMessage, messages) in
            self.hideLoadingView()
            self.isLoading = false
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Loading Completed"), object: nil)
            if resultMessage == "success" {
                if messages.count < 20 {
                    self.allLoaded = true
                }
                self.dataSource.loadPrevMessages(messages)
            }
            else {
                self.showToastWithDuration(string: resultMessage, duration: 3.0)
            }
        }
    }
    
    func setMessageListener() {
        messageHandle = FirebaseUtils.setRoomObserver(roomId: currentRoom)
        onlineHandle = FirebaseUtils.setOnlineRef(userId: "\(other.user_id)")
        
    }
    
    deinit {
        FirebaseUtils.removeMessageHandler(messageHandle, roomId: currentRoom)
        FirebaseUtils.removeOnlineRef(onlineHandle, userId: "\(other.user_id)")
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
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
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
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if (indexPath.row == 0 && !allLoaded) && !self.isLoading{
            loadPrevMesssages()
        }
    }
    
}


