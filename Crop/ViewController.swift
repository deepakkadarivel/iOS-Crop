//
//  ViewController.swift
//  Crop
//
//  Created by Deepak Kadarivel on 27/01/16.
//  Copyright © 2016 upbeatios. All rights reserved.
//

import UIKit
import TOCropViewController

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, TOCropViewControllerDelegate {
    
    let picker = UIImagePickerController()
    private var image: UIImage!
    var imagePath = ""
    @IBOutlet weak var imageView: UIImageView!
    
    var imageCropView = TOCropViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func open(sender: AnyObject) {
        displayDialog()
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        self.dismissViewControllerAnimated(true, completion: nil)
        let tempImage = info[UIImagePickerControllerOriginalImage] as! UIImage
//        self.imageView.image = tempImage
        self.image = tempImage
        
        if self.image != nil {
            let controller = TOCropViewController(image: self.image)
            controller.delegate = self
            self.presentViewController(controller, animated: true, completion: nil)
        }
    }
    
    func displayDialog() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
        
        
        let OKAction = UIAlertAction(title: "Choose from Gallery", style: .Default) { (action) in
            self.openGallery()
        }
        alertController.addAction(OKAction)
        
        let destroyAction = UIAlertAction(title: "Take a Photo", style: .Default) { (action) in
            self.openCamera()
        }
        alertController.addAction(destroyAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        alertController.addAction(cancelAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func openGallery() {
        self.imageView.image = nil
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary){
            picker.delegate = self
            picker.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum;
            picker.allowsEditing = false
            
            self.presentViewController(picker, animated: true, completion: nil)
        }
    }
    
    func openCamera() {
        picker.delegate = self
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera))
        {
            picker.sourceType = UIImagePickerControllerSourceType.Camera
            picker.allowsEditing = true
            self .presentViewController(picker, animated: true, completion: nil)
        }
        else
        {
            let alertController = UIAlertController(title: "No Camera", message: "Simulator has no Camera", preferredStyle: .Alert)
            
            let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                self.dismissViewControllerAnimated(true, completion: nil)
            }
            alertController.addAction(OKAction)
            
            self.presentViewController(alertController, animated: true) {
            }
            
        }
    }

    @IBAction func crop(sender: AnyObject) {
        if self.image != nil {
            let controller = TOCropViewController(image: self.image)
            controller.delegate = self
            self.presentViewController(controller, animated: true, completion: nil)
        }
    }
    
    func cropViewController(cropViewController: TOCropViewController!, didCropToImage image: UIImage!, withRect cropRect: CGRect, angle: Int) {
        self.image = image
        self.imageView.image = self.image
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

