//
//  FirebaseRealTimeMessage.swift
//  FelineFitness
//
//  Created by Huijing on 08/12/2016.
//  Copyright © 2016 Huijing. All rights reserved.
//

import Foundation
import Firebase

import FirebaseDatabase
/*
class FirebaseRealTimeMessage{

    var ref: FIRDatabaseReference!
    // var refUser: FIRDatabaseReference!

    static var lastReadMessageid = ""
    var lastReadMessageNumber = 0

    var lastMessageTime: Int64 = 0

    var firstLoad = false




    func createCurrentReference(_ roomid: String)
    {
        messages = [];
        lastReadMessageNumber = 0
        lastMessageTime = 0
        firstLoad = true;
        ref = FIRDatabase.database().reference(withPath: Constants.FIR_MESSAGEROOM).child(roomid)

    }


    func parseReceivedMessage(_ snapshot: FIRDataSnapshot! )
    {
        if(snapshot != nil){
            let childref = snapshot.children.allObjects as? [FIRDataSnapshot]

            //NSLog("\(snapshot.value)")
            if((childref?.count)! > 0){

                //NSLog("current number - %d , maxnumber - %d", self.lastReadMessageNumber, childref?.count ?? 0)

                for i in 0..<(childref?.count)!
                {
                    self.lastReadMessageNumber += 1
                    let postDict = childref?[i].value as? NSDictionary

                    if (postDict != nil){
                        let message = MessageUtils.parseMessage(snapShotItem: postDict)
                        messageProcess(message: message)
                    }
                }
                
                
            }
        }
    }


    func messageProcess(message: MessageModel)
    {
        switch message.message_type {
        case Constants.IS_SYSTEMMESSAGE:
            break
        case Constants.IS_TEXTMESSAGE:
            if(Int64(message.message_time) > lastMessageTime){
                messages.append(message)
                lastMessageTime = Int64(message.message_time)

                if(!firstLoad){
                    NotificationCenter.default.post(name: Notification.Name(rawValue: Constants.STATUS_RECEIEVEDMESSAGE), object: nil)
                }

            }
            break
        case Constants.IS_IMAGEMESSAGE:
            if(Int64(message.message_time) > lastMessageTime){
                messages.append(message)
                lastMessageTime = Int64(message.message_time)

                NotificationCenter.default.post(name: Notification.Name(rawValue: Constants.STATUS_RECEIEVEDMESSAGE), object: nil)
            }
            break
        default:
            break
        }
    }

    func readChat(completion: @escaping (Bool, [MessageModel]) -> ()){
        /*ref.queryLimited(toLast: 20)*/
        ref.observeSingleEvent(of: .value, andPreviousSiblingKeyWith:  {
            snapshot, msg in
            self.parseReceivedMessage(snapshot)
            self.ref.queryLimited(toLast: 1).observe(.value, andPreviousSiblingKeyWith: {
                snapshot, msg in
                if(!self.firstLoad){
                    self.parseReceivedMessage(snapshot)
                }

                self.firstLoad = false

            }, withCancel: {
                error in
                print(error.localizedDescription)
                
            })

            completion(true, messages);

        }, withCancel: {
            error in
            print(error.localizedDescription)
            
        })
        
    }



    func sendMessage(_ message: MessageModel, completion:@escaping (Bool) -> ()){
        let post = MessageUtils.createMessageObject(message)
        ref.child(message.message_id).setValue(post, withCompletionBlock: {
            _,_ in
            completion(true)
        })
    }

}

var firebaseRealTimeMessageInstance = FirebaseRealTimeMessage()
var messages : [MessageModel] = [];*/
