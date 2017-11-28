//
//  SideMenuViewController.swift
//  goTalk
//
//  Created by Fahd CHAUDHRY on 2017-11-27.
//  Copyright © 2017 The Night Owls. All rights reserved.
//

import UIKit

class sideMenuController: UITableViewController {
    
    @IBOutlet var sideMenu: UITableView!
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(indexPath.row)
        
        // Navigate to different pages from the Side Menu
        switch indexPath.row {
            
            // Sync
            case 1:
                break
            
            // Settings
            //case 2:
            
            // Help
            //case 3:
            
            // About
            //case 4:
            
        // Log Out
        case 5:
            print("Log Out Executed")
            
            
        default: break
        }
    }
}

