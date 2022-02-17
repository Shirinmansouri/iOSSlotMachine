//
//  GameViewController.swift
//  SlotMachine
//
//  Created by Shirin Mansouri on 2022-01-23.
//

import UIKit
import SpriteKit
import GameplayKit

struct Info : Codable{
    let id : Int
    let name : String
    let point : Int
    let date : String
    let jack : Int
}

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
    
    @IBOutlet weak var btnPayout: UITextField!
    
    var lastId : Int = 0
    var lastJack : Int = 0
    var lastPoint : Int = 0
    var listOfInfo : [Info] = []
    var userDefaults = UserDefaults.standard
    let zeroInfo = Info(id: 0, name: "Sexy", point: 0, date: "today", jack: 0)

    
    @IBAction func btnQuit(_ sender: UIButton) {
        exit(0)
    }
    
    func idCounter() -> Int{
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        
        do{
            let aux = userDefaults.data(forKey: "Info")!
            listOfInfo = try decoder.decode([Info].self, from: aux)
            lastId = (listOfInfo[listOfInfo.count-1] as Info).id
            return lastId
        }
        catch{
            print("Unable to encode: (\(error))")
            return 0
        }
    }
    func lastJackpot() -> Int{
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        
        listOfInfo.append(zeroInfo)
        do{
            let zeroEntry = try encoder.encode(listOfInfo)
            userDefaults.set(zeroEntry, forKey: "Info")
        }catch{
            print("Unable to encode: (\(error))")
        }
        
        do{
            let aux = userDefaults.data(forKey: "Info")!
            listOfInfo = try decoder.decode([Info].self, from: aux)
            lastJack = (listOfInfo[listOfInfo.count-1] as Info).jack
            return lastJack
        }
        catch{
            print("Unable to encode: (\(error))")
            return 0
        }
    }
    func lastPay() -> Int{
        
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        
        listOfInfo.append(zeroInfo)
        do{
            let zeroEntry = try encoder.encode(listOfInfo)
            userDefaults.set(zeroEntry, forKey: "Info")
        }catch{
            print("Unable to encode: (\(error))")
        }
        
        do{
            let aux = userDefaults.data(forKey: "Info")!
            listOfInfo = try decoder.decode([Info].self, from: aux)
            lastPoint = (listOfInfo[listOfInfo.count-1] as Info).point
            return lastPoint
        }
        catch{
            print("Unable to encode: (\(error))")
            return 0
        }
    }
    
    
    @IBAction func btnInfo(_ sender: UIButton) {
        
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()

        var insertedDate = ""
        let date = Date()
        let calendar = Calendar.current
        
        let enteredJack : Int? = Int(txtJackpot.text!)
        let enteredPayout : Int? = Int(btnPayout.text!)

        insertedDate += String(calendar.component(.year, from: date)) + "/" + String(calendar.component(.month, from: date)) + "/" + String(calendar.component(.day, from: date))

        listOfInfo.append(zeroInfo)
        do{
            let zeroEntry = try encoder.encode(listOfInfo)
            userDefaults.set(zeroEntry, forKey: "Info")
        }catch{
            print("Unable to encode: (\(error))")
        }
        let newInfo : Info
        newInfo = Info(id: idCounter()+1, name: "Alex", point: enteredPayout!, date: insertedDate, jack: enteredJack!)
        do{
            let aux = userDefaults.data(forKey: "Info")!
            listOfInfo = try decoder.decode([Info].self, from: aux)
            listOfInfo.append(newInfo)
            let entry = try encoder.encode(listOfInfo)
            userDefaults.set(entry, forKey: "Info")

        }catch{
            print("Unable to encode: (\(error))")
        }
        
    }
    
    
    func showToast(message : String, font: UIFont) {

        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
             toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    @IBAction func btnSpin(_ sender: UIButton) {
        var bet : Int?
        var money : Int?
        bet  = Int(txtBet.text!)
        money = Int(txtMoney.text!)
        var oldJackPot : Int?
        oldJackPot = Int(txtJackpot.text!)
        var payOut : Int?
        payOut = Int(btnPayout.text!)
        
        var number1=Int.random(in: 0...cars.count-1)
        imgFirst.image = UIImage(named:cars[number1])
        var number2 = Int.random(in: 0...cars.count-1)
        imgSecond.image = UIImage(named:cars[number2])
        var number3 = Int.random(in: 0...cars.count-1)
        imgThird.image = UIImage(named:cars[number3])
        
        if (number1 == number2 && number2 == number3)
        {
            btnPayout.text = String(payOut! + oldJackPot!)
            txtJackpot.text = "0"
            self.showToast(message: "You won jackpot!", font: .systemFont(ofSize: 14.0))
        }
        else
        {
            txtMoney.text = String(money!-bet! )
            txtJackpot.text = String(oldJackPot! + bet! )
            
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
        txtMoney.text = "15"
        btnSpin.isEnabled = true;
        
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
            
            txtJackpot.text = String(lastJackpot())
            btnPayout.text = String(lastPay())
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
