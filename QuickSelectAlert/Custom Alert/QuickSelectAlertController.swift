//
//  QuickSelectAlertController.swift
//  OhmConnect
//
//  Created by Rizwan Walayat on 21/06/2024.
//

import UIKit

class QuickSelectAlertController: UIViewController {
	
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var alertViewCenterYConstraint: NSLayoutConstraint!
    var items: [String]!
    var okActionHandler: ((String?) -> Void)?
    var dismissActionHandler: (() -> Void)?
	
    override func viewDidLoad() {
        super.viewDidLoad()

		let layout = LeftAlignedCollectionViewFlowLayout()
        collectionView.collectionViewLayout = layout
		collectionView.delegate = self
		collectionView.dataSource = self
        // Register for keyboard notifications
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func adjustAlertPosition(keyboardHeight: CGFloat, animationDuration: Double) {
        guard let _ = self.alertView else { return }
        
        // Calculate the new center Y constant
        let screenSize = UIScreen.main.bounds.size
        let availableHeight = screenSize.height - keyboardHeight
        let newCenterY = availableHeight / 2
        let screenCenter = screenSize.height / 2
        self.alertViewCenterYConstraint.constant = -screenCenter + newCenterY

        // Adjust the center Y constraint
        UIView.animate(withDuration: animationDuration) {
            self.view.layoutIfNeeded()
        }
    }

    @objc func keyboardWillShow(notification: NSNotification) {
            if let userInfo = notification.userInfo,
               let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
               let animationDuration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double {
                let keyboardHeight = keyboardFrame.height

                adjustAlertPosition(keyboardHeight: keyboardHeight, animationDuration: animationDuration)
            }
        }

    @objc func keyboardWillHide(notification: NSNotification) {
        if let userInfo = notification.userInfo,
           let animationDuration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double {
            adjustAlertPosition(keyboardHeight: 0, animationDuration: animationDuration)
        }
    }
    
    //IBActions
    @IBAction func okButtonPressed(_ sender: Any) {
        guard let okActionHandler else { return }
        okActionHandler(textField.text)
    }
    @IBAction func cancelButtonPressed(_ sender: Any) {
        if let dismissActionHandler {
            dismissActionHandler()
        } else {
            dismiss(animated: false)
        }
    }
}

extension QuickSelectAlertController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return items.count
	}
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QuickSelectAlertCell", for: indexPath) as! QuickSelectAlertCell
        cell.updateCell(text: items[indexPath.row])
        return cell
	}
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let textSize = items[indexPath.row].size(with: .systemFont(ofSize: 14))
        return CGSize(width: textSize.width + 22, height:textSize.height + 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedItem = items[indexPath.row]
        textField.text = selectedItem
    }
}

