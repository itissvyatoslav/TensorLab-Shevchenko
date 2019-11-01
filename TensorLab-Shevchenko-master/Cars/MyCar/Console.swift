//
//  Console.swift
//  AutoCatalog
//
//  Created by Гость on 24/10/2019.
//  Copyright © 2019 sia. All rights reserved.
//

class Console {
    private let storage: Storage
    
    init(storage: Storage) {
        self.storage = storage
    }
    
    func run() {
        var isWorked: Bool = true
        while isWorked {
            print("Write command:", separator: "", terminator: "")
            guard let commandOfStr = readLine() else {
                fatalError("Ooops...")
            }
            guard let command = Command(rawValue: commandOfStr) else {
                print("Please write correct command: [\(allCommandsOfStr())]")
                continue
            }
            
            switch command {
            case .exit:
                isWorked = false
            case .print:
                printCarList()
            case .add:
                addCar()
            case .removeByIndex:
                removeCarByI()
            case .removeByName:
                removeCarByN()
            }
        }
    }
    
    private func getIndex() -> Int{
        print("Write index:")
        var index = 0
        while true {
            guard let indexOfStr = readLine(), let newIndex = Int(indexOfStr)  else {
                print("Please write correct index")
                continue
            }
            index = newIndex
            if index > storage.cars.count || index < 1{
                print("Please write correct index:")
            } else {
                break
            }
        }
        return index
    }
    
    private func getString() -> String{
        guard let string = readLine() else {
            fatalError("Ooops...")
        }
        return string
    }
    
    private func allCommandsOfStr() -> String {
        var result: String = ""
        for command in Command.commands {
            result += "'\(command.rawValue)' "
        }
        return result
    }
    
    private func printCarList() {
        if storage.cars.isEmpty {
            print("List is empty")
            return
        }
        
        for (i, car) in storage.cars.enumerated() {
            print("#", i + 1, separator: "")
            print(car)
        }
    }
    
    
    private func addCar() {
        print("Write car name: ", separator: "", terminator: "")
        let carName = getString()
        
        print("Write car year: ", separator: "", terminator: "")
        
        var carYear: Int = 0
        while true {
            guard let carYearOfStr = readLine(), let newCarYear = Int(carYearOfStr) else {
                print("Please write correct year")
                continue
            }
            
            carYear = newCarYear
            break
        }
        
        print("Write car model: ", separator: "", terminator: "")
        let carModel = getString()
        
        print("Do you want to place at certain index?")
        var funcWorked = true
        while funcWorked{
            guard let command = readLine() else {
                fatalError("Ooops...")
            }
            switch command {
            case "yes":
                storage.addCarByI(car: Car(name: carName, year: carYear, model: carModel), index: getIndex())
                funcWorked = false
            case "no":
                storage.addCar(Car(name: carName, year: carYear, model: carModel))
                funcWorked = false
                break
            default:
                print("Write the correct answer")
            }
        }
    }
    
    private func removeCarByI(){
        if storage.cars.isEmpty {
            print("List is empty")
        } else {
            printCarList()
            print("Which one do you want to delete?")
            storage.removeCarByI(getIndex())
        }
    }
    
    private func removeCarByN(){
        if storage.cars.isEmpty {
            print("List is empty")
        } else {
            print("Write the key-word:")
            let keyWord = getString()
            for car in storage.cars{
                guard let keyYear = Int(keyWord) else {
                    if car.name.contains(keyWord) || car.model.contains(keyWord){
                        storage.removeCarByN(car)
                    }
                    continue
                }
                if car.year == keyYear {
                    storage.removeCarByN(car)
                }
            }
        }
    }
}
