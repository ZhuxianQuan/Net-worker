//
//  FirebaseUserAuthentication.swift
//  FelineFitness
//
//  Created by Huijing on 08/12/2016.
//  Copyright © 2016 Huijing. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseDatabase

/*

class FirebaseUserAuthentication{

    var friendRef : FIRDatabaseReference!
    var userRef : FIRDatabaseReference!

    var publicUserRef : FIRDatabaseReference!


    //Mark - init Class function : create user and friend references
    func initClass()
    {
        createUserReference(userid: currentUser.user_id)
        createMyFriendReference(userid: currentUser.user_id)
    }

    //create user info reference
    func createUserReference(userid: String){
        
        userRef = FIRDatabase.database().reference(withPath: Constants.FIR_USERINFODIRECTORY).child(userid).child(Constants.FIR_MYINFODIRECTORY)
    }

    //create friend info reference

    func createMyFriendReference(userid: String){
        friendRef = FIRDatabase.database().reference(withPath: Constants.FIR_USERINFODIRECTORY).child(userid).child(Constants.FIR_FRIENDDIRECTORY)

        friendRef.observe(FIRDataEventType.value, with: {
            (snapshot) in

            if snapshot.value == nil {
                return
            }
            self.parseFriendData(snapshot)

        })
    }

    // when user signout from device this function will appear
    func signOut(completion: @escaping (Bool) -> ())
    {
        let firebaseAuth = FIRAuth.auth()
        do {
            try firebaseAuth?.signOut()
            removeDevice(completion: {
                success in
                if success
                {
                    completion(true)
                }
                else
                {
                    completion(false)
                }
            })
        }
        catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
            completion(false)
        }
    }


    //user register function : this function add user and update user information
    func registerUserInfo(user: UserModel)
    {
        userRef.setValue(getUserInfoObject(user: user))
        if(UserDefaults.standard.value(forKey: Constants.DEVICE_TOKEN) != nil) {
            let token = (UserDefaults.standard.value(forKey: Constants.DEVICE_TOKEN))! as! String
            if (token.characters.count == 0){
                setUserDeviceStatus(userid: user.user_id, token: (UserDefaults.standard.value(forKey: Constants.DEVICE_TOKEN))! as! String, status: Constants.USER_DEVICE_ONLINE)
            }
        }
    }

    //this function will make user object from user model
    func getUserInfoObject(user: UserModel) -> [String : AnyObject]
    {
        return user.getInfoObject()
    }

    //this function will make friend object from friend model

    func getFriendInfoObject(friend: FriendModel) -> [String: AnyObject]{
        return friend.getInfoObject()
    }

    //this function make friend request from server
    func requestFriend(userid: String,friendStatus: Int, completion: @escaping (String) -> ())
    {
        var friend_status = 0
        var my_status = 0
        
        switch friendStatus {
        case Constants.FRIEND_EVENT_REQUEST:
            friend_status = Constants.FRIEND_RECEIVED
            my_status =  Constants.FRIEND_PENDING
            break
        case Constants.FRIEND_EVENT_ACCEPT:
            friend_status = Constants.FRIEND_FRIEND
            my_status = Constants.FRIEND_FRIEND
            break
        case Constants.FRIEND_EVENT_REMOVE:
            friend_status = Constants.FRIEND_REMOVED
            my_status = Constants.FRIEND_REMOVED
            break
        case Constants.FRIEND_EVENT_BLOCK:
            friend_status = Constants.FRIEND_BLOCKED
            my_status = Constants.FRIEND_BLOCK
            break
        default:
            break
        }
        
        
        
        let friendRequestRef = FIRDatabase.database().reference(withPath: Constants.FIR_USERINFODIRECTORY).child(userid).child(Constants.FIR_FRIENDDIRECTORY).child(currentUser.user_id)
        var friend = FriendModel()
        friend.friend_user.user_id = currentUser.user_id
        friend.friend_lastmessage = currentUser.user_name + " wants to add you to contacts"
        friend.friend_roomid = currentUser.user_id + userid
        friend.friend_status = friend_status
        friend.friend_lastmessagetime = getGlobalTime()
        friend.friend_unreadmessagecount = 1
        friendRequestRef.setValue(getFriendInfoObject(friend: friend), withCompletionBlock: {
            error , ref in
            if error != nil
            {
                completion(Constants.ERROR_FAIL_FRIENDREQUEST)
            }
            else
            {
                friend = FriendModel()

                friend.friend_user = FirebaseUserAuthentication.getUserFromUserid(userid)!
                friend.friend_lastmessage = "Already sent request"
                friend.friend_roomid = currentUser.user_id + userid
                friend.friend_status = my_status
                friend.friend_lastmessagetime = getGlobalTime()
                friend.friend_unreadmessagecount = 1

                self.friendRef.child(userid).setValue(self.getFriendInfoObject(friend: friend), withCompletionBlock: {
                    error , ref in

                    if error != nil{
                        completion(Constants.ERROR_FAIL_FRIENDREQUEST)
                    }
                    else
                    {

                        completion(Constants.SUCCESS_PROCESS)
                    }
                })

            }
        })
    }

    //function for remove friend from contacts
    func removeFriend(userid: String, completion: @escaping (String) ->())
    {
        

        let friendRequestRef = FIRDatabase.database().reference(withPath: Constants.FIR_USERINFODIRECTORY).child(userid).child(Constants.FIR_FRIENDDIRECTORY).child(currentUser.user_id)

        friendRequestRef.removeValue(completionBlock: { (error, refer) in
            if error != nil {
                print("\(error)")

                completion(Constants.ERROR_FAIL_REMOVEFROMCONTACTS)
            } else {
                print(refer)
                print("Child Removed Correctly")
                self.friendRef.child(userid).removeValue(completionBlock: { (error, refer) in
                    if error != nil {
                        print("\(error)")
                        completion(Constants.ERROR_FAIL_REMOVEFROMCONTACTS)
                    } else {
                        print(refer)
                        print("Child Removed Correctly")
                        var index = 0
                        for friend in myFriends{
                            if(friend.friend_user.user_id == userid){
                                myFriends.remove(at: index)
                            }
                            index += 1

                        }
                        completion(Constants.SUCCESS_PROCESS)
                    }
                })


            }
        })
    }


    //functions setting user device status
    func setUserDeviceStatus(userid: String, token: String, status: Int)
    {
        userRef.child(Constants.USER_DEVICES).child(token).setValue(status)
    }

    func removeDevice(completion: @escaping (Bool) -> ())
    {

        if UserDefaults.standard.value(forKey: Constants.DEVICE_TOKEN) != nil
        {
            let token = (UserDefaults.standard.value(forKey: Constants.DEVICE_TOKEN))! as! String
            self.userRef.child(Constants.USER_DEVICES).child(token).removeValue(completionBlock: {
                error, data in
                if(error != nil)
                {
                    completion(false)
                }
                else{
                    completion(true)
                }

            })
        }
        else{
            completion(true)
        }
    }


    //function parse friend data
    func parseFriendData(_ snapshot: FIRDataSnapshot!)
    {
        if(snapshot != nil){
            let childref = snapshot.children.allObjects as? [FIRDataSnapshot]
            if((childref?.count)! > 0){

                var friends :[FriendModel] = []
                for ref in childref!{
                    let postDict = ref.value as? NSDictionary
                    if(postDict != nil){
                        //NSLog("\(postDict)")
                        let friend = FriendModel()
                        friend.initClass(object: postDict as! [String: AnyObject])
                        friends.append(friend)
                    }
                    myFriends = CommonUtils.getSortedFriendArrayByTimes(friends: friends)
                }
            }
        }
    }

    func getOutFriends(friends: [FriendModel]) -> [FriendModel] {
        var result : [FriendModel] = []
        for friend in friends{
            if(friend.friend_user.user_outStatus){
                result.append(friend)
            }
        }
        return result
    }


    func readFriendOnce(completion:@escaping (Bool) -> ())
    {
        friendRef.observeSingleEvent(of: .value, with: {(snapshot) in

            self.parseFriendData(snapshot)
            completion(true)
        }) {
            (error) in
            print(error.localizedDescription)
            completion(false)
        }

    }
    
    /*

    func getFriendDeviceStatus(userid: String)
    {
        let curFriendRef = FIRDatabase.database().reference(withPath: Constants.FIR_USERINFODIRECTORY).child(userid).child(Constants.FIR_MYINFODIRECTORY).child(Constants.USER_DEVICES)
    }*/




    func isMyFriend(userid: String) -> Int
    {
        for friend in myFriends{
            if friend.friend_user.user_id == userid{
                return friend.friend_status
            }
        }
        return Constants.FRIEND_UNFRIEND
    }
    
  /*  func addMeAsFriend(userid: String) -> Int {
        
        
           
        
    }*/


    static func getUserFromUserid(_ id: String) -> UserModel?{
        for user in globalUsersArray{
            if(user.user_id == id)
            {
                return user

            }
        }
        return nil
    }


    static func createFIRUser(email: String, password: String, completion : @escaping (String, Bool) -> ())
    {
        //NSLog("email = %@ , password = %@", email, password)

        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: {
            (user, error) in

            if (error == nil){
                //NSLog("USER ==== %@", user!.uid as String!)

                let userid = user?.uid
                if userid!.characters.count > 0
                {
                    UserDefaults.standard.set(email, forKey: Constants.USER_EMAIL)
                    UserDefaults.standard.set(password, forKey: Constants.USER_PASSWORD)
                    UserDefaults.standard.set(userid, forKey: Constants.USER_ID)
                    completion(userid!, true)
                }
                else
                {
                    completion(userid!, false)
                }
            }
            else{
                completion("\(error?.localizedDescription)", false)
            }
        })
    }

    static func addUserProfileImage(userid: String, profileImage: UIImage?, completion: @escaping (String, Bool) -> ())
    {
        if(userid.characters.count > 0 && profileImage != nil)
        {
            FirebaseStorageUtils.uploadImage(toURL: Constants.FIR_STORAGE_USERPROFILEDIRECTORY,userid: userid, image: profileImage!, completion: {
                imageURL, success in
                if success{
                    completion(imageURL, true)
                }
                else{
                    completion(imageURL, false)
                }
            })
        }
        else{
            completion(Constants.ERROR_FAIL_PROFILEIMAGE, false)
        }
    }


    static func signUp(username: String, email: String, password: String, profileImage: UIImage?, firstName: String, lastName: String, phoneNumber: String, completion:@escaping (UserModel?, String) -> ())
    {
        createFIRUser(email: email, password: password, completion: {
            userid,success in

            if success{

                let user = UserModel()
                user.user_id = userid
                user.user_emailAddress = email
                user.user_password = password
                user.user_firstName = firstName
                user.user_lastName = lastName
                user.user_phonenumber = phoneNumber
                currentUser = user
                addUserProfileImage(userid: userid, profileImage: profileImage, completion: {imageURL, success in
                    if success{
                        user.user_name = username
                        user.user_imageUrl = imageURL
                        firebaseUserAuthInstance.createUserReference(userid: userid)
                        firebaseUserAuthInstance.registerUserInfo(user: user)
                        getAllUsers(completion: {
                            users in
                            globalUsersArray = CommonUtils.getSortedUserArrayByName(users: users)
                            completion(user, Constants.SUCCESS_PROCESS)
                        })
                    }
                    else
                    {
                        user.user_name = username
                        user.user_imageUrl = imageURL
                        firebaseUserAuthInstance.createUserReference(userid: userid)
                        firebaseUserAuthInstance.registerUserInfo(user: user)
                        completion(user, Constants.ERROR_FAIL_PROFILEIMAGE)
                    }
                })

            }
            else {
                completion(nil, Constants.ERROR_REGISTRATION_FAIL)
            }
        })
    }

    static func loginWithFacebook(user: UserModel, completion: @escaping(Bool) ->()){
        firebaseUserAuthInstance.createUserReference(userid: user.user_id)
        firebaseUserAuthInstance.registerUserInfo(user: user)
        getAllUsers(completion: {
            users in
            globalUsersArray = CommonUtils.getSortedUserArrayByName(users: users)
            completion(true)
        })

    }

    static func initUserInfo(userid: String, completion: @escaping(String, Bool) -> ()){
        getUserInfo(userid: userid, completion: {
            detailedUser in
            if (detailedUser != nil)
            {
                currentUser = detailedUser!
                getAllUsers(completion: {
                    users in

                    firebaseUserAuthInstance.initClass()
                    globalUsersArray = CommonUtils.getSortedUserArrayByName(users: users)
                    firebaseUserAuthInstance.readFriendOnce(completion:{
                        success in
                        if success  {
                            completion((detailedUser?.user_id)!, true)
                        }
                        else{
                            completion("", false)
                        }

                    })
                })


            }
            else{
                completion("", false)
            }
        })

    }

    static func signIn(email: String, password: String, completion: @escaping(String, Bool) -> ())
    {
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: {
            (user, error) in
            if error != nil{
                NSLog("\(error.debugDescription)")
                completion("", false)
            }
            else
            {
                UserDefaults.standard.set(email, forKey: Constants.USER_EMAIL)
                UserDefaults.standard.set(password, forKey: Constants.USER_PASSWORD)
                UserDefaults.standard.set((user?.uid)!, forKey: Constants.USER_ID)

                initUserInfo(userid: (user?.uid)!, completion: {
                    message, success in
                    completion(message,success)
                })
            }
        })
    }


    static func getAllUsers(completion: @escaping ([UserModel]) -> ())
    {
        FIRDatabase.database().reference(withPath: Constants.FIR_USERINFODIRECTORY).observeSingleEvent(of: .value, with: {(snapshot) in


            let childref = snapshot.children.allObjects as? [FIRDataSnapshot]

            //NSLog("\(snapshot)")

            if((childref?.count)! > 0){
                var users: [UserModel] = []

                for i in 0..<(childref?.count)!
                {
                    let postDict = childref?[i].value as? NSDictionary

                    let user = parseUser(snapShotItem: (postDict?[Constants.FIR_MYINFODIRECTORY] as? [String: AnyObject])!)
                    if(user.user_id != currentUser.user_id){
                        users.append(user)
                    }
                }

                completion(users)
            }
            else
            {
                completion([])
            }

        }) {
            (error) in
            print(error.localizedDescription)
            completion([])
        }
    }

    static func parseUser(snapShotItem: [String: AnyObject]) -> UserModel
    {
        let user = UserModel()
        user.initClass(object: snapShotItem)        
        return user

    }





    static func getUserInfo(userid: String, completion: @escaping (UserModel?) -> ()){

        FIRDatabase.database().reference(withPath: Constants.FIR_USERINFODIRECTORY).child(userid).child(Constants.FIR_MYINFODIRECTORY).observeSingleEvent(of: .value, with: {(snapshot) in

            //NSLog("\(snapshot)")
            let user = parseUser(snapShotItem: (snapshot.value as? [String: AnyObject])!)
            completion(user)
        }) {
            (error) in
            print(error.localizedDescription)
            completion(nil)
        }
    }

    func updateUserLocation(lat: Double, long: Double){
        userRef.child(Constants.USER_LATITUDE).setValue(lat)
        userRef.child(Constants.USER_LONGITUDE).setValue(long)
        userRef.child(Constants.USER_LOCATIONCHANGEDTIME).setValue(currentUser.user_locationChangedTime)
        userRef.child(Constants.USER_CURRENTLOCATIONNAME).setValue(currentUser.user_currentLocationName)
    }

    func updateUserInfo(user: UserModel){
        userRef.child(Constants.USER_OUTSTATUS).setValue(currentUser.user_outStatus)
        userRef.child(Constants.USER_MAPMESSAGE).setValue(currentUser.user_mapMessage)
    }


}

var firebaseUserAuthInstance = FirebaseUserAuthentication()*/
