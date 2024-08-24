//
//  ViewController.swift
//  RandomPhotoGenerator
//
//  Created by Davizinho on 8/23/24.
//

import UIKit

class ViewController: UIViewController {

    // Create the image
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        // Make sure the aspect ratio is not stretched
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .systemBrown
        
        return imageView
    }()
    
    // Add a button
    private let button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemMint
        button.setTitle("Generate Random Photo", for: .normal)
        button.setTitleColor(.black, for: .normal)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Change background color to Apple's built in blue
        view.backgroundColor = .systemBlue
        
        // Adding the image to the App
        view.addSubview(imageView)
        // Assign the frame for the image
        imageView.frame = CGRect(x: 0, y: 0, width: 260, height: 260)
        imageView.center = view.center
        
        view.addSubview(button)
        
        getRandomPhoto()
        
        // Add the didClickButton function to the button
        button.addTarget(self, action: #selector(didClickButton), for: .touchUpInside)
    }
    
    @objc func didClickButton() {
        getRandomPhoto()
    }
    
    // Make sure the button is not overlapping the iPhone
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        button.frame = CGRect(x: 30, y: view.frame.size.height - 160 - view.safeAreaInsets.bottom, width: view.frame.size.width - 60, height: 55)
    }
    
    func getRandomPhoto() {
        // Random image generator API endpoint
        let urlString = "https://picsum.photos/600"
        
        let url = URL(string: urlString)!
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                // Check for errors and make sure we got data
                guard let data = data, error == nil else {
                    return
                }
                
                // Ensure this is done on the main thread, since it's UI work
                DispatchQueue.main.async {
                    self?.imageView.image = UIImage(data: data)
                }
            }
            
            task.resume()
    }
}

