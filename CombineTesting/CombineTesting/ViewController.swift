//
//  ViewController.swift
//  CombineTesting
//
//  Created by Antoine van der Lee on 13/06/2019.
//  Copyright © 2019 Antoine van der Lee. All rights reserved.
//

import UIKit
import Combine

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        publisherInitialisers()
        operators()
    }
    
    private func publisherInitialisers() {
        /*:
         ##### Initialisers
         */
        
        let justExample = Publishers.Just(28)
        _ = justExample.sink(receiveValue: { print($0) })
        
        let emptyExample = Publishers.Empty<Any, Error>()
        _ = emptyExample.sink(receiveValue: { print($0) })
        
        let sequenceExample = Publishers.Sequence<[Int], Error>(sequence: [0, 1, 2, 3, 4])
        _ = sequenceExample.sink(receiveValue: { print($0) })
        
        let futureExample = Publishers.Future { (subscriber: @escaping (Result<String, Error>) -> Void) in
            subscriber(.success("Success"))
        }
        _ = futureExample.sink(receiveValue: { print($0) })
        
        let optionalExample = Publishers.Optional<String?, Error>("Maybe")
        _ = optionalExample.sink(receiveValue: { print($0 ?? "") })
    }

    private func operators() {
        /*:
         ##### flatMap
         */
        
        let flatMapExample = Publishers.Sequence<[Int], Error>(sequence: [0, 1, 2])
        _ = flatMapExample.replaceError(with: 0).flatMap { (value) -> Publishers.Just<Int> in
            return Publishers.Just(value * 2)
        }.sink { print($0) }
        
        /*:
         ##### Sink
         */
        
        let sinkExample = Publishers.Just("Sink Example")
        _ = sinkExample.sink { (value) in
            print(value)
        }
    }

}

