//
//  ImageAsset.swift
//  ToDo
//
//  Created by Jony Tucci on 8/4/19.
//  Copyright © 2019 Jony Tucci. All rights reserved.
//

import UIKit

extension UIImage {
    
    enum ToDo {
        
        // Used if requested image is not found
        private static var defaultImage = UIImage()
        
        static var listIcon: UIImage {
            return UIImage(named: "list-icon") ?? defaultImage
        }
        
        static var uncheckedBox: UIImage {
            return UIImage(named: "unchecked-box") ?? defaultImage
        }
        
        static var checkedBox: UIImage {
            return UIImage(named: "checked-box") ?? defaultImage
        }
        
        static var trash: UIImage {
            return UIImage(named: "trash-icon-white") ?? defaultImage
        }
        
        static var settings: UIImage {
            return UIImage(named: "settings-icon") ?? defaultImage
        }
        
        static var calendar: UIImage {
            return UIImage(named: "calendar") ?? defaultImage
        }
        
        
    }
    
    
}
