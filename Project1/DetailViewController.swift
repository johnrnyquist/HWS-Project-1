//
//  DetailViewController.swift
//  Project1
//
//  Created by John Nyquist on 3/10/19.
//  Copyright © 2019 Nyquist Art + Logic LLC. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    
    var selectedImageName: String?

    
    //MARK: - UIViewController class
    
    // Called after the controller's view is loaded into memory.
    override func viewDidLoad() {
        super.viewDidLoad()

        //title = selectedImage
        navigationItem.largeTitleDisplayMode = .never // small titles

        if let imageToLoad = selectedImageName {
            imageView.image = UIImage(named: imageToLoad)
        }
    }
    
    // Notifies the view controller that its view is about to be added to a view hierarchy.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true // This could be useful in Near Mint
    }
    
    // Notifies the view controller that its view is about to be removed from a view hierarchy.
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
}
