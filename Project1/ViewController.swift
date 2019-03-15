//
//  ViewController.swift
//  Project1
//
//  Created by John Nyquist on 3/10/19.
//  Copyright © 2019 Nyquist Art + Logic LLC. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var pictureNames = [String]()
    
    
    //MARK: - UIViewController class
    
    // Called after the controller's view is loaded into memory.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer" // set the title
        navigationController?.navigationBar.prefersLargeTitles = true // big titles
        
        let fm = FileManager.default // get a filemanger
        let path = Bundle.main.resourcePath! //We can be sure iOS has a bundle
        let items = try! fm.contentsOfDirectory(atPath: path) //We can be sure the bundle directory has contents
        
//        for item in items {
//            print(item)
//            if item.hasPrefix("nssl") {
//                // this is a picture to load!
//                print("   adding picture")
//                pictures.append(item)
//            }
//        }
//        print("unsorted \(pictures)")
        pictureNames = items
            .filter { $0.hasPrefix("nssl") }
            .sorted { $0 < $1 }
//        pictures.sort() { $0 < $1 }
//        print("sorted \(pictures)")
        
        // .action is the box with the arrow coming out
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))

    }
    
    
    //MARK: - UITableViewDataSource protocol
    
    // Tells the data source to return the number of rows in a given section of a table view.
    // This class is the data source.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictureNames.count
    }

    // Asks the data source for a cell to insert in a particular location of the table view.
    // This class is the data source.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        
        /*  Swift lets us use a question mark – textLabel? –
            to mean “do this only if there is an actual text label there,
            or do nothing otherwise.”   */
        cell.textLabel?.text = pictureNames[indexPath.row] // indexPath: A list of indexes that together represent the
                                                       // path to a specific location in a tree of nested arrays.
        
        return cell
    }
    
    
    //MARK: - UITableViewDelegate protocol
    
    // Tells the delegate that the specified row is now selected.
    // This class is the delegate.
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let detailView = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            detailView.selectedImageName = pictureNames[indexPath.row]
            detailView.title = "\(indexPath.row + 1) of \(pictureNames.count)"
            // Pushes a view controller onto the receiver’s stack and updates the display. Note it is animated.
            navigationController?.pushViewController(detailView, animated: true)
        }
    }
    
    @objc func shareTapped() {
        let vc = UIActivityViewController(activityItems: ["Get Stormviewer, it reigns!"], applicationActivities: [])
        
        /* This line of code tells iOS to anchor the activity view
         controller to the right bar button item (our share button),
         but this only has an effect on iPad – on iPhone it's ignored. */
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        
        present(vc, animated: true)
    }
    
}


