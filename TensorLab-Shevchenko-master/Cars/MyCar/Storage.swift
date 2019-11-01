//
//  Storage.swift
//  AutoCatalog
//
//  Created by Гость on 24/10/2019.
//  Copyright © 2019 sia. All rights reserved.
//

import Foundation


private let fileURL = URL(fileURLWithPath: "/Users/user/Desktop/TensorLab-Shevchenko-master/Cars/cars.txt")

class Storage {
    internal private(set) var cars: [Car] = []
    
    func addCar(_ car: Car) {
        cars.append(car)
        save()
    }
    
    func addCarByI(car: Car, index: Int){
        cars.insert(car, at: index - 1)
        save()
    }
    
    func removeCarByN(_ carForRemove: Car) {
        cars.removeAll { car in
            return car == carForRemove
        }
        save()
    }
    
    func removeCarByI(_ index: Int){
        cars.remove(at: index - 1)
        save()
    }
    
    func save() {
        guard let data = try? JSONEncoder().encode(cars) else {
            fatalError("Can't encode data")
        }
        
        try? data.write(to: fileURL)
    }
    
    func load() {
        
        guard let data = try? Data(contentsOf: fileURL) else {
            print("There is no file, the new one will be created")
            save()
            return
        }
        
        guard let loadedCars = try? JSONDecoder().decode([Car].self, from: data) else {
            print("The file is defected, the new one will be created")
            save()
            return
        }
        
        cars = loadedCars
    }
}
