//
//  EntryDetailViewController.swift
//  JournalCloudKit
//
//  Created by Mitch Merrell on 8/26/19.
//  Copyright © 2019 Mitch Merrell. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var detailTitleItem: UINavigationItem!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    
    var entry: Entry? {
        didSet {
            loadViewIfNeeded()
            updateViews()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleTextField.delegate = self
    }
    
    func updateViews() {
        if let entry = entry {
            bodyTextView.text = entry.body
            titleTextField.text = entry.title
            detailTitleItem.title = "Edit In Tree"
        } else {
            detailTitleItem.title = "New In Tree"
        }
    }
    
    @IBAction func addEntryButtonTapped(_ sender: Any) {
        guard let titleText = titleTextField.text, let bodyText = bodyTextView.text else { return }
        if titleText != "" && bodyText != "" {
            EntryController.shared.addEntryWith(title: titleText, body: bodyText) { (success) in
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
    @IBAction func mainViewTapped(_ sender: Any) {
        titleTextField.resignFirstResponder()
        bodyTextView.resignFirstResponder()
    }
    
    @IBAction func clearTextButtonTapped(_ sender: Any) {
        titleTextField.text = ""
        bodyTextView.text = ""
    }
    //    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        <#code#>
//    }
}
