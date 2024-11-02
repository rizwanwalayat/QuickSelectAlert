//
//  ViewController.swift
//  QuickSelectAlert
//
//  Created by Rizwan Walayat on 03/11/2024.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        showQuickSelectAlert()
        // Do any additional setup after loading the view.
    }
    
    func showQuickSelectAlert(){
        let alertController = UIStoryboard(name: "QuickSelectAlert", bundle: Bundle.main).instantiateViewController(withIdentifier:  "QuickSelectAlertController") as! QuickSelectAlertController
        alertController.items = ["Living Room", "Kitchen", "Master Bedroom", "Bedroom 2", "Bedroom 3", "Bathroom", "Office", "Hallway"]
        alertController.okActionHandler = { text in
                self.dismiss(animated: false)
        }
        alertController.modalPresentationStyle = .overCurrentContext
        alertController.modalTransitionStyle = .crossDissolve
        self.present(alertController, animated: true, completion: nil)
    }


}

