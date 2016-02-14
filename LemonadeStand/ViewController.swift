//
//  ViewController.swift
//  LemonadeStand
//
//  Created by Ansel Adams on 2/14/16.
//  Copyright © 2016 Ansel Adams. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var bankLabel: UILabel!
    @IBOutlet weak var lemonsLabel: UILabel!
    @IBOutlet weak var iceCubesLabel: UILabel!
    
    @IBOutlet weak var lemonsPurchasedLabel: UILabel!
    @IBOutlet weak var iceCubesPurchasedLabel: UILabel!
    
    @IBOutlet weak var lemonsMixLabel: UILabel!
    @IBOutlet weak var iceCubesMixLabel: UILabel!
    
    var totalBank = 10
    var totalLemons = 1
    var totalIceCubes = 1
    
    var lemonsPurchased = 0
    var iceCubesPurchased = 0
    var lemonsMixed = 0
    var iceCubesMixed = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        resetGame()
        updateMainDisplay()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func startDayButtonPressed(sender: AnyObject) {
        print("Start Day button pressed!")
        if lemonsMixed == 0 {
            showAlertWithText(message: "Gotta have some lemons!")
            return
        } else if iceCubesMixed == 0 {
            showAlertWithText(message: "Gotta have some ice cubes!")
            return
        }
        var paid = 0
        let ratio = Double(lemonsMixed) / Double(iceCubesMixed)
        print("Ratio of lemons to ice = \(ratio)")
        let numberOfCustomers = Int(arc4random_uniform(UInt32(10))) + 1
        print("Number of customers is \(numberOfCustomers)")
        for _ in 1...numberOfCustomers {
            let customerPreference = Double(arc4random()) / Double(UINT32_MAX)
            print("Customer preference is \(customerPreference)")
            if ratio > 1.0 {
                // acidic lemonade today
                if customerPreference < 0.4 {
                    print("Customer Paid! (acidic)")
                    paid += 1
                } else {
                    print("No match, no revenue")
                }
            } else if ratio == 1.0 {
                // just right lemonade today
                if customerPreference >= 0.4 && customerPreference <= 0.6 {
                    print("Customer Paid! (just right)")
                    paid += 1
                } else {
                    print("No match, no revenue")
                }
            } else {
                // diluted lemonade today
                if customerPreference > 0.6 {
                    print("Customer Paid! (diluted)")
                    paid += 1
                } else {
                    print("No match, no revenue")
                }
            }
        }
        print("Previous bank: \(totalBank)")
        print("Total paid today: \(paid)")
        totalBank += paid
        print("Updated bank:\(totalBank)")
        resetGame()
        updateMainDisplay()
    }
    
    @IBAction func purchaseLemonsButtonPressed(sender: AnyObject) {
        if totalBank >= 2 {
            totalLemons += 1
            lemonsPurchased += 1
            totalBank -= 2
        } else {
            showAlertWithText(message: "Not enough money to buy lemons.")
            return
        }
        updateMainDisplay()
    }

    @IBAction func sellLemonsButtonPressed(sender: AnyObject) {
        if lemonsPurchased > 0 {
            totalLemons -= 1
            lemonsPurchased -= 1
            totalBank += 2
        } else {
            showAlertWithText(message: "No lemons left to sell back.")
            return
        }
        updateMainDisplay()
    }
    
    @IBAction func purchaseIceCubesButtonPressed(sender: AnyObject) {
        if totalBank >= 1 {
            totalIceCubes += 1
            iceCubesPurchased += 1
            totalBank -= 1
        } else {
            showAlertWithText(message: "Not enough money to buy ice cubes.")
            return
        }
        updateMainDisplay()
    }
    
    @IBAction func sellIceCubesButtonPressed(sender: AnyObject) {
        if iceCubesPurchased > 0 {
            totalIceCubes -= 1
            iceCubesPurchased -= 1
            totalBank += 1
        } else {
            showAlertWithText(message: "No ice cubes left to sell back.")
            return
        }
        updateMainDisplay()
    }
    
    @IBAction func mixLemonsButtonPressed(sender: AnyObject) {
        if totalLemons > 0 {
            lemonsMixed += 1
            totalLemons -= 1
        } else {
            showAlertWithText(message: "No more lemons left to mix.")
            return
        }
        updateMainDisplay()
    }
    
    @IBAction func unmixLemonsButtonPressed(sender: AnyObject) {
        if lemonsMixed > 0 {
            lemonsMixed -= 1
            totalLemons += 1
        } else {
            showAlertWithText(message: "No more lemons are being mixed.")
            return
        }
        updateMainDisplay()
    }
    
    @IBAction func mixIceCubesButtonPressed(sender: AnyObject) {
        if totalIceCubes > 0 {
            iceCubesMixed += 1
            totalIceCubes -= 1
        } else {
            showAlertWithText(message: "No more ice cubes left to mix.")
            return
       }
        updateMainDisplay()
    }
    
    @IBAction func unmixIceCubesButtonPressed(sender: AnyObject) {
        if iceCubesMixed > 0 {
            iceCubesMixed -= 1
            totalIceCubes += 1
        } else {
            showAlertWithText(message: "No more ice cubes are being mixed.")
            return
       }
        updateMainDisplay()
    }
    
    func resetGame() {
        //self.totalBank = 10
        //self.totalLemons = 1
        //self.totalIceCubes = 1
        self.lemonsPurchased = 0
        self.iceCubesPurchased = 0
        self.lemonsMixed = 0
        self.iceCubesMixed = 0
    }
    
    func updateMainDisplay() {
        self.bankLabel.text = "$\(self.totalBank)"
        self.lemonsLabel.text = "\(self.totalLemons) Lemons"
        self.iceCubesLabel.text = "\(self.totalIceCubes) Ice Cubes"
        self.lemonsPurchasedLabel.text = "\(self.lemonsPurchased)"
        self.iceCubesPurchasedLabel.text = "\(self.iceCubesPurchased)"
        self.lemonsMixLabel.text = "\(self.lemonsMixed)"
        self.iceCubesMixLabel.text = "\(self.iceCubesMixed)"
        print("Total bank = \(totalBank)")
        print("Total lemons = \(totalLemons) (purch=\(lemonsPurchased), mix=\(lemonsMixed)")
        print("Total ice cubes = \(totalIceCubes) (purch=\(iceCubesPurchased), mix=\(iceCubesMixed)")
        print("-----------------------------------------------")
    }
    
    func showAlertWithText(header: String = "Warning", message: String) {
        let alert = UIAlertController(title: header, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
}

