
import Foundation
import UIKit

class LazyImageLoader: UIImageView {
    
    var imageCache: NSCache<AnyObject, UIImage>!
    
    func loadImage(fromURL imageUrl: URL, placeHolderImage: String) {
        self.image = UIImage(named: placeHolderImage)
        
        if let image = imageCache.object(forKey: imageUrl as? AnyObject) {
            self.image = image
            return
        }
        
        DispatchQueue.global().async { [weak self] in
            if let imageData = try? Data(contentOf: imageUrl) {
                if let image = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        self?.imageCache = image
                        self?.image = image
                    }
                }
            }
        }
    }
}
