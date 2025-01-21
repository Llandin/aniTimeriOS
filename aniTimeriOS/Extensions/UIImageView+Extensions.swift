import UIKit

extension UIImageView {
    func loadImage(from urlString: String?) {
        guard let urlString = urlString,
              let url = URL(string: urlString) else {
            self.image = UIImage(named: "placeholder") // Fallback image
            return
        }
        
        if let cachedData = ImageCache.shared.get(forKey: urlString),
           let image = UIImage(data: cachedData) {
            self.image = image
            return
        }
        
        self.image = UIImage(named: "placeholder") // Show a placeholder while loading
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self,
                  let data = data,
                  error == nil,
                  let image = UIImage(data: data) else { return }
            
            ImageCache.shared.set(data: data, forKey: urlString)
            DispatchQueue.main.async {
                self.image = image
            }
        }.resume()
    }
}
