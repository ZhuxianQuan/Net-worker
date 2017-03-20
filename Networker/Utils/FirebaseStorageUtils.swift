//
//  FirebaseStorageUtils.swift
//  FelineFitness
//
//  Created by Huijing on 08/12/2016.
//  Copyright © 2016 Huijing. All rights reserved.
//

import Foundation
import Firebase
import FirebaseStorage
import FirebaseStorageUI
import SDWebImage

class FirebaseStorageUtils
{
    static let storage = FIRStorage.storage()

    static func uploadImage(toURL: String,userid: String, image: UIImage, completion: @escaping (String, Bool) -> ())
    {
        // Get a reference to the storage service, using the default Firebase App

        // Create a storage reference from our storage service

        let fileURL = toURL + "/" + userid  + "\(getGlobalTime())" + ".jpg"
        let storageRef = storage.reference(forURL: fileURL)
        let data = UIImageJPEGRepresentation(image, 0.5)
        _ = storageRef.put(data!, metadata: nil){
            metadata, error in
            if(error != nil)
            {
                completion("fail" , false)
            }
            else{
                //let downloadURL = metadata?.downloadURL()?.absoluteString
                completion(fileURL, true)
                
            }
        }
    }

    static func uploadVideo(toURL: String,userid: String, url: URL, completion: @escaping (String, Bool) -> ())
    {
        // Get a reference to the storage service, using the default Firebase App
        
        // Create a storage reference from our storage service
        
        let fileURL = toURL + "/" + userid  + "\(getGlobalTime())" + ".mp4"
        let storageRef = storage.reference(forURL: fileURL)
        // File located on disk
        let localFile = url
        
        // Create a reference to the file you want to upload
        // Upload the file to the path "images/rivers.jpg"
        _ = storageRef.putFile(localFile, metadata: nil) { metadata, error in
            if error != nil {
                // Uh-oh, an error occurred!
                completion("", false)
            } else {
                // Metadata contains file metadata such as size, content-type, and download URL.

                completion(fileURL, true)
            }
        }
    }
  /*
    
    static func downloadFile(from: String,  filename: String ,completion: @escaping (URL, Bool) -> ())
    {
        // Create a reference to the file you want to download
        let storageRef = storage.reference(forURL: Constants.FIR_STORAGE_BASE_URL + "/" + from + "/" + filename)
        
        var savedFilePath = "\(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])" + "/" + from + "/" + filename
        
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: savedFilePath) {
            savedFilePath = "file:" + savedFilePath
            let localURL = URL(string: savedFilePath)!
            completion(localURL, true)
            return
        } else {
            print("FILE NOT AVAILABLE")
        }
        
        savedFilePath = "file:" + savedFilePath
        
        let localURL = URL(string: savedFilePath)!
        
        // Download to the local filesystem
        _ = storageRef.write(toFile: localURL) { url, error in
            if error != nil {
                // Uh-oh, an error occurred!
                completion(localURL as URL, false)
            } else {
                // Local file URL for "images/island.jpg" is returned
                completion(localURL as URL , true)
            }
        }
    }*/

  /*
    static func downloadFile(fromURL: String, filename: String ,completion: @escaping (Bool) -> ())
    {
        // Create a reference to the file you want to download
        let storageRef = storage.reference(forURL: fromURL)
        let islandRef = storageRef.child(filename)


        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentDirectory: NSString! = paths[0] as NSString!

        // Create local filesystem URL
        var localURL: NSURL!


        let savedFilePath = documentDirectory.appendingPathComponent(filename)
        localURL = NSURL(string: savedFilePath)

        // Download to the local filesystem
        _ = islandRef.write(toFile: localURL as URL) { (URL, error) -> Void in
            if (error != nil) {
                // Uh-oh, an error occurred!
                completion(false)

            } else {
                completion(true)
                // Local file URL for "images/island.jpg" is returned
            }
        }
    }
    */
    
}

extension UIImageView{

    func setImageWith(storageRefString: String, placeholderImage: UIImage)
    {
        if storageRefString.hasPrefix("http")
        {
            self.sd_setImage(with: URL(string : storageRefString), placeholderImage: placeholderImage)
        }
        else{
            let reference : FIRStorageReference = FIRStorage.storage().reference(forURL: storageRefString)
            self.sd_setImage(with: reference, placeholderImage: placeholderImage)
        }
        
    }

}

