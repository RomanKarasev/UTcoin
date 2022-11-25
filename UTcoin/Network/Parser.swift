//
//  Parser.swift
//  UTcoin
//
//  Created by Роман Карасёв on 24.11.2022.
//

import Foundation

//MARK: - Parser

final class Parser {
    
    // MARK: signIn
    
    static func signIn(number: String, completion: @escaping (Number) -> Void) {
        let urlString = "https://utcoin.one/loyality/login_step1?phone=\(number)"
        
        guard let url = URL(string: urlString) else { return }
        
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let responseObject = try JSONDecoder().decode(Number.self, from: data)
                completion(responseObject)
            } catch let error as NSError {
                print(error.userInfo)
            }
        }
        task.resume()
    }
    
    // MARK: Verification
    
    static func verification(number: String, verificationCode: String, completion: @escaping (Number) -> Void) {
        let urlString = "https://utcoin.one/loyality/login_step2?phone=\(number)&password=\(verificationCode)"
        
        guard let url = URL(string: urlString) else { return }
        
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let responseObject = try JSONDecoder().decode(Number.self, from: data)
                completion(responseObject)
            } catch let error as NSError {
                print(error.userInfo)
            }
        }
        task.resume()
    }
    
    //MARK: Search
    
    static func searchResult(searchResult: String, completion: @escaping (Results) -> Void) {
        let urlString = "https://utcoin.one/loyality/search?search_string=\(searchResult.replacingOccurrences(of: " ", with: "+"))"
        
        guard let url = URL(string: urlString) else { return }
        
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let responseObject = try JSONDecoder().decode(Results.self, from: data)
                completion(responseObject)
            } catch let error as NSError {
                print(error.userInfo)
            }
        }
        task.resume()
    }
}


