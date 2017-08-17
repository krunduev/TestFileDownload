//
//  ViewController.swift
//  TestFileDownload
//
//  Created by Kostyantyn Runduyev on 8/17/17.
//  Copyright © 2017 CuriousIT. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let file = "0-breishit-1.html"
        
        let directory = "chumash"
        
        let remotePath = URL(fileURLWithPath: "http://server.chitas.mobi/")
        
        Alamofire.request(remotePath.appendingPathComponent(directory).appendingPathComponent(file)).responseString(encoding: String.Encoding.utf8) { response in
            print("Success: \(response.result.isSuccess)")
            
            let fileString = response.result.value?.utf8
            
            print("Response String: \(fileString)")
            
            //this is the file. we will write to and read from it
            
            if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                
                let path = dir.appendingPathComponent(directory).appendingPathComponent(file)
                
                print(path.absoluteString)
                
                do {
                    print(dir.appendingPathComponent(directory, isDirectory: true).path)
                    
                    try FileManager.default.createDirectory(atPath: dir.appendingPathComponent(directory, isDirectory: true).path, withIntermediateDirectories: true, attributes: nil)

                } catch let error as NSError {
                    print(error.localizedDescription);
                }
                
                //writing
                do {
                    try fileString.write(to: path, atomically: true, encoding: String.Encoding.utf8)
                }
                catch { print("Error") }
                
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

