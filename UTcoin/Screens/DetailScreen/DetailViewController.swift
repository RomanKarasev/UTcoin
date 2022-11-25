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
        view = detailView
        
    }
    
    // MARK: - Private Methods
    
    @objc private func addNewToTableView() {
        if detailView.expandButton.titleLabel?.text == "Развернуть" {
            detailView.termsTableViewHeightConstraint?.constant = 150
            detailView.layoutIfNeeded()
            
            detailView.expandButton.setTitle("Свернуть", for: .normal)
        } else {
            detailView.expandButton.setTitle("Развернуть", for: .normal)
            detailView.termsTableViewHeightConstraint?.constant = 0
            detailView.layoutIfNeeded()
        }
    }
    
    private func setView() {
        navigationController?.navigationBar.tintColor          = Constants.Colors.mainColor
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func setProductData() {
        guard let currentProduct = currentProduct else { return }
        
        detailView.titleLabel.text              = currentProduct.name
        detailView.priceLabel.text              = currentProduct.price
        detailView.dayCountLabel.text           = currentProduct.paymentTime
        detailView.firstTermsCashbackLabel.text = currentProduct.actions[0].value
        detailView.firstTermsDiscribeLabel.text = currentProduct.actions[0].text
        
        detailView.cashbackButton.setTitle(currentProduct.cashback, for: .normal)
        GetImagesFromURL.shared.getImage(url: currentProduct.campaignImageURL, imageView: detailView.shopImageView)
        setupImages(currentProduct.imageUrls)
    }
    
    
    private func setCampaignData() {
        
        guard let currentCampaign = currentCampaign else { return }
        
        detailView.titleLabel.text                         = currentCampaign.name
        detailView.shopImageViewHeightConstraint?.constant = 0
        detailView.priceLabel.text                         = ""
        
        detailView.dayCountLabel.text           = currentCampaign.paymentTime
        detailView.firstTermsCashbackLabel.text = currentCampaign.actions[0].value
        detailView.firstTermsDiscribeLabel.text = currentCampaign.actions[0].text
        
        detailView.cashbackButton.setTitle(currentCampaign.cashback, for: .normal)
        let campainImages = [currentCampaign.imageURL]
        setupImages(campainImages)
        
    }
    
    private func setupImages(_ images: [String]){
        
        for i in 0..<images.count {
            
            let imageView = UIImageView()
            GetImagesFromURL.shared.getImage(url: images[i], imageView: imageView)
            let xPosition = UIScreen.main.bounds.width * CGFloat(i)
            imageView.frame = CGRect(x: xPosition,
                                     y: 0,
                                     width: detailView.itemsScrollView.frame.width,
                                     height: detailView.itemsScrollView.frame.height)
            imageView.contentMode = .scaleAspectFit
            
            detailView.itemsScrollView.contentSize.width = detailView.itemsScrollView.frame.width * CGFloat(i + 1)
            detailView.itemsScrollView.addSubview(imageView)
            detailView.itemsScrollView.delegate = self
            
        }
    }
    
    private func addTargetToButtons() {
        detailView.expandButton.addTarget(self, action: #selector(addNewToTableView), for: .touchUpInside)
    }
    
    private func setDelegates() {
        detailView.termsTableView.delegate   = self
        detailView.termsTableView.dataSource = self
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
            cell.discribeLabel.text = actionNew[indexPath.row].text
            return cell
        } else {
            guard let currentProduct = currentProduct else { return cell }
            var actionNew            = currentProduct.actions
            actionNew.removeFirst()
            cell.cashbackLabel.text = actionNew[indexPath.row].value
            cell.discribeLabel.text = actionNew[indexPath.row].text
            return cell
        }
    }
}

//MARK: - UITableViewDelegate

extension DetailViewController: UITableViewDelegate {
    
}





