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
    
    
    func queryHeartRate() -> Void {
        
        let beats = HKQuantityType.quantityType(
            forIdentifier: HKQuantityTypeIdentifier.heartRate)
    
        let beatsSampleQuery = HKSampleQuery(sampleType: beats!,
                                             predicate: nil,
                                             limit: 100,
                                             sortDescriptors: nil)
        {(query, results, error) in
            if let results = results as? [HKQuantitySample] {
               
                for r in results{
                    print(r.quantity.doubleValue(for: HKUnit(from: "count/min")))
                }
            }
        }
        
        // Don't forget to execute the Query!
        hkStore.execute(beatsSampleQuery)
    }
}

