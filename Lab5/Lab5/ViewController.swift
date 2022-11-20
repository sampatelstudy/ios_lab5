//
//  ViewController.swift
//  Lab5
//
//  Created by Samir Patel  on 2022-11-20.
//


import UIKit

class ViewController: UIViewController
{
    fileprivate static let rootKey = "rootKey"
    
    @IBOutlet var lineFields:[UITextField]!

    override func viewDidLoad()
    {
        
       super.viewDidLoad()
       
       let fileURL = self.dataFileURL()
        if (FileManager.default.fileExists(atPath: fileURL.path!))
        {
            
            do
            {
                let data = try Data(contentsOf: fileURL as URL)
                if let lines = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [String]
                {
                    for i in 0..<lines.count
                    {
                        lineFields[i].text = lines[i]
                    }
                }
            }
            catch
            {
                print("Error reading file")
            }
        }
        
        let app = UIApplication.shared
            
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.applicationWillResignActive(notification:)),
            name: UIScene.willDeactivateNotification, object: nil)
    
        
    }
      
    @objc func applicationWillResignActive(notification: NSNotification)
    {
        let fileURL = self.dataFileURL()
        let array = (self.lineFields as NSArray).value(forKey: "text") as! [String]
        
        do
        {
            let data = try NSKeyedArchiver.archivedData(withRootObject: array, requiringSecureCoding: false)
            try data.write(to: dataFileURL() as URL)
        }
        catch
        {
            print("couldn't write to file")
        }

    }
    
    func dataFileURL() -> NSURL {
         let urls = FileManager.default.urls(for:.documentDirectory, in: .userDomainMask)
         var url: NSURL?
         url = URL(fileURLWithPath: "") as NSURL?      // create a blank path
         do {
                url = urls.first?.appendingPathComponent("data1.plist") as NSURL?
         }
         catch {
             print("Error is \(error)")
         }
            
         return url!
        }
}

