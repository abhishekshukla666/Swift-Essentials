//
//  PhotoListViewModel.swift
//  PicsumPhotos
//
//  Created by Abhishek Shukla on 02/02/24.
//

import Foundation

protocol PhotoViewModelOutput: AnyObject {
    func returnPhotoModel(with value: [Photo])
    func showError(with error: String)
}

protocol PhotoViewModelProcol {
    var output: PhotoViewModelOutput? { get set }
    
    func getPhotoImage(with url: String)
}

class PhotoListViewModel: PhotoViewModelProcol {
    
    private var httpClient: HttpClientProtocol
    weak var output: PhotoViewModelOutput?
    
    init(httpClient: HttpClientProtocol) {
        self.httpClient = httpClient
    }
    
    var photoModel: Observable<[Photo]> = Observable(.init())
    
    func getPhotoImage(with url: String) {
        
        guard let url = URL(string: url) else {
            self.output?.showError(with: PPError.urlNotValid.localizedDescription)
            return
        }
        
        httpClient.fetch(url: url) { [weak self] (response: Result<[Photo], PPError>) in
            
            switch response {
            case .success(let photoModel):
                self?.photoModel.value = photoModel
            case .failure(let error): break
                self?.output?.showError(with: error.localizedDescription)
            }
        }
    }
}
