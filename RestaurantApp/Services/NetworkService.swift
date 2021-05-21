//
//  NetworkService.swift
//  RestaurantApp
//
//  Created by user191232 on 5/19/21.
//

import Foundation
import Moya

private let apiKey = "foH92Tc9RgIoHoRYLB8ng1f2K8mpm9zSig2qYVsom0wLMUWy1W1sgVsfWtXHkbrFCJDNi6YYbZtHfHcfbUJLg2FEx3j6Vm_Wf8R7428arLdKMLHYlnE7UGoU-synYHYx"

enum YelpService {
    enum BusinessesProvider: TargetType {
        case search(lat: Double, long: Double)
        case details(id: String)
        
        var baseURL: URL {
            return URL(string: "https://api.yelp.com/v3/businesses")!
        }

        var path: String {
            switch self {
            case .search:
                return "/search"
            case let .details(id):
                return "/\(id)"
            }
        }

        var method: Moya.Method {
            return .get
        }

        var sampleData: Data {
            return Data()
        }

        var task: Task {
            switch self {
            case let .search(lat, long):
                return .requestParameters(
                    parameters: ["latitude": lat, "longitude": long, "limit": 10], encoding: URLEncoding.queryString)
            case .details:
                return .requestPlain
            }
            
        }

        var headers: [String : String]? {
            return ["Authorization": "Bearer \(apiKey)"]
        }
    }
}
