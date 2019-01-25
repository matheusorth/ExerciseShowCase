//
//  Networtk.swift
//  ExerciseShowCase
//
//  Created by Matheus Orth on 25/01/19.
//  Copyright © 2019 collab. All rights reserved.
//

import Foundation
import Alamofire

class Network {
    typealias ResultBlock<T: Codable> = ((NetworkResult<T>) -> ())
    typealias ErrorBlock = ((Error?)->())
    
    private static let baseURL = "https://wger.de/api/v2/"
    
    static func retrieveExercises(_ customUrl: String? = nil, resultBlock: @escaping ResultBlock<Exercise>, errorBlock: @escaping ErrorBlock) {
        let url = customUrl ?? (baseURL + Endpoint.equipments.rawValue + "/?status=2")
        decodableAlamofireResponse(url, resultBlock, errorBlock)
    }
    
    static func retrieveCategories(resultBlock: @escaping ResultBlock<ExerciseCategory>, errorBlock: @escaping ErrorBlock) {
        let url = baseURL + Endpoint.categories.rawValue
        decodableAlamofireResponse(url, resultBlock, errorBlock)
    }
    
    static func retrieveMuscles(resultBlock: @escaping ResultBlock<Muscle>, errorBlock: @escaping ErrorBlock) {
        let url = baseURL + Endpoint.muscle.rawValue
        decodableAlamofireResponse(url, resultBlock, errorBlock)
    }
    
    static func retrieveEquipament(resultBlock: @escaping ResultBlock<Equipment>, errorBlock: @escaping ErrorBlock) {
        let url = baseURL + Endpoint.equipments.rawValue
        decodableAlamofireResponse(url, resultBlock, errorBlock)
    }
    
    private static func decodableAlamofireResponse<T: Codable>(_ url: String, _ resultBlock: @escaping ResultBlock<T>, _ errorBlock: @escaping ErrorBlock) {
        Alamofire.request(baseURL).responseDecodable { (response: DataResponse<NetworkResult<T>>) in
            switch response.result {
            case .success(let value):
                resultBlock(value)
            case .failure(let error):
                errorBlock(error)
            }
        }
    }
    
    private enum Endpoint: String {
        case exercise, muscle, categories, equipments
    }
    
}


// MARK: - Alamofire response handlers

fileprivate func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

extension DataRequest {
    fileprivate func decodableResponseSerializer<T: Decodable>() -> DataResponseSerializer<T> {
        return DataResponseSerializer { _, response, data, error in
            guard error == nil else { return .failure(error!) }
            
            guard let data = data else {
                return .failure(AFError.responseSerializationFailed(reason: .inputDataNil))
            }
            
            return Result { try newJSONDecoder().decode(T.self, from: data) }
        }
    }
    
    @discardableResult
    fileprivate func responseDecodable<T: Decodable>(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<T>) -> Void) -> Self {
        return response(queue: queue, responseSerializer: decodableResponseSerializer(), completionHandler: completionHandler)
    }
}
