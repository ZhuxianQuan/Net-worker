//
//  HomeViewController.swift
//  Networker
//
//  Created by Big Shark on 13/03/2017.
//  Copyright © 2017 shark. All rights reserved.
//

import UIKit
import MapKit
import KYDrawerController

class HomeViewController: BaseViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var backButton: UIButton!
    
    var nearMeWorkers : [UserModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        mapView.showsUserLocation = true        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        initMapView()
        if navigationController!.viewControllers.count > 1{
            backButton.isHidden = false
        }
        else {
            backButton.isHidden = true
        }
        getHomeData()

    }
    
    func initMapView()
    {
        mapView.removeAnnotations(mapView.annotations)
        for overlay in mapView.overlays{
            mapView.remove(overlay)
        }
        
        //mapView.remove
    }
    
    
    func getHomeData(){
        
    }
    
    
    func arrangeFriends() {
        
        var index = 0
        for worker in nearMeWorkers{
            index += 1
            let info = StarbuckAnnotation(coordinate: CLLocationCoordinate2D(latitude: worker.user_latitude, longitude: worker.user_longitude))
            info.user = worker
            
            //NSLog(" user location  == \(worker.user_latitude)), \(worker.user_longitude)")
            info.title = worker.user_firstname + " " + worker.user_lastname
            //info.subtitle = friend.friend_user.user_currentLocationName
            mapView.addAnnotation(info)
        }
        
    }
    
    func setRegionForLocation(
        location:CLLocationCoordinate2D,
        spanRadius:Double,
        animated:Bool)
    {
        let span = 2.0 * spanRadius
        let region = MKCoordinateRegionMakeWithDistance(location, span, span)
        mapView.setRegion(region, animated: animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //func add radius circle
    
    func addRadiusCircle(){
        let circle = MKCircle(center: CLLocationCoordinate2D(latitude: currentLatitude, longitude: currentLongitude) , radius: currentUser.user_rangedistance * 1609)
        self.mapView.add(circle)
    }

    @IBAction func backButtonTapped(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func menuButtonTapped(_ sender: Any) {
            drawerController?.setDrawerState(.opened, animated: true)
    }
    
    @IBAction func searchStarted(_ sender: Any) {
        let storyboard = getStoryboard(id: Constants.STORYBOARD_SEARCH)
        let searchvc = storyboard.instantiateViewController(withIdentifier: "SearchMenuViewController")
        self.navigationController?.pushViewController(searchvc, animated: true)
    }
    
    
}

extension HomeViewController: MKMapViewDelegate{
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation
        {
            return nil
        }
        var annotationView = self.mapView.dequeueReusableAnnotationView(withIdentifier: "Pin")
        if annotationView == nil{
            annotationView = AnnotationView(annotation: annotation, reuseIdentifier: "Pin")
            annotationView?.canShowCallout = false
        }else{
            annotationView?.annotation = annotation
        }
        
        //let imageView = UIImageView()
        //let customAnnotation = annotation as! StarbuckAnnotation
        
        //imageView.setImageWith(storageRefString: customAnnotation.user.user_profileimageurl, placeholderImage: UIImage(named:"icon_profile")!)
        let image = CommonUtils.resizeImage(image: UIImage(named : "logo_bee")!, targetSize: CGSize(width: 30, height: 30))
        
        annotationView?.layer.cornerRadius = 15
        annotationView?.layer.masksToBounds = true
        annotationView?.layer.borderWidth = 1.5
        annotationView?.layer.borderColor = UIColor.white.cgColor
        annotationView?.image = image
        return annotationView
        
    }
    
    
    func mapView(_ mapView: MKMapView,
                 didSelect view: MKAnnotationView)
    {
        // 1
        if view.annotation is MKUserLocation
        {
            // Don't proceed with custom callout
            return
        }
        //let starbucksAnnotation = view.annotation as! StarbuckAnnotation
        /*currentFriend = starbucksAnnotation.friend.friend_user
        currentRoomid = starbucksAnnotation.friend.friend_roomid
        
        setFriendData(user: currentFriend)*/
        
        
        let label = UILabel()
        //label.text = currentFriend.user_currentLocationName + " (\(CommonUtils.getTimeString(from: (getGlobalTime() - currentFriend.user_locationChangedTime)/1000)))"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.white
        //NSLog(currentFriend.user_currentLocationName)
        label.frame = CGRect(x: 15 - label.intrinsicContentSize.width/2, y: -15, width: label.intrinsicContentSize.width, height: label.intrinsicContentSize.height)
        
        view.layer.masksToBounds = false
        view.addSubview(label)
        
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        if view.isKind(of: AnnotationView.self)
        {
            for subview in view.subviews
            {
                subview.removeFromSuperview()
            }
            view.layer.masksToBounds = true
        }
    }
    
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKCircle{
            let circle = MKCircleRenderer(overlay: overlay)
            //circle.strokeColor = UIColor.blue
            circle.fillColor = UIColor(red: 0, green: 0, blue: 0.4, alpha: 0.05)
            //circle.lineWidth = 1
            return circle
        }
        else {
            return overlay as! MKOverlayRenderer
        }
        
    }
    
}

