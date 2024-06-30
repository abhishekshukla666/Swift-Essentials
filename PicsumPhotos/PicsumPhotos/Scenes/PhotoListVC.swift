//
//  PhotoListVC.swift
//  PicsumPhotos
//
//  Created by Abhishek Shukla on 02/02/24.
//

import UIKit

class PhotoListVC: UIViewController {

    let photoListTableView: UITableView = UITableView()
    var viewModel: PhotoListViewModel!
    var photos = [Photo]()
    var page = 1
    
    fileprivate func configureViewModel() {
        viewModel = PhotoListViewModel(httpClient: HttpClient(urlsession: URLSession(configuration: .default)))
        viewModel.getPhotoImage(with: "\(EndPoints.baseUrl.rawValue)list?page=\(page)&limit=100")
        viewModel.photoModel.bind { photos in
            DispatchQueue.main.async {
                self.photos = photos
                self.photoListTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureViewModel()
        configureTableView()
        let csv = ParsePerson.shared
        csv.loadCSV()
        print(csv.persons)
        
    }

    private func configureConstraintToView() {
        NSLayoutConstraint.activate([
            photoListTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            photoListTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            photoListTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            photoListTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
    
    private func configureTableView() {
        self.title = "Picsum"
        photoListTableView.delegate = self
        photoListTableView.dataSource = self
        photoListTableView.separatorStyle = .none
        view.addSubview(photoListTableView)
        photoListTableView.register(PPItemCell.self, forCellReuseIdentifier: PPItemCell.reuse)
        photoListTableView.translatesAutoresizingMaskIntoConstraints = false
        
        configureConstraintToView()
    }
}

//extension PhotoListVC: PhotoViewModelOutput {
//    func returnPhotoModel(with value: [Photo]) {
//        DispatchQueue.main.async {
//            self.photos = value
//            self.photoListTableView.reloadData()
//        }
//    }
//    func showError(with error: String) {
//        print("❌ \(error)")
//    }
//}

extension PhotoListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 320
    }
}

extension PhotoListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PPItemCell.reuse, for: indexPath) as? PPItemCell else {
            return UITableViewCell()
        }
        cell.setPhoto(with: photos[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let photoObj = photos[indexPath.row]
        // Passing the param in one model
        let detailsVC = PhotoDetailsVC()
        detailsVC.imageDownloadUrl  = photoObj.download_url
        detailsVC.authorName.text   = photoObj.author
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}

struct Person {
    var firstName: String
    var lastName: String
    var age: Int
    var isRegistered: Bool
}


class ParsePerson {
    
    static let shared = ParsePerson()
    private init() {}
    
    var persons = [Person]()
    
    func loadCSV() {
        guard let filePath = Bundle.main.path(forResource: "data", ofType: "csv") else { return }
        
        // convert the data into long string
        var stringData = ""
        do {
            stringData = try String(contentsOfFile: filePath)
        } catch {
            print("❌ \(error)")
            return
        }
        
        var rows = stringData.components(separatedBy: "\n")
        rows.removeFirst()
        
        for row in rows {
            let columns = row.components(separatedBy: ",")
            guard columns.count == 4 else { return }
            let firstName   = columns[0]
            let lastName    = columns[1]
            let age         = Int(columns[2]) ?? 0
            let restrictred = columns[3] == "True"
            
            let person = Person(firstName: firstName, lastName: lastName, age: age, isRegistered: restrictred)
            persons.append(person)
        }
    }
}
