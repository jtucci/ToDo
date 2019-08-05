//
//  Styles.swift
//  ToDo
//
//  Created by Jony Tucci on 8/4/19.
//  Copyright © 2019 Jony Tucci. All rights reserved.
//

import UIKit

extension UIColor {
    enum ToDo {
        
        private static let darkTurqoise: UIColor = #colorLiteral(red: 0.05098039216, green: 0.2, blue: 0.2509803922, alpha: 1)
        private static let turqoise: UIColor = #colorLiteral(red: 0.07201969673, green: 0.2897559313, blue: 0.3654557808, alpha: 1)
        private static let white: UIColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        private static let lightGray: UIColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        private static let gray: UIColor =  #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        private static let red: UIColor = #colorLiteral(red: 0.8881979585, green: 0.3072378635, blue: 0.2069461644, alpha: 1)
        private static let lightBlue: UIColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)

        
        // Navigation bar
        static var navBarColor: UIColor {
            return turqoise
        }
        
        // Text Colors
        static var lightTextColor: UIColor {
            return white
        }
        
        static var darkTextColor: UIColor {
            return gray
        }
        
        static var systemTextColor: UIColor {
            return lightBlue
        }
        
        // Cell Colors
        static var lightCellBackgroundColor: UIColor {
            return white
        }
        
        static var darkCellBackGroundColor: UIColor {
            return darkTurqoise
        }
        
        static var deleteSwipeBackgroundColor: UIColor {
            return red
        }
        
        static var editSwipeBackgroundColor: UIColor {
            return lightBlue
        }
        
        
        // table Background colors
        static var backgroundGradientDark: UIColor {
            return turqoise
        }
        
        static var backgroundGradientLight: UIColor {
            return white
        }
        
        static var lightBackground: UIColor {
            return white
        }
        
        static var darkBackground: UIColor {
            return lightGray
        }
    }
}
