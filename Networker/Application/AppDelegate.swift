
//
//  AppDelegate.swift
//  Marketmaker
//
//  Created by Big shark on 11/10/2016.
//  Copyright © 2016 Big shark. All rights reserved.
//

import UIKit
import UserNotifications
import Firebase
import FirebaseInstanceID
import FirebaseMessaging
import FirebaseAuth
import CoreLocation
import FBSDKCoreKit


var currentLatitude = 0.0
var currentLongitude = 0.0

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,CLLocationManagerDelegate {
    
    var window: UIWindow?
    
    let locationManager = CLLocationManager()
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        
        if #available(iOS 10.0, *) {
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
            
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            // For iOS 10 data message (sent via FCM)
            FIRMessaging.messaging().remoteMessageDelegate = self
            
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        
        
        
        FIRApp.configure()
        
        // Add observer for InstanceID token refresh callback.
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.tokenRefreshNotification),
                                               name: NSNotification.Name.firInstanceIDTokenRefresh,
                                               object: nil)
        
        
        setBaseUrl()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.requestLocation()
        updateTimer()
        
        UserDefaults.standard.set(25, forKey: "distance")
        return true
    }
    
    func setBaseUrl(){
        var myDict: NSDictionary?
        if let path = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist") {
            myDict = NSDictionary(contentsOfFile: path)
        }
        if let dict = myDict {
            
            
            //let distobject = dict.object(forKey: "informaton Property List") as! [String: String]
            Constants.FIR_STORAGE_BASE_URL = "gs://" + (dict.value(forKey: "STORAGE_BUCKET") as! String)
        }
    }
    
    func updateTimer(){
        
        Timer.scheduledTimer(timeInterval: 30, target: self, selector: #selector(updateLocation), userInfo: nil, repeats: true)
    }
    
    func updateLocation()
    {
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.first
        NSLog("latitude == \(location?.coordinate.latitude) , longitude == \(location?.coordinate.longitude)")
        currentLatitude = (location?.coordinate.latitude)! as Double
        currentLongitude = (location?.coordinate.longitude)! as Double
        if(currentUser.user_id > 0){
            /*CLGeocoder().reverseGeocodeLocation(location!, completionHandler: {
                placemarks, error in
                var placeMark: CLPlacemark!
                placeMark = placemarks?.last
                
                
                var addressString = ""
                
                if(placeMark != nil){
                    // Location name
                    if let locationName = placeMark.addressDictionary!["Name"] as? NSString {
                        addressString = locationName as String
                    }
                    
                }
                
            })*/
            currentUser.user_latitude = currentLatitude
            currentUser.user_longitude = currentLongitude
            
            /*
            FirebaseUserAuthentication.getAllUsers(completion: {
                users in
                globalUsersArray = users
                var friendsArray : [FriendModel] = []
                for friend in myFriends{
                    let user = FirebaseUserAuthentication.getUserFromUserid(friend.friend_user.user_id)
                    if user != nil{
                        friend.friend_user = user!
                        friendsArray.append(friend)
                    }
                }
                myFriends = friendsArray
            })*/
            
            
        }
        manager.stopUpdatingLocation()
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        FIRMessaging.messaging().disconnect()
        print("Disconnected from FCM.")
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        connectToFcm()
        FBSDKAppEvents.activateApp()
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:
        //ApiFunctions.send
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: "CloseChatting"), object: nil)
        
    }
    
    //when token refreshed, user register it.
    func tokenRefreshNotification(_ notification: Notification) {
        if let refreshedToken = FIRInstanceID.instanceID().token() {
            print("InstanceID token: \(refreshedToken)")
            /*UserDefaults.standard.setValue("\(refreshedToken)", forKey: Constants.DEVICE_TOKEN)
            
            if currentUser.user_id.characters.count > 0{
                
                firebaseUserAuthInstance.createUserReference(userid: currentUser.user_id)
                firebaseUserAuthInstance.setUserDeviceStatus(userid: currentUser.user_id, token: "\(refreshedToken)", status: Constants.USER_DEVICE_ONLINE)
            }*/
            
        }
        
        // Connect to FCM since connection may have failed when attempted before having a token.
        connectToFcm()
    }
    
    
    
    func connectToFcm() {
        
        FIRMessaging.messaging().connect { (error) in
            if (error != nil) {
                print("Unable to connect with FCM. \(error)")
            } else {
                print("Connected to FCM.")
                
            }
        }
    }
    
    // [START receive_message]
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification
        // Print message ID.
        
        //if (application.app)
        print("Message ID: \(userInfo["gcm.message_id"]!)")
        // Print full message.{
        
        print("%@", userInfo)
    }
    // [END receive_message]
    
    
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        
        print("APNs token retrieved: \(deviceToken)")
        FIRInstanceID.instanceID().setAPNSToken(deviceToken, type: FIRInstanceIDAPNSTokenType.unknown)
        
        
        if(currentUser.user_id > 0)
        {
            //firebaseUserAuthInstance.setUserDeviceStatus(userid: currentUser.user_id, token: "\(deviceToken)", status: Constants.USER_DEVICE_ONLINE)
        }
        
    }
    
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        let handled = FBSDKApplicationDelegate.sharedInstance().application(app, open: url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String!, annotation: options[UIApplicationOpenURLOptionsKey.annotation])
        return handled
    }
    
}


/// [START ios_10_message_handling]
@available(iOS 10, *)

extension AppDelegate : UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        // Print message ID.
        print("Message ID: \(userInfo["gcm.message_id"]!)")
        // Print full message.
        print("%@", userInfo)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        //NSLog("==============Succeeded=================")
    }
}
extension AppDelegate : FIRMessagingDelegate {
    // Receive data message on iOS 10 devices.
    func applicationReceivedRemoteMessage(_ remoteMessage: FIRMessagingRemoteMessage) {
        //print("%@", remoteMessage.appData)
        
    }
    
    
}
// [END ios_10_message_handling]
