
import UIKit
import CoreData

/// Manage stored datas with CoreData
class StorageManager {
    
    let persistentContainer: NSPersistentContainer?
    
    //MARK: Init with dependency
    init(container: NSPersistentContainer) {
        self.persistentContainer = container
        self.persistentContainer?.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    convenience init() {
        //Use the default container for production environment
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Can not get shared app delegate")
        }
        self.init(container: appDelegate.persistentContainer)
    }
    
    lazy var backgroundContext: NSManagedObjectContext = {
        guard let persistentContainer = self.persistentContainer else {
            fatalError()
        }
        return persistentContainer.newBackgroundContext()
    }()
    
    //MARK: - CRUD
    
    /// Create a stored favorite recipe
    func insertFavoriteRecipe(_ recipe: Recipe?, image: Data?, thumbnail: Data?, save: Bool) {
        guard let favoriteRecipe = NSEntityDescription.insertNewObject(forEntityName: "FavoriteRecipe", into: backgroundContext) as? FavoriteRecipe else { return }
        
        let ingredients = recipe?.ingredients
        let ingredientsLines = ingredients?.compactMap({$0.text})
        
        favoriteRecipe.uri = recipe?.uri
        favoriteRecipe.name = recipe?.label
        favoriteRecipe.url = recipe?.url
        favoriteRecipe.shareAs = recipe?.shareAs
        favoriteRecipe.ingredients = ingredientsLines
        favoriteRecipe.imageThumbnail = thumbnail
        favoriteRecipe.image = image
        
        var totalTime = 0.0
        if let time = recipe?.totalTime {
            totalTime = time
        }
        favoriteRecipe.time = totalTime
        
        if save == true {
            self.save()
        }
    }
    
    /// Create a stored ingredient
    func insertIngredient(name: String, save: Bool) {
        guard let ingredient = NSEntityDescription.insertNewObject(forEntityName: "Ingredient", into: backgroundContext) as? Ingredient else { return }
        ingredient.name = name
        
        if save == true {
            self.save()
        }
    }
    
    /// Create stored mutli ingredients
    func insertMultiIngredients(ingredientsNames: [String], save: Bool) {
        for name in ingredientsNames {
            self.insertIngredient(name: name, save: false)
        }
        
        if save == true {
            self.save()
        }
    }
    
    /// Read all favorites recipes
    func fetchAllFavoritesRecipes() -> [FavoriteRecipe] {
        let request: NSFetchRequest<FavoriteRecipe> = FavoriteRecipe.fetchRequest()
        // array of NSSortDescriptors to sort favoritesRecipes by name
        request.sortDescriptors = [
            NSSortDescriptor(key: "name", ascending: true)
        ]
        guard let favortiesRecipes = try? persistentContainer?.viewContext.fetch(request) else {
            return [FavoriteRecipe]()
        }
        return favortiesRecipes
    }
    
    /// Read all ingredients
    func fetchAllIngredients() -> [Ingredient] {
        let request: NSFetchRequest<Ingredient> = Ingredient.fetchRequest()
        //  array of NSSortDescriptors to sort ingredients by name
        request.sortDescriptors = [
            NSSortDescriptor(key: "name", ascending: true)
        ]
        guard let ingredients = try? persistentContainer?.viewContext.fetch(request) else {
            return [Ingredient]()
        }
        return ingredients
    }
    
    /// Save the backgroundContext
    func save() {
        if backgroundContext.hasChanges {
            do {
                try backgroundContext.save()
            } catch {
                print("Save error \(error)")
            }
        }
    }
    
    /// Remove object
    func remove( objectID: NSManagedObjectID, save: Bool ) {
        let obj = backgroundContext.object(with: objectID)
        backgroundContext.delete(obj)
        
        if save == true {
            self.save()
        }
    }
}


