//
//  Breeds.swift
//  catsPOCSwft
//
//  Created by Claudia Cortes on 6/15/22.
//
// Generated by https://quicktype.io

import Foundation

typealias Breeds = [Breed]

struct Breed {
    let adaptability, affectionLevel: Int
    let altNames: String?
    let cfaURL: String?
    let childFriendly: Int
    let countryCode, countryCodes, description: String
    let dogFriendly, energyLevel, experimental, grooming: Int
    let hairless, healthIssues, hypoallergenic: Int
    let id: String
    let image: Image?
    let indoor, intelligence: Int
    let lap: Int?
    let lifeSpan, name: String
    let natural: Int
    let origin: String
    let rare: Int
    let referenceImageID: String?
    let rex, sheddingLevel, shortLegs, socialNeeds: Int
    let strangerFriendly, suppressedTail: Int
    let temperament: String
    let vcahospitalsURL: String?
    let vetstreetURL: String?
    let vocalisation: Int
    let weight: Weight
    let wikipediaURL: String?
    let bidability, catFriendly: Int?
}

struct Image {
    let height: Int?
    let id: String?
    let url: String?
    let width: Int?
}

struct Weight {
    let imperial, metric: String
}