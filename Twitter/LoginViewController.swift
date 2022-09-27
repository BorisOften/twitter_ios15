//
//  LoginViewController.swift
//  Twitter
//
//  Created by Boris Ofon on 9/26/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDefaults.standard.bool(forKey: "userLogggedIn") == true{
            self.performSegue(withIdentifier: "loginToHome", sender: self)
        }
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        
        let myUrl = "https://api.twitter.com/oauth/request_token"
        TwitterAPICaller.client?.login(url: myUrl, success: {
            UserDefaults.standard.set(true, forKey: "userLogggedIn")
            self.performSegue(withIdentifier: "loginToHome", sender: self)
            print("You finanly got it")
        }, failure: { (Error) in
            print(Error)
        })
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
