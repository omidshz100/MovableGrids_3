//
//  Testing.swift
//  MovableGrids_3
//
//  Created by Omid Shojaeian Zanjani on 31/01/24.
//

import Foundation



func age( completion: @escaping (Int) -> Void) {
    
    DispatchQueue.main.asyncAfter(deadline: DispatchTime(uptimeNanoseconds: 1_000_000_000), execute: {
        completion(10)
    })
}
