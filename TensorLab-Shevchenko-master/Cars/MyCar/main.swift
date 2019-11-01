//
//  main.swift
//  AutoCatalog
//
//  Created by Ивлев А.Е. on 22/10/2019.
//  Copyright © 2019 Ивлев А.Е. All rights reserved.
//

let storage = Storage()

storage.load()

let console = Console(storage: storage)
console.run()

storage.save()
