//
//  SearchModels.swift
//  Music(SwiftUI + Alamofire)
//
//  Created by Mikhail on 03.04.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum Search {
   
  enum Model {
    struct Request {
      enum RequestType {
        case getTracks(searchTerm: String)
      }
    }
    struct Response {
      enum ResponseType {
        case presentTracks(searchResponse: SearchResponse?)
        case presentFoterView
      }
    }
    struct ViewModel {
      enum ViewModelData {
        case displayTracks(searchViewModel: SearchViewModel)
        case displayFooterView
      }
    }
  }
}

struct SearchViewModel {
    struct Cell: TrackCellViewModel {
        
        var iconUrlString: String?
        var trackName: String
        var artistName: String
        var collectionName: String
        var previewUrl: String?
    }
    
    let cells: [Cell]
}
