
import XCTest
@testable import Reciplease

class RecipesTestCase: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGivenOneRecipeWhenAddRecipesWith2RecipesThen3Recipes() {
        var recipes = FakeData.recipes2
        XCTAssertEqual(recipes.hits?.count, 1)
        
        recipes.addRecipes(numberOfRecipesLoaded: recipes.hits!.count, recipesResponse: FakeData.recipes3, numberOfRecipesToFetch: 2)
        
        XCTAssertEqual(recipes.count, 203)
        XCTAssertEqual(recipes.from, 1)
        XCTAssertEqual(recipes.to, 3)
        XCTAssertEqual(recipes.hits?.count, 3)
        
        XCTAssertEqual(recipes.hits?[0].recipe?.image, FakeData.recipe1.image)
        XCTAssertEqual(recipes.hits?[0].recipe?.label, FakeData.recipe1.label)
        XCTAssertEqual(recipes.hits?[0].recipe?.shareAs, FakeData.recipe1.shareAs)
        XCTAssertEqual(recipes.hits?[0].recipe?.totalTime, FakeData.recipe1.totalTime)
        XCTAssertEqual(recipes.hits?[0].recipe?.uri, FakeData.recipe1.uri)
        XCTAssertEqual(recipes.hits?[0].recipe?.url, FakeData.recipe1.url)
        XCTAssertEqual(recipes.hits?[0].recipe?.ingredients?[0].text, FakeData.recipe1.ingredients?[0].text)
        XCTAssertEqual(recipes.hits?[0].recipe?.ingredients?[1].text, FakeData.recipe1.ingredients?[1].text)
        XCTAssertEqual(recipes.hits?[0].recipe?.ingredients?[2].text, FakeData.recipe1.ingredients?[2].text)
        XCTAssertEqual(recipes.hits?[0].recipe?.ingredients?[3].text, FakeData.recipe1.ingredients?[3].text)
        XCTAssertEqual(recipes.hits?[1].recipe?.image, FakeData.recipe2.image)
        XCTAssertEqual(recipes.hits?[1].recipe?.label, FakeData.recipe2.label)
        XCTAssertEqual(recipes.hits?[1].recipe?.shareAs, FakeData.recipe2.shareAs)
        XCTAssertEqual(recipes.hits?[1].recipe?.totalTime, FakeData.recipe2.totalTime)
        XCTAssertEqual(recipes.hits?[1].recipe?.uri, FakeData.recipe2.uri)
        XCTAssertEqual(recipes.hits?[1].recipe?.url, FakeData.recipe2.url)
        XCTAssertEqual(recipes.hits?[1].recipe?.ingredients?[0].text, FakeData.recipe2.ingredients?[0].text)
        XCTAssertEqual(recipes.hits?[1].recipe?.ingredients?[1].text, FakeData.recipe2.ingredients?[1].text)
        XCTAssertEqual(recipes.hits?[1].recipe?.ingredients?[2].text, FakeData.recipe2.ingredients?[2].text)
        XCTAssertEqual(recipes.hits?[2].recipe?.image, FakeData.recipe3.image)
        XCTAssertEqual(recipes.hits?[2].recipe?.label, FakeData.recipe3.label)
        XCTAssertEqual(recipes.hits?[2].recipe?.shareAs, FakeData.recipe3.shareAs)
        XCTAssertEqual(recipes.hits?[2].recipe?.totalTime, FakeData.recipe3.totalTime)
        XCTAssertEqual(recipes.hits?[2].recipe?.uri, FakeData.recipe3.uri)
        XCTAssertEqual(recipes.hits?[2].recipe?.url, FakeData.recipe3.url)
        XCTAssertEqual(recipes.hits?[2].recipe?.ingredients?[0].text, FakeData.recipe3.ingredients?[0].text)
        XCTAssertEqual(recipes.hits?[2].recipe?.ingredients?[1].text, FakeData.recipe3.ingredients?[1].text)
        XCTAssertEqual(recipes.hits?[2].recipe?.ingredients?[2].text, FakeData.recipe3.ingredients?[2].text)
        
        // test if recipe is in favourite
        XCTAssertFalse(FakeData.recipe1.isFavorite())
    }
    
    func testGivenOneRecipeWhenAddNoDataRecipeThenOneRecipe() {
        var recipes = FakeData.recipes2
        XCTAssertEqual(recipes.hits?.count, 1)
        
        recipes.addRecipes(numberOfRecipesLoaded: recipes.hits!.count, recipesResponse: nil, numberOfRecipesToFetch: 2)
        
        XCTAssertEqual(recipes.count, 203)
        XCTAssertEqual(recipes.from, 1)
        XCTAssertEqual(recipes.to, 3)
        XCTAssertEqual(recipes.hits?.count, 1)
        XCTAssertEqual(recipes.hits?[0].recipe?.image, FakeData.recipe1.image)
        XCTAssertEqual(recipes.hits?[0].recipe?.label, FakeData.recipe1.label)
        XCTAssertEqual(recipes.hits?[0].recipe?.shareAs, FakeData.recipe1.shareAs)
        XCTAssertEqual(recipes.hits?[0].recipe?.totalTime, FakeData.recipe1.totalTime)
        XCTAssertEqual(recipes.hits?[0].recipe?.uri, FakeData.recipe1.uri)
        XCTAssertEqual(recipes.hits?[0].recipe?.url, FakeData.recipe1.url)
        XCTAssertEqual(recipes.hits?[0].recipe?.ingredients?[0].text, FakeData.recipe1.ingredients?[0].text)
        XCTAssertEqual(recipes.hits?[0].recipe?.ingredients?[1].text, FakeData.recipe1.ingredients?[1].text)
        XCTAssertEqual(recipes.hits?[0].recipe?.ingredients?[2].text, FakeData.recipe1.ingredients?[2].text)
        XCTAssertEqual(recipes.hits?[0].recipe?.ingredients?[3].text, FakeData.recipe1.ingredients?[3].text)
        
        // MARK: - Recipe
        
        // test is in favourite must be false
        if let recipe = recipes.hits?[0].recipe {
            XCTAssertFalse(recipe.isFavorite())
        }
    }

}
