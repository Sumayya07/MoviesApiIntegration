//
//  apiList.swift
//  ApiIntegration
//
//  Created by Sumayya Siddiqui on 23/03/23.
//

import Foundation

class APIManager {
    static let shared = APIManager()

    let movieApi = "https://api.themoviedb.org/3/genre/movie/list?api_key={{api_key}}&language=en-US"
}