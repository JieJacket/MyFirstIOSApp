//
//  ViewController.swift
//  MyFirstIOSApp
//
//  Created by jie on 2016/11/9.
//  Copyright © 2016年 jie. All rights reserved.
//

import UIKit

class MealViewController: UIViewController,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    
    var meal:Meal?
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        
        if presentingViewController is UINavigationController {
            dismiss(animated: true, completion: nil)
        }else{
            navigationController!.popViewController(animated: true)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
        if let meal = meal {
            nameTextField.text = meal.name
            navigationItem.title = meal.name
            photoImageView.image = meal.photo
            ratingControl.rating = meal.rating
        }
        
        checkMealName()
        
        initView()
    }
    
    func initView(){
        let gesture = UITapGestureRecognizer(target: self, action: Selector(("photoImageTapped:")))
        
        photoImageView.addGestureRecognizer(gesture)
    }
    
    func photoImageTapped() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            self.present(picker, animated: true, completion: {
                () -> Void in
            })
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print(info)
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        photoImageView.image = image
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        checkMealName()
        
        navigationItem.title = textField.text
    }
    //
    //    func textFieldDidBeginEditing(_ textField: UITextField) {
    //        saveButton.isEnabled = false
    //    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if saveButton === sender as AnyObject?{
            let name = nameTextField.text ?? ""
            let photo = photoImageView.image
            let rating = ratingControl.rating
            
            meal = Meal(name:name, photo: photo, rating: rating)
            
        }
    }
    
    
    func checkMealName() {
        let text = nameTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
        
    }
    
}

