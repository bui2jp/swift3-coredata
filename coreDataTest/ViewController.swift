//
//  ViewController.swift
//  coreDataTest
//
//  Created by Takuya on 2017/06/13.
//  Copyright © 2017 Takuya. All rights reserved.
//

import UIKit
import CoreData
//import AssetsLibrary
import Photos

class ViewController: UIViewController {


    @IBAction func savePHAsset(_ sender: Any) {
        print(#function)
        
        
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        let fetchResult = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: fetchOptions)
        let lastImageAsset = fetchResult.lastObject
        let localid = lastImageAsset?.localIdentifier
        
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let viewContext = appDelegate.persistentContainer.viewContext
        let tweet = NSEntityDescription.entity(forEntityName: "EntityVeg", in: viewContext)
        let newRecord = NSManagedObject(entity: tweet!, insertInto: viewContext)
        newRecord.setValue("saved PHAsset", forKey: "name") //値を代入
        newRecord.setValue(Date(), forKey: "dateST")//値を代入
        
        //let data = NSKeyedArchiver.archivedData(withRootObject: lastImageAsset?.classForKeyedArchiver ?? nil)
        newRecord.setValue(localid, forKey: "assetLocalId")//Binaryを代入
        
        do {
            //try mapper.save()
            try viewContext.save()
        } catch {
        }
    }

    @IBOutlet weak var myImage: UIImageView!
    
    @IBAction func loadPHAsset(_ sender: Any) {
        //fetchAssetCollectionsWithLocalIdentifiers:options:
        //Optional("saved PHAsset") Optional(2017-06-14 02:56:51 +0000) 
        //Optional("99D53A1F-FEEF-40E1-8BB3-7DD55A43C8B7/L0/001")
        //LocalIdentifiers
        
        
        //Assetを取り出す
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        //let fetchResult = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: fetchOptions)
        //"99D53A1F-FEEF-40E1-8BB3-7DD55A43C8B7/L0/001"
        //let fetchResult = PHAsset.fetchAssets(withLocalIdentifiers: ["99D53A1F-FEEF-40E1-8BB3-7DD55A43C8B7/L0/001"], options: nil)
        let fetchResult = PHAsset.fetchAssets(withLocalIdentifiers: ["9F983DBA-EC35-42B8-8773-B597CF782EDD/L0/001"], options: nil)
        
        let lastImageAsset = fetchResult.lastObject!
        
        //Imageを取り出す
        PHImageManager().requestImage(for: lastImageAsset, targetSize: PHImageManagerMaximumSize, contentMode: PHImageContentMode.aspectFill, options: nil, resultHandler: {(image, info)in
            print("...got image...")
            print(info)
            
            //self.imgThumbnail = UIImageView(image: result)
            //self.imgThumb.image = image
            self.myImage.image = image
                
            print("...got image...end")
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnCreate(_ sender: Any) {
        print(#function)
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let viewContext = appDelegate.persistentContainer.viewContext
        let tweet = NSEntityDescription.entity(forEntityName: "EntityVeg", in: viewContext)
        let newRecord = NSManagedObject(entity: tweet!, insertInto: viewContext)
        newRecord.setValue("名前", forKey: "name") //値を代入
        newRecord.setValue(Date(), forKey: "dateST")//値を代入
        
        do {
            //try mapper.save()
            try viewContext.save()
        } catch {
        }
    }
    
    @IBAction func btnRead(_ sender: Any) {
        print(#function)
        
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let viewContext = appDelegate.persistentContainer.viewContext
        
        //let query: NSFetchRequest<EntityVeg> = Tweet.fetchRequest()
        let query = NSFetchRequest<EntityVeg>(entityName: "EntityVeg")
        
        do {
            let fetchResults = try viewContext.fetch(query)
            for result: AnyObject in fetchResults {
                let body: String? = result.value(forKey: "name") as? String
                let created_at: Date? = result.value(forKey: "dateST") as? Date
                let localId: String? = result.value(forKey: "assetLocalId") as? String

                print(body,created_at,localId)
            }
        } catch {
        }
        
    }
    
    @IBAction func btnUpdate(_ sender: Any) {
        print(#function)
        
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let viewContext = appDelegate.persistentContainer.viewContext
        //let request: NSFetchRequest<Tweet> = Tweet.fetchRequest()
        let request = NSFetchRequest<EntityVeg>(entityName: "EntityVeg")
        
        do {
            let fetchResults = try viewContext.fetch(request)
            for result: AnyObject in fetchResults {
                let record = result as! NSManagedObject
                record.setValue(Date(), forKey: "dateST")
                record.setValue("changed", forKey: "name")
            }
            try viewContext.save()
        } catch {
        }
        
        
    }
    
    @IBAction func btnDelete(_ sender: Any) {
        print(#function)

        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let viewContext = appDelegate.persistentContainer.viewContext
        
        //let request: NSFetchRequest<Tweet> = tweet.fetchRequest()
        let request = NSFetchRequest<EntityVeg>(entityName: "EntityVeg")
        
        do {
            let fetchResults = try viewContext.fetch(request)
            for result: AnyObject in fetchResults {
                let record = result as! NSManagedObject
                viewContext.delete(record)
            }
            try viewContext.save()
        } catch {
        }
        
    }
    
    
}

