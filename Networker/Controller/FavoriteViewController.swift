//
//  FavoriteViewController.swift
//  Networker
//
//  Created by Big Shark on 16/03/2017.
//  Copyright © 2017 shark. All rights reserved.
//

import UIKit

class FavoriteViewController: BaseViewController {

    @IBOutlet weak var favoriteTableViewCell: UITableView!
    @IBOutlet weak var connectionsButton: UIButton!
    @IBOutlet weak var suggestionsButton: UIButton!
    
    
    var currentStatus = 0
    let connections = 0
    let suggestions = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
     */
    @IBAction func connectionsButtonTapped(_ sender: UIButton) {
        currentStatus = 1
        connectionsButton.backgroundColor = UIColor.white
        connectionsButton.setTitleColor(UIColor.black, for: .normal)
        suggestionsButton.backgroundColor = UIColor.black
        suggestionsButton.setTitleColor(UIColor.white, for: .normal)
        
        
        favoriteTableViewCell.reloadData()
        
    }
    
    @IBAction func suggestionsButtonTapped(_ sender: UIButton) {
        currentStatus = 0
        connectionsButton.backgroundColor = UIColor.black
        connectionsButton.setTitleColor(UIColor.white, for: .normal)
        suggestionsButton.backgroundColor = UIColor.white
        suggestionsButton.setTitleColor(UIColor.black, for: .normal)
        
        favoriteTableViewCell.reloadData()
    }
    
    
    @IBAction func menuButtonTapped(_ sender: Any) {
        drawerController?.setDrawerState(.opened, animated: true)
    }

    
}


extension FavoriteViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteUserTableViewCell") as! FavoriteUserTableViewCell
        cell.setCell(UserModel(), status: currentStatus)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }


}
