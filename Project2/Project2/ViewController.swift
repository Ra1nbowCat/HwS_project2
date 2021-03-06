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
    var finalCounter = 0
    var scoreToBeat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "us", "uk"]
        
        let defaults = UserDefaults.standard
        
        if let savedCounter = defaults.object(forKey: "counter") as? Data {
            let jsonDecoder = JSONDecoder()
            
            do {
                finalCounter = try jsonDecoder.decode(Int.self, from: savedCounter)
            } catch {
                print("Error in decoding")
            }
        }
        
        askQuestion()
        
        let ac3 = UIAlertController(title: "Your previous score is: \(finalCounter). Can you beat this?", message: nil, preferredStyle: .alert)
        ac3.addAction(UIAlertAction(title: "Continue", style: .default))
        present(ac3, animated: true)
        print(finalCounter)
        scoreToBeat = finalCounter
        finalCounter = 0
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
        title! += " | Your score now is: \(counter)"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(showScore))
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        
        if sender.tag == correctAnswer {
            title = "Correct"
            counter += 1
            finalCounter = counter
            save()
        } else {
            title = "Wrong. It's \(countries[sender.tag].uppercased())"
            counter -= 1
            finalCounter = counter
            save()
        }
        
        if counter == scoreToBeat + 1 {
            let ac4 = UIAlertController(title: "Wow! You've beaten your previous score!", message: "Your score is: \(counter)", preferredStyle: .alert)
            ac4.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            present(ac4, animated: true)
        } else if counter < 10 {
            let ac = UIAlertController(title: title, message: "Your score is: \(counter)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            present(ac, animated: true)
        } else {
            let ac2 = UIAlertController(title: title, message: "Congratulations! You won!", preferredStyle: .alert)
            ac2.addAction(UIAlertAction(title: "New game", style: .default, handler: askQuestion))
            counter = 0
            finalCounter = counter
            save()
            present(ac2, animated: true)
        }
    }
    
    @objc func showScore() {
        let ac = UIAlertController(title: "This is your score!", message: "Your score is: \(counter)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok, let's play!", style: .default))
        ac.addAction(UIAlertAction(title: "Clear my score!", style: .default, handler: clearScore))
        present(ac, animated: true)
    }
    
    @objc func clearScore(action: UIAlertAction! = nil) {
        counter = 0
        title = countries[correctAnswer].uppercased()
        title! += " | Your score now is: \(counter)"
    }
    
    func save() {
        let jsonEncoder = JSONEncoder()
        
        if let savedData = try? jsonEncoder.encode(finalCounter) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "counter")
        } else {
            print("Failed to encode")
        }
    }
}

