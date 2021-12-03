//
//  ImageCache.swift
//  MovieBrowser
//
//  Created by Kevin Varghese on 12/2/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import Foundation

final class ImageCache {
    
    static let shared = ImageCache()
    
    private let cache: NSCache<NSString, NSData>
    
    private init(cache: NSCache<NSString, NSData> = NSCache<NSString, NSData>()) {
        self.cache = cache
    }

}

extension ImageCache {
    
    func getData(with key: String) -> Data? {
        let _key = NSString(string: key)
        guard let _data = self.cache.object(forKey: _key) else { return nil }
        return Data(referencing: _data)
    }
    
    func setData(with key: String, data: Data) {
        let _key = NSString(string: key)
        let _data = NSData(data: data)
        self.cache.setObject(_data, forKey: _key)
    }
    
    
}
