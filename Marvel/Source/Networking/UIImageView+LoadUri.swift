import UIKit
private let imageCache = NSCache<AnyObject, UIImage>()

extension UIImageView {

    func load(urlString: String, resize: CGSize? = nil, completion: (() -> Void)? = nil) {
        restorationIdentifier = urlString

        if let cached = imageCache.object(forKey: NSString(string: urlString)) {
            self.image = cached
            completion?()
            return
        }

        DispatchQueue.global().async { [weak self] in
            guard let url = URL(string: urlString) else { return }
            guard let data = try? Data(contentsOf: url) else { return }
            guard let downloadedImage = UIImage(data: data) else { return }

            let image = resize.flatMap {
                return self?.resizeImage(image: downloadedImage, targetSize: $0)
            } ?? downloadedImage

            DispatchQueue.main.async {
                guard self?.restorationIdentifier == urlString else { return print("exit") }
                self?.image = image
                imageCache.setObject(image, forKey: NSString(string: urlString))
                completion?()
            }
        }
    }

    #warning("test it")
    // https://stackoverflow.com/questions/31314412/how-to-resize-image-in-swift
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size

        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height

        var newSize: CGSize
        if widthRatio > heightRatio {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }

        let edge = min(newSize.width, newSize.height)
        newSize = CGSize(width: edge, height: edge)
        let rect = CGRect(origin: .zero, size: newSize)

        UIGraphicsBeginImageContextWithOptions(newSize, false, 2.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }
}
