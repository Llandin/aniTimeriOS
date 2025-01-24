//
//  HomeViewController.swift
//  aniTimeriOS
//
//  Created by Sthashy Vieira on 06/09/24.
//

import UIKit

class HomeViewController: UIViewController, AnimeCollectionViewDelegate {
    
    var viewModel = HomeViewModel()
    var genres = ["action", "romance"] // Add more genres for larger scale
    var homeView: HomeView!

    override func loadView() {
        homeView = HomeView()
        view = homeView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red

        homeView.collectionView.delegate = self
        homeView.collectionView.dataSource = self

        viewModel.onDataUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.homeView.collectionView.reloadData()
            }
        }
        
        // Start fetching all genres data concurrently
        fetchAnimeDataForGenres()
    }

    private func fetchAnimeDataForGenres() {
        let dispatchGroup = DispatchGroup() // Grouping all requests together
        var fetchedData: [String: [Anime]] = [:] // Dictionary to store results by genre

        // For each genre, fetch its data concurrently
        for genre in genres {
            dispatchGroup.enter() // Mark the start of a task

            viewModel.fetchAnimeForGenres(genre: genre) { [weak self] anime in
                guard self != nil else { return }

                // Store the result in the dictionary
                fetchedData[genre] = anime

                // Notify the group that this task is done
                dispatchGroup.leave()

//                // Optionally configure the cell here (not mandatory)
//                if let genreIndex = self.genres.firstIndex(of: genre) {
//                    DispatchQueue.main.async {
//                        if let genreCell = self.homeView.collectionView.cellForItem(at: IndexPath(item: genreIndex, section: 0)) as? GenreCell {
//                            genreCell.configure(with: anime, delegate: self)
//                        }
//                    }
//                }
            }
        }

        // Once all requests are finished, reload the collection view
        dispatchGroup.notify(queue: .main) {
            self.viewModel.animeDataByGenre = fetchedData // Update the ViewModel with all the fetched data
            self.homeView.collectionView.reloadData() // Reload collection view to reflect the changes
        }
    }
}


extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let genre = genres[section]
        let count = viewModel.animeDataForGenre(genre).count
        print("Number of items for genre \(genre): \(count)") // Debug
        return count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GenreCell", for: indexPath) as! GenreCell
        print("cell \(cell)")
        let genre = genres[indexPath.row]
        print("genre \(genre)")
        let animeData = viewModel.animeDataForGenre(genre)
        print("animeData \(animeData)")
        cell.configure(with: animeData, delegate: self)
        return cell
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 200) // Adjust height as needed
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func didSelectAnime(_ anime: Anime) {
           let storyboard = UIStoryboard(name: "AnimeDetailViewController", bundle: nil)
           if let detailVC = storyboard.instantiateViewController(withIdentifier: "AnimeDetailViewController") as? AnimeDetailViewController {
               detailVC.anime = anime // Pass the selected anime to the detail view controller
               navigationController?.pushViewController(detailVC, animated: true)
           }
       }
}
