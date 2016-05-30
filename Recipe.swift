//
//  Recipe.swift
//  recipez-app
//
//  Created by Daniel Freire on 30/05/16.
//  Copyright © 2016 Daniel Freire. All rights reserved.
//

import Foundation
import CoreData
import UIKit


class Recipe: NSManagedObject {
    
    func setRecipeImage(image: UIImage) {
        let data = UIImagePNGRepresentation(image)
        self.image = data
    }
    
    func getRecipeImage() -> UIImage {
        let image = UIImage(data: self.image!)!
        
        return image
    }
    
    func makeRecipeTitleCaps() -> String {
        return self.title!.uppercaseString
    }

}
