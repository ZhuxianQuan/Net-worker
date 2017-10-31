
import Foundation
import Firebase
import Chatto
import ChattoAdditions

class FirebaseUtils
{
    
    static let ref = Database.database().reference()
    
    static let CONTACT_REFERENCE            = "Contacts"
    static let MESSAGE_REFERENCE            = "Messages"
    static let USER_REFERENCE               = "Users"
    
    
    static let DATA_FROM_OBSERVER           = 1
    static let DATA_FROM_READDATA           = 2
    
    static var roomLoaded                   = false
    
    static var currentUserId : String {
        get{
            if let user = currentUser {
                return "\(user.user_id)"
            }
            return "0"
        }
    }

    static func sendMessage(_ messageObject: [String: AnyObject], roomId: String , completion: @escaping (String) -> ()) {
        var newObject = messageObject
        newObject["timestamp"] = ServerValue.timestamp() as AnyObject
        ref.child(MESSAGE_REFERENCE).child(roomId).childByAutoId().setValue(newObject) { (error, dataRef) in
            if let error = error {
                completion(error.localizedDescription)
            }
            else {
                completion(Constants.PROCESS_SUCCESS)
            }
            let userIds = roomId.components(separatedBy: "_")
            
            ref.child(CONTACT_REFERENCE).child(userIds[0]).child(userIds[1]).setValue(messageObject)
            ref.child(CONTACT_REFERENCE).child(userIds[1]).child(userIds[0]).setValue(messageObject)
            
        }
    }
    
    
    
    static func readChatOnce(roomId: String, timestamp: Int64, completion: @escaping (String, [DemoMessageModelProtocol]) -> ()) {
        ref.child(MESSAGE_REFERENCE).child(roomId).queryOrdered(byChild: "timestamp").queryEnding(atValue: timestamp).queryLimited(toLast: 20).observeSingleEvent(of: .value) { (snapshot, error) in
            if let error = error {
                completion(error, [])
            }
            else {
                //print(snapshot)
                let childref = snapshot.children.allObjects as? [DataSnapshot]
                if let childRef = childref {
                    var messages = [DemoMessageModelProtocol]()
                    for item in childRef {
                        messages.append(parseMessage(item.value as! NSDictionary))
                    }
                    completion(Constants.PROCESS_SUCCESS , messages)
                    
                }
                else {
                    completion(Constants.PROCESS_SUCCESS , [])
                }
                
            }
        }
    }
    
    static func setContactRef() {
        ref.child(CONTACT_REFERENCE).child(currentUserId).observe(.childChanged) { (snapshot, error) in
            if error != nil {
                
            }
            else {
                
            }
        }
    }
    
    static func removeMessageHandler(_ handler : UInt, roomId : String) {
        ref.child(MESSAGE_REFERENCE).child(roomId).removeObserver(withHandle: handler)
    }
    
    static func removeOnlineRef(_ handler: UInt, userId: String )
    {
        ref.child(USER_REFERENCE).child(userId).removeObserver(withHandle: handler)
    }
    
    static func setOnlineRef(userId: String) -> UInt {
        return ref.child(USER_REFERENCE).child(userId).child("connections").observe(.value, with: { (snapshot) in
            if snapshot.children.allObjects.count == 0 {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Online Changed"), object: false)
            }
            else {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Online Changed"), object: true)
            }
        })
    }
    
    static func setRoomObserver(roomId: String) -> UInt{
        
        roomLoaded = true
        return ref.child(MESSAGE_REFERENCE).child(roomId).queryLimited(toLast: 1).observe(.childAdded) { (snapshot, error) in
            //print(snapshot)
            let childref = snapshot.value as? NSDictionary
            if let childRef = childref {
                let message = parseMessage(childRef)
                if message.isIncoming && !roomLoaded{
                    /*if UIApplication.shared.applicationState == .background && message.type == "text"{
                    AppDelegate().dispatchNotif((message as! TextMessageModelProtocol).text)
                    }*/
                    print("message ==" + (message as! DemoTextMessageModel).text)
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Message Received"), object: message)
                }
                roomLoaded = false
            }
            else {
            }
            
        }
    }
    
    static func parseMessage(_ snapshot: NSDictionary) -> DemoMessageModelProtocol {
        var isIncoming: Bool {
            get {
                if snapshot["senderId"] as! String == currentUserId {
                    return false
                }
                return true
            }
        }
        let timestamp = (snapshot["timestamp"] as! Int64) / 1000
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let messageModel = MessageModel(uid: snapshot["uid"] as! String, senderId: snapshot["senderId"] as! String, type: snapshot["type"] as! String, isIncoming: isIncoming, date: date, status: .success)
        if messageModel.type == "text" {
            let message = DemoTextMessageModel(messageModel: messageModel, text: snapshot["text"] as! String)
            return message
        }
        else {
            let message = DemoTextMessageModel(messageModel: messageModel, text: snapshot["text"] as! String)
            return message
        }
        
    }

    
    static func setConnecttedRef() {
        
        // since I can connect from multiple devices, we store each connection instance separately
        // any time that connectionsRef's value is null (i.e. has no children) I am offline
        let myConnectionsRef = ref.child(USER_REFERENCE).child(currentUserId).child("connections")
        
        // stores the timestamp of my last disconnect (the last time I was seen online)
        let lastOnlineRef = ref.child(USER_REFERENCE).child(currentUserId).child("lastOnline")
        //let timeStampRef = ref.child(USER_REFERENCE).child(currentUserId).child("timestamp")
        
        let connectedRef = Database.database().reference(withPath: ".info/connected")
        
        connectedRef.observe(.value, with: { snapshot in
            // only handle connection established (or I've reconnected after a loss of connection)
            guard let connected = snapshot.value as? Bool, connected else { return }
            
            // add this device to my connections list
            let con = myConnectionsRef.childByAutoId()
            
            // when this device disconnects, remove it.
            con.onDisconnectRemoveValue()
            
            // The onDisconnect() call is before the call to set() itself. This is to avoid a race condition
            // where you set the user's presence to true and the client disconnects before the
            // onDisconnect() operation takes effect, leaving a ghost user.
            
            // this value could contain info about the device or a timestamp instead of just true
            con.setValue(true)
            lastOnlineRef.setValue(ServerValue.timestamp())
            
            // when I disconnect, update the last time I was seen online
            lastOnlineRef.onDisconnectSetValue(ServerValue.timestamp())
        })
    }
    
    
    
    
    
}
