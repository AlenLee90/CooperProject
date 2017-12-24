//
//  PersonalViewController.swift
//  Cooper
//
//  Created by 李亚男 on 2017/10/18.
//  Copyright © 2017年 李亚男. All rights reserved.
//

import UIKit

class PersonalViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {

    let loginService = LoginService()
    let currencyManagementController = CurrencyManagementController()
    let collectionName :[String] = ["Set Currency","Set Category","Set View Style","Set Cordon","Set Language"]
    let collectionPicture :[String] = ["icons8-usd.png","icons8-mind_map.png","icons8-star.png","icons8-attention.png","icons8-geography.png"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! PersonalCollectionViewCell
        cell.collectionLabel.text = collectionName[indexPath.row]
        cell.collectionImage.image = UIImage(named: collectionPicture[indexPath.row])?.withRenderingMode(.alwaysOriginal) // deselect image
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        present( UIStoryboard(name: "CurrencyManagement", bundle: nil).instantiateViewController(withIdentifier: "currencyStory") as! UINavigationController, animated: true, completion: nil)
        
    }

    @IBAction func logout(_ sender: UIBarButtonItem) {
        loginService.logout()
        present( UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") , animated: true, completion: nil)
    }
}
