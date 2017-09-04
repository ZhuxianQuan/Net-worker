//
//  ApiFunctions.swift
//  Networker
//
//  Created by Big Shark on 13/03/2017.
//  Copyright © 2017 shark. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ApiFunctions{    
    
    static let SERVER_BASE_URL          = "http://35.167.68.193"
    
    //static let SERVER_BASE_URL          = "http://192.168.1.120:2000/Networker"
    static let SERVER_URL                = SERVER_BASE_URL + "/index.php/Api/"
    
    static let REQ_GET_ALLSKILLS        = SERVER_URL + "getSkills"
    static let REQ_REGISTER             = SERVER_URL + "registerUser"
    static let REQ_UPLOADIMAGE          = SERVER_URL + "uploadImage"
    static let REQ_UPDATEUSER           = SERVER_URL + "updateUser"
    static let REQ_ADDUSERSKILL         = SERVER_URL + "addUserSkill"
    static let REQ_LOGIN                = SERVER_URL + "login"
    static let REQ_GETSKILLVERSION      = SERVER_URL + "getSkillVersion"
    static let REQ_UPLOADPOSITION       = SERVER_URL + "uploadPosition"
    static let REQ_SAVESCHEDULE         = SERVER_URL + "saveUserSchedule"
    static let REQ_SAVESCHEDULES        = SERVER_URL + "saveUserSchedules"
    static let REQ_SEARCHUSERS          = SERVER_URL + "searchMatchedUsers"
    static let REQ_GETNEARBYWORKERS     = SERVER_URL + "getNearByWorkers"
    
    
    static func login(email: String, password: String, completion: @escaping (String) -> () ){
        var token = ""
        if let tokenObject = UserDefaults.standard.value(forKey: Constants.KEY_USER_TOKEN) {
            token = tokenObject as! String
        }
        
        //currentUser = ParseHelper.parseUser(JSON(TestJson.getMe()))
        let params = [Constants.KEY_USER_EMAIL: email,
                      Constants.KEY_USER_PASSWORD: password,
                      Constants.KEY_USER_TOKEN : token]
        Alamofire.request(REQ_LOGIN, method: .post, parameters: params).responseJSON { response in
            if response.result.isFailure{
                completion(Constants.CHECK_NETWORK_ERROR)
            }
            else
            {
                let json = JSON(response.result.value!)
                let message = json[Constants.RES_MESSAGE].stringValue
                if message == Constants.PROCESS_SUCCESS {
                    currentUser = ParseHelper.parseUser(json[Constants.RES_USER_INFO])
                    for scheduleObject in json[Constants.KEY_USER_SCHEDULES].arrayValue {
                        currentUser?.user_schedules.append(ParseHelper.parseSchedule(scheduleObject))
                    }
                    completion(Constants.PROCESS_SUCCESS)
                }
                else {
                    completion(message)
                }
            }
        }
    }
    
    static func register(_ user: UserModel, completion: @escaping (String) -> ()){
        let userObject = user.getUserObject()
        Alamofire.request(REQ_REGISTER, method: .post, parameters: userObject).responseJSON { response in
            if response.result.isFailure{
                completion(Constants.CHECK_NETWORK_ERROR)
            }
            else
            {
                let json = JSON(response.result.value!)
                let message = json[Constants.RES_MESSAGE].stringValue
                if message == Constants.PROCESS_SUCCESS {
                    user.user_id = json[Constants.KEY_USER_ID].nonNullInt64Value
                    currentUser = user
                    completion(Constants.PROCESS_SUCCESS)
                }
                else {
                    completion(message)
                }
            }
        }
    }
    
    static func passwordChangeRequest(email: String){
        
    }
    
    static func getUsers(available: Bool) {
        
    }
    
    static func advancedSearch(){
        
    }
    
    static func getSkillsArray(completion : @escaping (String) -> ()){
        
        getSkillVersion(completion: {
            message, version in
            if message == Constants.PROCESS_SUCCESS {
                if let skill_version = UserDefaults.standard.value(forKey: "skill_version"){
                    if (skill_version as! Int) < version {
                        
                        getSkills(version, completion: {
                            message in
                            completion(message)
                        })
                    }
                    else {
                        completion(Constants.PROCESS_SUCCESS)
                    }
                    
                }
                else {
                    getSkills(version, completion: {
                        message in
                        completion(message)
                    })
                }
                
                
                
            }
            else {
                completion(message)
            }
        })
        
        
        
    }
    
    static func getSkills(_ version: Int, completion: @escaping (String) -> ()) {
        
        Alamofire.request(REQ_GET_ALLSKILLS, method: .post, parameters: nil).responseJSON { response in
            if response.result.isFailure{
                completion(Constants.CHECK_NETWORK_ERROR)
            }
            else
            {
                var json = JSON(response.result.value!)
                let message = json["message"].nonNullStringValue
                if message == Constants.PROCESS_SUCCESS {
                    json = json["result"]
                    fmdbManager.emptyTables()
                    fmdbManager.createTables()
                    let localDataSet = FMDBManagerSetData()
                    let categoryObject = json["category"].arrayValue
                    localDataSet.saveCategories(categoryObject)
                    let skillObject = json["skill"].arrayValue
                    localDataSet.saveSkills(skillObject)
                    let skillTagObject = json["skill_tag"].arrayValue
                    localDataSet.saveSkill_Tags(skillTagObject)
                    let tagObject = json["tag"].arrayValue
                    localDataSet.saveTags(tagObject)
                    
                    UserDefaults.standard.set(version, forKey: "skill_version")
                    completion(Constants.PROCESS_SUCCESS)
                }
                else {
                    completion(message)
                }
                
            }
        }
    }
    
    static func getSkillVersion(completion: @escaping (String, Int) -> ()){
        Alamofire.request(REQ_GETSKILLVERSION).responseJSON { response in
            if response.result.isFailure{
                completion(Constants.CHECK_NETWORK_ERROR, 0)
            }
            else
            {
                var json = JSON(response.result.value!)
                let message = json["message"].nonNullStringValue
                if message == Constants.PROCESS_SUCCESS {
                    let skill_version = json["result"].nonNullIntValue
                    completion(Constants.PROCESS_SUCCESS, skill_version)
                }
                else {
                    completion(message, 0)
                }
                
            }
        }
    }
    
    static func getNameMatchedUsers(keyword: String, from preDefinedUsers: [UserModel], completion : @escaping (String, [UserModel]) -> ()){
        
        var users : [UserModel] = []
        if keyword.characters.count > 0{
            for user in preDefinedUsers {
                if(user.user_firstname + " " + user.user_lastname).lowercased().contains(keyword.lowercased()){
                    users.append(user)
                }
            }
        }
        else{
            users = preDefinedUsers
        }
        completion(Constants.PROCESS_SUCCESS, users)
    }
    
    
    static func uploadImage(name: String, imageData: Data, completion: @escaping (String, String) -> ()) {
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(imageData, withName: "image", fileName: "test.jpg", mimeType: "image/jpg")                //multipartFormData.boundary
                multipartFormData.append(name.data(using: String.Encoding.utf8, allowLossyConversion: false)!, withName: "image_name")
        },
            to: REQ_UPLOADIMAGE,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        
                        switch response.result {
                            
                        case .success(_):
                            let json = JSON(response.result.value!)
                            let message = json[Constants.RES_MESSAGE].stringValue
                            if message == Constants.PROCESS_SUCCESS {
                                let imageurl = json[Constants.KEY_IMAGEURL].stringValue
                                CommonUtils.saveImageToLocal(name, data: imageData)
                                completion(message, imageurl)
                            }
                            else {
                                completion(message, "")
                            }
                            
                        case .failure(_):
                            
                            completion(Constants.CHECK_NETWORK_ERROR, "")
                            
                        }
                    }
                    
                case .failure(_):
                    completion(Constants.CHECK_ENCODING_ERROR, "")
                }
        })
    }
    
    //MARK -- File Download function
    static func downloadFile(urlString: String,completion: @escaping (String, URL?) -> ()){
        
        let filenames = urlString.components(separatedBy: "/")
        let filename = filenames[filenames.count - 1]
        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
            var documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            documentsURL.appendPathComponent(filename)
            return (documentsURL, [.removePreviousFile])
        }
        
        Alamofire.download(urlString, to: destination).responseData { response in
            if let destinationUrl = response.destinationURL {
                
                completion(Constants.PROCESS_SUCCESS, destinationUrl)
            }
            else {
                completion(Constants.PROCESS_FAIL, nil)
            }
        }
    }
    
    static func loginWithFacebook(user: UserModel, completion: @escaping (String) -> ()) {
        
    }
    
    static func updateProfile(profile: [String: AnyObject], completion: @escaping (String) -> ()) {
        
        Alamofire.request(REQ_UPDATEUSER, method: .post, parameters: profile).responseJSON { response in
            if response.result.isFailure{
                completion(Constants.CHECK_NETWORK_ERROR)
            }
            else
            {
                let json = JSON(response.result.value!)
                let message = json[Constants.RES_MESSAGE].stringValue
                completion(message)
            }
        }
    }
    
    static func uploadPosition(completion: @escaping (String) -> ()) {
        let params = ["user_latitude" : currentLatitude as AnyObject,
                      "user_longitude" : currentLongitude as AnyObject,
                      "user_id" : currentUser!.user_id as AnyObject,
                      "user_available" : currentUser!.user_available as AnyObject]
        Alamofire.request(REQ_UPLOADPOSITION, method: .post, parameters: params).responseJSON { response in
            if response.result.isFailure{
                completion(Constants.CHECK_NETWORK_ERROR)
            }
            else
            {
                let json = JSON(response.result.value!)
                let message = json[Constants.RES_MESSAGE].stringValue
                completion(message)
            }
        }
    }
    /*
    static func saveUserSchedule(_ schedule: DayScheduleModel, completion: @escaping (String, DayScheduleModel?) -> ()) {
        Alamofire.request(REQ_SAVESCHEDULE, method: .post, parameters: schedule.getObject()).responseJSON { response in
            if response.result.isFailure{
                completion(Constants.CHECK_NETWORK_ERROR, nil)
            }
            else
            {
                let json = JSON(response.result.value!)
                let message = json[Constants.RES_MESSAGE].stringValue
                schedule.schedule_id = json[Constants.KEY_SCHEDULE_ID].nonNullIntValue
                completion(message, schedule)
            }
        }
        
    }*/
    
    static func saveChangedUserSchedule(_ schedules: [DayScheduleModel], completion: @escaping (String) -> ()) {
        var scheduleArray = [String: AnyObject]()
        var objects = [AnyObject]()
        for schedule in schedules {
            objects.append(schedule.getObject() as AnyObject)
        }
        scheduleArray["schedules"] = objects as AnyObject
        scheduleArray["user_id"] = currentUser!.user_id as AnyObject
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: scheduleArray, options: .prettyPrinted)
            var request = URLRequest(url: URL(string: REQ_SAVESCHEDULES)!)
            request.httpBody = jsonData
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")

            Alamofire.request(request).responseJSON { response in
                if response.result.isFailure{
                    completion(Constants.CHECK_NETWORK_ERROR)
                }
                else
                {
                    let json = JSON(response.result.value!)
                    let message = json[Constants.RES_MESSAGE].nonNullStringValue
                    if message == Constants.PROCESS_SUCCESS {
                        var schedules = [DayScheduleModel]()
                        for scheduleObject in json[Constants.KEY_USER_SCHEDULES].arrayValue {
                            schedules.append(ParseHelper.parseSchedule(scheduleObject))
                        }
                        currentUser?.user_schedules = schedules
                        completion(message)
                    }
                    else {
                        completion(message)
                    }
                    
                }
            }
        }
        catch {
            completion(Constants.PROCESS_FAIL)
        }
    }
    
    static func getSkillMatchedUsers(_ skill_id: Int, filter: String, day: Int, time: Int, index: Int, completion: @escaping (String, [UserModel]) -> ()) {
        let params = [Constants.KEY_SKILL_ID: skill_id as AnyObject,
                      "filter" : filter as AnyObject,
                      "day": day as AnyObject,
                      "time" : time as AnyObject,
                      "index": index as AnyObject,
                      "latitude" : currentLatitude as AnyObject,
                      "longitude" : currentLongitude as AnyObject,
                      Constants.KEY_USER_ID : currentUser!.user_id as AnyObject
        ]
        Alamofire.request(REQ_SEARCHUSERS, method: .post, parameters: params).responseJSON { response in
            if response.result.isFailure{
                completion(Constants.CHECK_NETWORK_ERROR, [])
            }
            else
            {
                let json = JSON(response.result.value!)
                let message = json[Constants.RES_MESSAGE].stringValue
                let userObjects = json["users"].arrayValue
                var users = [UserModel]()
                for object in userObjects {
                    users.append(ParseHelper.parseUser(object))
                }
                completion(message, users)
            }
        }
    }
    
    static func getNearByWorkers(completion: @escaping (String, [UserModel]) -> ()) {
        let params = [
            Constants.KEY_USER_ID : currentUser?.user_id as AnyObject,
            "distance" : currentUser?.user_rangedistance as AnyObject,
            "latitude" : currentLatitude as AnyObject,
            "longitude" : currentLongitude as AnyObject
        ]
        Alamofire.request(REQ_GETNEARBYWORKERS, method: .post, parameters: params).responseJSON { response in
            if response.result.isFailure{
                completion(Constants.CHECK_NETWORK_ERROR, [])
            }
            else
            {
                let json = JSON(response.result.value!)
                let message = json[Constants.RES_MESSAGE].stringValue
                let userObjects = json["users"].arrayValue
                var users = [UserModel]()
                for object in userObjects {
                    users.append(ParseHelper.parseUser(object))
                }
                completion(message, users)
            }
        }
    }
    
    
}



