
import XCTest
@testable import Reciplease

class FavoriteRecipeTestCase: XCTestCase {

    /// test FavoriteRecipe.all
    func testGivenFavoritesRecipesWhenCompareThenEqual() {
        let allFavoritesRecipes = FavoriteRecipe.all
        
        let storageManager = StorageManager()
        
        XCTAssertEqual(allFavoritesRecipes, storageManager.fetchAllFavoritesRecipes())
    }
}
