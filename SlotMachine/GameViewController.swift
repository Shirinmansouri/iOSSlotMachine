//
//  GameViewController.swift
//  SlotMachine
//
//  Created by Shirin Mansouri on 2022-01-23.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
     
    @IBAction func txtMoneyEdited(_ sender: UITextField, forEvent event: UIEvent) {
        if (Int(txtMoney.text!)! < Int(txtBet.text!)!)
        {
            btnSpin.isEnabled = false
        }
        else
        {
            btnSpin.isEnabled = true
        }
    }
   
    
    @IBOutlet weak var btnSpin: UIButton!
    private var cars = ["car1","car2","car3","car4","car5","car6","car7","car8"]
    
    @IBOutlet weak var imgFirst: UIImageView!
    
    @IBOutlet weak var imgSecond: UIImageView!
    
    @IBOutlet weak var imgThird: UIImageView!
    
    @IBOutlet weak var txtBet: UITextField!
    
    @IBOutlet weak var txtJackpot: UITextField!
    
    @IBOutlet weak var txtMoney: UITextField!
    
    @IBAction func btnQuit(_ sender: UIButton) {
        exit(0)
    }
    
    @IBAction func btnSpin(_ sender: UIButton) {
        var bet : Int?
        var money : Int?
        bet  = Int(txtBet.text!)
        money = Int(txtMoney.text!)
        
        var number1=Int.random(in: 0...cars.count-1)
        imgFirst.image = UIImage(named:cars[number1])
        var number2 = Int.random(in: 0...cars.count-1)
        imgSecond.image = UIImage(named:cars[number2])
        var number3 = Int.random(in: 0...cars.count-1)
        imgThird.image = UIImage(named:cars[number3])
        
        if (number1 == number2 && number2 == number3)
        {
        
            txtMoney.text = String(bet!*10 + money!)
        }
        else
        {
            txtMoney.text = String(money!-bet! )
        }
        if (Int( txtMoney.text!)! < Int(txtBet.text!)! )
        {
            btnSpin.isEnabled = false;
        }
        else
        {
            btnSpin.isEnabled = true;
        }
        
    }
    
    @IBAction func btnReset(_ sender: UIButton) {
        txtMoney.text = "0"
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
            
            if (Int(txtMoney.text!)! < Int(txtBet.text!)!)
            {
                btnSpin.isEnabled = false
            }
            else
            {
                btnSpin.isEnabled = true
            }
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
