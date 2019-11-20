//
//  StorageManagerTestCase.swift
//  RecipleaseTests
//
//  Created by megared on 15/11/2019.
//  Copyright © 2019 OpenClassrooms. All rights reserved.
//

import XCTest
import CoreData
@testable import Reciplease

class StorageManagerTestCase: XCTestCase {
    
    var storageManager: StorageManager?
    
    var managedObjectModel: NSManagedObjectModel = {
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle.main])!
        return managedObjectModel
    }()
    
    lazy var mockPersistantContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "Reciplease", managedObjectModel: self.managedObjectModel)
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        description.shouldAddStoreAsynchronously = false
        
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { (description, error) in
            // Check if the data store is in memory
            precondition( description.type == NSInMemoryStoreType )
            
            // Check if creating container wrong
            if let error = error {
                fatalError("In memory coordinator creation failed \(error)")
            }
        }
        return container
    }()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        storageManager = StorageManager(container: mockPersistantContainer)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testCheckEmpty() {
           if let storageManager = self.storageManager {
            let rows = storageManager.fetchAllFavoritesRecipes()
               XCTAssertEqual(rows.count, 0)
           }
    }
    
    func testGiven() {
        
    }
       

}
