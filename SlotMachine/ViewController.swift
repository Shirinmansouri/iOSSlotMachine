//
//  ViewController.swift
//  SlotMachine
//
//  Created by Sorena Sorena on 2022-02-16.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var showPayout: UILabel!
    
    @IBOutlet weak var showJackpot: UILabel!
    
    var listOfInfoToShow : [Info] = []
    var userDefaultsToShow = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        var lastJack : Int
        var lastPoint : Int
        
        do{
            let aux = userDefaultsToShow.data(forKey: "Info")!
            listOfInfoToShow = try decoder.decode([Info].self, from: aux)
            lastJack = (listOfInfoToShow[listOfInfoToShow.count-1] as Info).jack
            lastPoint = (listOfInfoToShow[listOfInfoToShow.count-1] as Info).point
            showPayout.text = String(lastPoint)
            showJackpot.text = String(lastJack)
            
        }
        catch{
            print("Unable to encode: (\(error))")
        }
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
