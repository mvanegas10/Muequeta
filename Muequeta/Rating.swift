//
//  Rating.swift
//  Muequeta
//
//  Created by Meili Vanegas Hernández on 9/18/16.
//  Copyright © 2016 Meili Vanegas Hernández. All rights reserved.
//

import UIKit

class Rating: NSObject {
    
    // MARK: Encoding files
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("ratingLugares")
    
    // MARK: Estruct for encoding
    
    struct RatingKey {
        static let ratingKey = "rating"
    }
    
    // MARK: Properties
    
    var rating: Int
    
    // MARK: Initialization
    
    init(rating: Int) {
        self.rating = rating
        super.init()
    }
    
    //MARK: Encoding process
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeInteger(rating, forKey: RatingKey.ratingKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let rating = aDecoder.decodeIntegerForKey(RatingKey.ratingKey)
        
        self.init(rating: rating)
    }
}