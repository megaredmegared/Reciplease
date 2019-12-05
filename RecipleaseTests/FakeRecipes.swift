//
//  FakeRecipes.swift
//  RecipleaseTests
//
//  Created by megared on 05/12/2019.
//  Copyright © 2019 OpenClassrooms. All rights reserved.
//

import Foundation
@testable import Reciplease

let ingredients1 = [IngredientAPI(text: "2 tablespoons Dijon mustard"),
                    IngredientAPI(text: "1 tablespoon olive oil"),
                    IngredientAPI(text: "4 plum tomatoes, thinly sliced lengthwise"),
                    IngredientAPI(text: "Salt and pepper")]

let recipe1 = Recipe(label: "Chicken and Pineapple Salad",
                     image: "https://www.edamam.com/web-img/32f/32ff6ade97abfba5fa6ce9656a6d63f1.jpg",
                     uri: "http://www.edamam.com/ontologies/edamam.owl#recipe_7e9c0405a5a5992407e1d7878f20ef74",
                     url: "http://www.marthastewart.com/315443/chicken-and-pineapple-salad",
                     shareAs: "http://www.edamam.com/recipe/chicken-and-pineapple-salad-7e9c0405a5a5992407e1d7878f20ef74/chicken%2C+tomato%2C+pineapple",
                     ingredients: ingredients1,
                     totalTime: 20.0)

let ingredients2 = [IngredientAPI(text: "2 pieces grilled chicken breast"),
                    IngredientAPI(text: "1 tablespoon soy vay teriyaki sauce (or your preference)"),
                    IngredientAPI(text: "2 cups arugula")]

let recipe2 = Recipe(label: "ASIAN CHICKEN SALAD WITH GRILLED PINEAPPLE",
                     image: "https://www.edamam.com/web-img/385/385542420abc3b18b95524f15fcbd241.jpg",
                     uri: "http://www.edamam.com/ontologies/edamam.owl#recipe_2b1e27b21abfacab4e81b4b220ee9225",
                     url: "https://food52.com/recipes/16604-asian-chicken-salad-with-grilled-pineapple",
                     shareAs: "http://www.edamam.com/recipe/asian-chicken-salad-with-grilled-pineapple-2b1e27b21abfacab4e81b4b220ee9225/chicken%2C+tomato%2C+pineapple",
                     ingredients: ingredients2,
                     totalTime: 313.0)

let ingredients3 = [IngredientAPI(text: "1 lb. ripe tomatoes"),
                    IngredientAPI(text: "2 c. chopped fresh pineapple"),
                    IngredientAPI(text: "2 tsp. chopped fresh tarragon leaves")]

let recipe3 = Recipe(label: "Pineapple-Tomato Salsa",
                     image: "https://www.edamam.com/web-img/0f2/0f27daa0493617c2e5b8845c7950b35b.jpg",
                     uri: "http://www.edamam.com/ontologies/edamam.owl#recipe_a4e07b291115a2d2409a30ef8e6ff027",
                     url: "http://www.goodhousekeeping.com/food-recipes/a8853/pineapple-tomato-salsa/",
                     shareAs: "http://www.edamam.com/recipe/pineapple-tomato-salsa-a4e07b291115a2d2409a30ef8e6ff027/chicken%2C+tomato%2C+pineapple",
                     ingredients: ingredients3,
                     totalTime: 15.0)

let imageData = "image".data(using: .utf8)!
let imageThumbnailData = "imageThumbnail".data(using: .utf8)!

