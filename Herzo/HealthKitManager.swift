//
//  HealthKitManager.swift
//  Herzo
//
//  Created by Davide Fucci on 18/04/2017.
//  Copyright © 2017 Davide Fucci. All rights reserved.
//

import UIKit
import HealthKit

class HealthKitManager: NSObject {
    let hkStore = HKHealthStore()
    func authorize() -> Bool {
        var enabled = true
        if HKHealthStore.isHealthDataAvailable() {
            let beats = NSSet(object: HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)!)
            
            hkStore.requestAuthorization(toShare: nil, read: beats as? Set<HKObjectType>) { (success, error) -> Void in
                enabled = success
            }
        }
        else
        {
            enabled = false
        }
        
        return enabled
    }
    
    
    func querySteps() -> Void {
        
        let beatsCount = HKQuantityType.quantityType(
            forIdentifier: HKQuantityTypeIdentifier.heartRate)
    
        let stepsSampleQuery = HKSampleQuery(sampleType: beatsCount!,
                                             predicate: nil,
                                             limit: 100,
                                             sortDescriptors: nil)
        {(query, results, error) in
            if let results = results as? [HKQuantitySample] {
                print("printing results")
                print(results)
            }
            
        }
        
        // Don't forget to execute the Query!
        hkStore.execute(stepsSampleQuery)
    }
}

