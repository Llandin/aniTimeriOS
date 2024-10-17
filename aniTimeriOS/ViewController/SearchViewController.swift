//
//  SearchViewController.swift
//  aniTimeriOS
//
//  Created by João Gabriel Lavareda Ayres Barreto on 17/09/24.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {


    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    let allAnime: [MockAnimeData] = mockAnimeList // The full list of mocked anime data
    var filteredAnime: [MockAnimeData] = [] // This will hold the search results

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set up delegates
        tableView.delegate = self
        tableView.dataSource = self
        searchTextField.delegate = self

        // Initialize filtered data with the full list
        filteredAnime = allAnime

        // Register a basic UITableViewCell
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "AnimeCell")

        // Add target for text field editing changed event
        searchTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }

    // MARK: - UITableView DataSource Methods

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredAnime.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnimeCell", for: indexPath)
        let anime = filteredAnime[indexPath.row]
        cell.textLabel?.text = anime.titleRomaji
        return cell
    }

    // MARK: - UITextField Delegate and Editing Changed Event

    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let searchText = textField.text else { return }

        // Filter anime based on the search text
        if searchText.isEmpty {
            filteredAnime = allAnime // If the search text is empty, show all data
        } else {
            filteredAnime = allAnime.filter { $0.titleRomaji.lowercased().contains(searchText.lowercased()) }
        }
        tableView.reloadData() // Refresh the table view with the filtered data
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Dismiss the keyboard when the return key is pressed
        textField.resignFirstResponder()
        return true
    }
}
