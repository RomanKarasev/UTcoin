//
//  SearchViewController.swift
//  UTcoin
//
//  Created by Роман Карасёв on 23.11.2022.
//


import UIKit

//MARK: - SearchViewController
class SearchViewController: UIViewController {
    
    // MARK: Properties
    var campanaign       = [Campaign]()
    var products         = [Product]()
    var verificationCode = ""
    var timer            : Timer?
    let searchController = UISearchController(searchResultsController: nil)
    
    
    //MARK: Views
    
    private let searchView = SearchView()
    
    // MARK: View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setDelegates()
        setSearch()
    }
    
    override func loadView() {
        super.loadView()
        view = searchView
    }
    
    
    // MARK: - Private Methods
    
    private func setView() {
        navigationController?.navigationBar.tintColor          = Constants.Colors.mainColor
        navigationController?.navigationBar.prefersLargeTitles = false
        
        navigationController?.navigationItem.largeTitleDisplayMode = .never
    }
    
    private func setSearch() {
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder                = Constants.Strings.searchPlaceholder
        navigationItem.searchController                       = searchController
        navigationItem.hidesSearchBarWhenScrolling            = false
        searchController.searchBar.delegate                   = self
        definesPresentationContext                            = true
    }
    
    private func setDelegates() {
        searchView.shopCollectionView.delegate   = self
        searchView.shopCollectionView.dataSource = self
        searchView.itemTableView.delegate        = self
        searchView.itemTableView.dataSource      = self
    }
}

//MARK: - UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let searchResult = searchController.searchBar.text {
            timer?.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false , block: { (_) in
                
                Parser.searchResult(searchResult: searchResult) { results in
                    self.campanaign = results.campaigns
                    self.products   = results.products
                    DispatchQueue.main.async {
                        if results.campaigns.count == 0 {
                            self.searchView.shopCollectionViewHeightConstraint?.constant = 0
                        } else {
                            self.searchView.shopCollectionViewHeightConstraint?.constant = 200
                        }
                        self.searchView.itemTableView.reloadData()
                        self.searchView.shopCollectionView.reloadData()
                    }
                }
            })
        }
    }
}

// MARK: - UICollectionViewDataSource

extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        campanaign.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShopCollectionViewCell.identifier,
                                                            for: indexPath) as? ShopCollectionViewCell else { return UICollectionViewCell() }
        cell.render(from: CompaignModelView(from: campanaign, index: indexPath))
        return cell
    }
    
}

//MARK - UICollectionViewDelegateFlowLayout

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let margin: CGFloat = 40
        let size: CGFloat   = (collectionView.frame.size.width-margin)/2
        
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
}

// MARK: - UICollectionViewDelegate

extension SearchViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currentCampaign            = campanaign[indexPath.row]
        let viewController             = DetailViewController()
        viewController.currentCampaign = currentCampaign
        navigationController?.pushViewController(viewController, animated: true)
    }
}

//MARK: - UITableViewDataSource
extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ItemTableViewCell.identifier, for: indexPath) as! ItemTableViewCell
        cell.render(from: ProductViewModel(from: products, index: indexPath))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
}

//MARK: - UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentProduct = products[indexPath.row]
        let viewController = DetailViewController()
        viewController.currentProduct = currentProduct
        navigationController?.pushViewController(viewController, animated: true)
    }
}




