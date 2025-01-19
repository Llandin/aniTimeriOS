//
//  HomeViewController.swift
//  aniTimeriOS
//
//  Created by Sthashy Vieira on 06/09/24.
//

import UIKit

class HomeViewController: UIViewController {

    var viewModel = HomeViewModel()
    var genres = ["action", "fantasy"]
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
        
        fetchAnimeDataForGenres()
    }

    private func fetchAnimeDataForGenres() {
        for genre in genres {
            viewModel.fetchAnimeForGenres(genre: genre) { [weak self] anime in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    if let genreIndex = self.genres.firstIndex(of: genre) {
                        if let genreCell = self.homeView.collectionView.cellForItem(at: IndexPath(item: genreIndex, section: 0)) as? GenreCell {
                            genreCell.configure(with: anime)
                        }
                    }
                    self.homeView.collectionView.reloadData()
                }
            }
        }
    }
}


extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return genres.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GenreCell", for: indexPath) as! GenreCell
        let genre = genres[indexPath.row]
        if let animeData = viewModel.animeDataByGenre[genre] {
            cell.configure(with: animeData)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: collectionView.frame.width, height: 200) // Adjust height as needed
        }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 16
        }
    
}
