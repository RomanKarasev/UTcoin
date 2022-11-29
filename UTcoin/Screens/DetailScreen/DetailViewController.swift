//
//  DetailViewController.swift
//  UTcoin
//
//  Created by Роман Карасёв on 23.11.2022.
//

import UIKit

//MARK: - DetailViewController

class DetailViewController: UIViewController {
    
    // MARK: Properties
    
    var currentProduct: Product?
    var currentCampaign: Campaign?
    
    //MARK: views
    
    private let detailView = DetailView()
    
    // MARK: View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        addTargetToButtons()
        setDelegates()
        
        DispatchQueue.main.async {
            if self.currentProduct == nil {
                self.setCampaignData()
            } else {
                self.setProductData()
            }
        }
    }
    
    override func loadView() {
        super.loadView()
    }
    
    // MARK: - Private Methods
    
    @objc private func addNewToTableView() {
        if detailView.mainScrollView.expandButton.titleLabel?.text == "Развернуть" {
            detailView.mainScrollView.termsTableViewHeightConstraint?.constant = 200
            detailView.layoutIfNeeded()
            
            detailView.mainScrollView.expandButton.setTitle("Свернуть", for: .normal)
        } else {
            detailView.mainScrollView.expandButton.setTitle("Развернуть", for: .normal)
            detailView.mainScrollView.termsTableViewHeightConstraint?.constant = 0
            detailView.layoutIfNeeded()
        }
    }
    
    private func setView() {
        view.backgroundColor = .systemBackground
        
        navigationController?.navigationBar.tintColor          = Constants.Colors.mainColor
        navigationController?.navigationBar.prefersLargeTitles = false
        
        view.addSubview(detailView)
        NSLayoutConstraint.activate(
            [detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                             constant: 10),
             detailView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
             detailView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
             detailView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ]
        )
    }
    
    private func setProductData() {
        guard let currentProduct = currentProduct else { return }
        
        detailView.mainScrollView.titleLabel.text              = currentProduct.name
        detailView.mainScrollView.priceLabel.text              = currentProduct.price
        detailView.mainScrollView.dayCountLabel.text           = currentProduct.paymentTime
        detailView.mainScrollView.firstTermsCashbackLabel.text = currentProduct.actions[0].value
        detailView.mainScrollView.firstTermsDiscribeLabel.text = currentProduct.actions[0].text
        
        detailView.mainScrollView.cashbackButton.setTitle(currentProduct.cashback, for: .normal)
        
        detailView.mainScrollView.shopImageView.downloadedFrom(link: currentProduct.campaignImageURL)
        setupImages(currentProduct.imageUrls)
    }
    
    
    private func setCampaignData() {
        
        guard let currentCampaign = currentCampaign else { return }
        
        detailView.mainScrollView.titleLabel.text                         = currentCampaign.name
        detailView.mainScrollView.shopImageViewHeightConstraint?.constant = 0
        detailView.mainScrollView.priceLabel.text                         = ""
        
        detailView.mainScrollView.dayCountLabel.text           = currentCampaign.paymentTime
        detailView.mainScrollView.firstTermsCashbackLabel.text = currentCampaign.actions[0].value
        detailView.mainScrollView.firstTermsDiscribeLabel.text = currentCampaign.actions[0].text
        
        detailView.mainScrollView.cashbackButton.setTitle(currentCampaign.cashback, for: .normal)
        let campainImages = [currentCampaign.imageURL]
        setupImages(campainImages)
        
    }
    
    private func setupImages(_ images: [String]){
        
        for i in 0..<images.count {
            
            let imageView = UIImageView()
            imageView.downloadedFrom(link: images[i])
            let xPosition = UIScreen.main.bounds.width * CGFloat(i)
            imageView.frame = CGRect(x: xPosition,
                                     y: 0,
                                     width: detailView.mainScrollView.itemsScrollView.frame.width,
                                     height: detailView.mainScrollView.itemsScrollView.frame.height)
            imageView.contentMode = .scaleAspectFit
            
            detailView.mainScrollView.itemsScrollView.contentSize.width = detailView.mainScrollView.itemsScrollView.frame.width * CGFloat(i + 1)
            detailView.mainScrollView.itemsScrollView.addSubview(imageView)
            detailView.mainScrollView.itemsScrollView.delegate = self
            
        }
    }
    
    private func addTargetToButtons() {
        detailView.mainScrollView.expandButton.addTarget(self, action: #selector(addNewToTableView), for: .touchUpInside)
    }
    
    private func setDelegates() {
        detailView.mainScrollView.termsTableView.delegate   = self
        detailView.mainScrollView.termsTableView.dataSource = self
    }
}

//MARK: - UITableViewDataSource

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if currentProduct == nil {
            guard var actionNew = currentCampaign?.actions else { return 1}
            actionNew.removeFirst()
            return actionNew.count
        } else {
            guard var actionNew = currentProduct?.actions else { return 1}
            actionNew.removeFirst()
            return actionNew.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TermsTableViewCell.identifier, for: indexPath) as! TermsTableViewCell
        if currentProduct == nil {
            guard let currentCampaign = currentCampaign else { return cell }
            var actionNew             = currentCampaign.actions
            actionNew.removeFirst()
            cell.cashbackLabel.text = actionNew[indexPath.row].value
            let text = actionNew[indexPath.row].text
            
            cell.discribeLabel.text = text
            
            
            return cell
        } else {
            guard let currentProduct = currentProduct else { return cell }
            var actionNew            = currentProduct.actions
            actionNew.removeFirst()
            cell.cashbackLabel.text = actionNew[indexPath.row].value
            let text = actionNew[indexPath.row].text
            
            cell.discribeLabel.text = text
            
            return cell
        }
    }
}

//MARK: - UITableViewDelegate

extension DetailViewController: UITableViewDelegate {
    
}






