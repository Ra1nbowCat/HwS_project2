//
//  ViewController.swift
//  Project2
//
//  Created by Илья Лехов on 25.04.2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var counter = 0
    var correctAnswer = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "us", "uk"]
        
        askQuestion()
    }

    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        button1.imageView?.layer.borderWidth = 1
        button1.imageView?.layer.borderColor = UIColor.lightGray.cgColor
        
        button2.imageView?.layer.borderWidth = 1
        button2.imageView?.layer.borderColor = UIColor.lightGray.cgColor
        
        button3.imageView?.layer.borderWidth = 1
        button3.imageView?.layer.borderColor = UIColor.lightGray.cgColor
        
        title = countries[correctAnswer].uppercased()
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        
        if sender.tag == correctAnswer {
            title = "Correct"
            counter += 1
        } else {
            title = "Wrong"
            counter -= 1
        }
        
        let ac = UIAlertController(title: title, message: "Your score is: \(counter)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        present(ac, animated: true)
    }
    
}

