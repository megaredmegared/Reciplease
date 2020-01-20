
import XCTest
@testable import Reciplease

class ExtensionModelTestCase: XCTestCase {
    
    // MARK: - Test check if word exist in English
    
    func testGivenEnglishWordWhenCheckedThenTrue() {
        let tomato = "tomato"
        
        let isEnglishWord = tomato.isRealEnglishWord
        
        XCTAssertTrue(isEnglishWord)
    }
    
    func testGivenNotEnglishWordWhenCheckedThenFalse() {
        let tomate = "tomate"
        
        let isEnglishWord = tomate.isRealEnglishWord
        
        XCTAssertFalse(isEnglishWord)
    }
    
    // MARK: - Test Check for string to return only allowed characters
    
    func testGivenCharactersSetWhenCheckedThenReturnOnlyAllowedCharacters() {
        let charactersSet = "ABCdefé'(§LKJfg"
        
        let allowedCharacters = charactersSet.allowedCharacters()
        
        XCTAssertEqual(allowedCharacters, "ABCdefLKJfg")
    }
    
    // MARK: - Test Formating word
    
    func testGivenAWordWhenFormattedThenAFormattedWord() {
        let word = "bana'(§na"
        
        let formatted = word.formatWord()
        
        XCTAssertEqual(formatted, "Banana")
    }
    
    func testGivenANotAuthorizedWordWhenFormattedThenNil() {
        let word = "bana'(§ne"
        
        let formatted = word.formatWord()
        
        XCTAssertNil(formatted)
    }
    
    // MARK: - Test Formating list
    
    func testGivenEnglishWordsComasSeparatedWhenFormattedThenArrayOfWords() {
        let words = "car, banana, tomato, big mac"
        
        let formatted = words.formatList()
        
        XCTAssertEqual(formatted.count, 4)
        XCTAssertTrue(formatted.contains("Big Mac"))
        XCTAssertTrue(formatted.contains("Tomato"))
        XCTAssertTrue(formatted.contains("Banana"))
        XCTAssertTrue(formatted.contains("Car"))
        
    }
    
    // MARK: - Test format Time minute Double to a String in hours and minutes
    
    func testGiven92WhenFormattedThen1hour32mminutes() {
        let minutes = 92.0
        
        let formatted = minutes.formatTime()
        
        XCTAssertEqual(formatted, "1h32m")
        
        //more tests with different values
        XCTAssertEqual(34.0.formatTime(), "34m")
        XCTAssertEqual(60.0.formatTime(), "1h")
        XCTAssertEqual(120.0.formatTime(), "2h")
        XCTAssertEqual(1.formatTime(), "1m")
        XCTAssertNil((-34).formatTime())
        XCTAssertNil(0.0.formatTime())
    }
}
