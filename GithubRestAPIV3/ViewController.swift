//
//  ViewController.swift
//  GithubRestAPIV3
//
//  Created by Sinder on 2019/5/31.
//  Copyright © 2019 Sinder. All rights reserved.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {
    @IBOutlet var textFiled: UITextField!
    
    @IBOutlet weak var searchResultLabel: UILabel!
    @IBOutlet weak var repoNameLabel: UILabel!
    
    @IBOutlet weak var nickLabel: UILabel!
    @IBOutlet weak var advarImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Accept: application/vnd.github.v3+json
    }
    
    func searchRepos(keyword: String) {
        
        NetWorkService.shared.sendWithRequest(url: "https://api.github.com/search/repositories", header: [:], parameters: ["q":keyword], completionCallBack: {
            
        }, successCallBack: { (response) in
            self.handleData(responseData: response)
            
        }) { (error) in
            self.searchResultLabel.text = "搜索失败"
        }
    }
    
    func handleData(responseData: [String: Any]) {
        self.searchResultLabel.text = "搜索成功"
        if  let array = responseData["items"] as? NSArray {
            let firstItem = array[0]
                let itemDic = firstItem as! NSDictionary
                let owerDic = itemDic["owner"] as! NSDictionary
                let advatar = owerDic["avatar_url"] as! String
                let name = owerDic["login"] as! String
                let repo = owerDic["url"] as! String
                nickLabel.text = name
                advarImageView.sd_setImage(with: URL(string: advatar), placeholderImage: UIImage(named: "default.jpg"), options: .retryFailed, context: nil)
                repoNameLabel.text = repo
            }
        }

}

//event
extension ViewController {
    
    @IBAction func searchAction(_ sender: Any) {
        searchRepos(keyword: self.textFiled.text!)
    }
    
}


extension ViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.textFiled.text = textField.text
    }
}

