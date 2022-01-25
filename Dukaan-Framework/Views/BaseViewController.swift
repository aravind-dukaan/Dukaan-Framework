//
//  BaseViewController.swift
//  Dukaan
//
//  Created by Srinivas on 07/12/21.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    
    var loadingView: UIView?
    
    /// Called when the interactive view controller popping gesture is attempted from the right hand side.
    /// The view controller should override this if it wants to change its behaviour.
    ///
    /// - Returns: true if you want to prevent the interactive gesture.
    func preventInteractivePopGesture() -> Bool {
        let isNavBarVisible: Bool = navigationController?.isNavigationBarHidden == false
        let isBackButtonVisible: Bool = self.navigationItem.leftBarButtonItem != nil
        let isLoading: Bool = loadingView != nil
        
        if isNavBarVisible && isBackButtonVisible, isLoading == false {
            // Allow the user to swipe back
            return false
        }
        
        // Prevent all other cases unless it is specific to the view controller.
        // In which case they can override this method and return a custom result
        return true
    }
}
