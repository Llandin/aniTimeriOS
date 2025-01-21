//
//  ImageCache.swift
//  aniTimeriOS
//
//  Created by João Gabriel Lavareda Ayres Barreto on 20/01/25.
//


import UIKit

class ImageCache {
    static let shared = ImageCache()

    private let memoryCache = NSCache<NSString, UIImage>()
    private let fileManager = FileManager.default
    private let diskCacheURL: URL

    private init() {
        // Set up the disk cache directory
        let cachesDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!
        diskCacheURL = cachesDirectory.appendingPathComponent("ImageCache", isDirectory: true)
        try? fileManager.createDirectory(at: diskCacheURL, withIntermediateDirectories: true)
    }

    // Retrieve an image from cache
    func getImage(forKey key: String) -> UIImage? {
        // Check memory cache first
        if let cachedImage = memoryCache.object(forKey: key as NSString) {
            return cachedImage
        }
        // Check disk cache if not in memory
        let fileURL = diskCacheURL.appendingPathComponent(key)
        if let diskImage = UIImage(contentsOfFile: fileURL.path) {
            memoryCache.setObject(diskImage, forKey: key as NSString) // Store in memory for future use
            return diskImage
        }
        return nil
    }

    // Save an image to cache
    func saveImage(_ image: UIImage, forKey key: String) {
        // Save to memory cache
        memoryCache.setObject(image, forKey: key as NSString)
        // Save to disk cache
        let fileURL = diskCacheURL.appendingPathComponent(key)
        if let imageData = image.jpegData(compressionQuality: 1.0) {
            try? imageData.write(to: fileURL, options: .atomic)
        }
    }
}

extension ImageCache {
    /// Cleans up the disk cache by removing old files or excess files if cache size exceeds the limit.
    func cleanDiskCache(maxAge: TimeInterval = 7 * 24 * 60 * 60, maxSize: Int = 50 * 1024 * 1024) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }
            
            let fileManager = FileManager.default
            let currentTimestamp = Date().timeIntervalSince1970
            var totalSize = 0
            
            do {
                // Get all files in the disk cache directory
                let files = try fileManager.contentsOfDirectory(at: self.diskCacheURL, includingPropertiesForKeys: [.creationDateKey, .fileSizeKey], options: .skipsHiddenFiles)
                
                // Sort files by creation date (oldest first)
                let sortedFiles = files.sorted {
                    let date1 = (try? $0.resourceValues(forKeys: [.creationDateKey]).creationDate?.timeIntervalSince1970) ?? 0
                    let date2 = (try? $1.resourceValues(forKeys: [.creationDateKey]).creationDate?.timeIntervalSince1970) ?? 0
                    return date1 < date2
                }
                
                for file in sortedFiles {
                    // Check file size and age
                    let resourceValues = try file.resourceValues(forKeys: [.creationDateKey, .fileSizeKey])
                    let fileSize = resourceValues.fileSize ?? 0
                    let fileCreationDate = resourceValues.creationDate?.timeIntervalSince1970 ?? 0
                    
                    totalSize += fileSize
                    
                    // Delete files older than maxAge
                    if currentTimestamp - fileCreationDate > maxAge {
                        try fileManager.removeItem(at: file)
                        totalSize -= fileSize
                    }
                    
                    // Stop deleting if total size is within maxSize
                    if totalSize <= maxSize {
                        break
                    }
                }
            } catch {
                print("Error cleaning disk cache: \(error.localizedDescription)")
            }
        }
    }
}
