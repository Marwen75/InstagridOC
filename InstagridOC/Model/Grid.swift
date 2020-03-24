//
//  Application.swift
//  InstagridOC
//
//  Created by Marwen Haouacine on 19/03/2020.
//  Copyright © 2020 marwen. All rights reserved.
//

struct Grid {
    
    var disposition: Disposition
    var photoUploaded = false 
    
    enum Disposition {
        
        case down, up, plain
    }
    
}
