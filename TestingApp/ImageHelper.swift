//
//  ImageHelper.swift
//  TestingApp
//
//  Created by C4Q on 4/25/18.
//  Copyright © 2018 Fr0st. All rights reserved.
//

import Foundation
import UIKit

enum ImageError: Error {
    case badUrl
    case badData
}

class ImageHelper {
    private init() {}
    static let manager = ImageHelper()
    func getImage(from urlStr: String,
                  completionHandler: @escaping (UIImage) -> Void,
                  errorHandler: @escaping (Error) -> Void) {
        guard let url = URL(string: urlStr) else {
            errorHandler(ImageError.badUrl)
            return
        }
        let completion = {(data: Data) in
            if let onlineImage = UIImage(data: data) {
                completionHandler(onlineImage)
            } else {
                errorHandler(ImageError.badData)
            }
        }
        let request = URLRequest(url: url)
        NetworkHelper.manager.performDataTask(with: request,
                                              completionHandler: completion,
                                              errorHandler: errorHandler)
    }
}

class NSCacheHelper {
    private init() {}
    static let manager = NSCacheHelper()
    private var myCache = NSCache<NSString, UIImage>()
    func addImage(with urlStr: String, and image: UIImage) {
        myCache.setObject(image, forKey: urlStr as NSString)
    }
    func getImage(with urlStr: String) -> UIImage? {
        return myCache.object(forKey: urlStr as NSString)
    }
}
