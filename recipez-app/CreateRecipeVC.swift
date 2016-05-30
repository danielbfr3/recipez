//
//  CreateRecipeVC.swift
//  recipez-app
//
//  Created by Daniel Freire on 30/05/16.
//  Copyright © 2016 Daniel Freire. All rights reserved.
//

import UIKit
import CoreData

class CreateRecipeVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var recipeTitle: UITextField!
    @IBOutlet weak var recipeIngredients: UITextField!
    @IBOutlet weak var recipeSteps: UITextField!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeImageButton: UIButton!
    
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        recipeImage.image = image
    }
    
    @IBAction func onCreateRecipeButtonPressed(sender: UIButton) {
        if let title = recipeTitle.text where title != "" {
            if let ingredients = recipeIngredients.text where ingredients != "" {
                if let steps = recipeSteps.text where steps != "" {
                    let app = UIApplication.sharedApplication().delegate as! AppDelegate
                    let context = app.managedObjectContext
                    let entity = NSEntityDescription.entityForName("Recipe", inManagedObjectContext: context)!
                    let recipe = Recipe(entity: entity, insertIntoManagedObjectContext: context)
                    
                    recipe.title = title
                    recipe.ingredients = ingredients
                    recipe.steps = steps
                    recipe.setRecipeImage(recipeImage.image!)
                    
                    context.insertObject(recipe)
                    
                    do {
                        try context.save()
                    } catch {
                        print("could not save")
                    }
                    
                    self.navigationController?.popViewControllerAnimated(true)
                }
            }
        }
    }
    
    @IBAction func onAddImageButtonPressed(sender: UIButton) {
        presentViewController(imagePicker, animated: true, completion: nil)
        recipeImageButton.setTitle("", forState: .Normal)
    }
    
    
}
