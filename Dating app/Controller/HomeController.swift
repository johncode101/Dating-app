//
//  ViewController.swift
//  Dating app
//
//  Created by Jonathan Hernandez on 11/29/21.
//


import UIKit

class HomeController: UIViewController {
    
    let topStackView = TopNavigationStackView()
    let cardsDeckView = UIView()
    let buttonsStackView = HomeBottomControlsStackView()
    
    
    let cardViewModels: [CardViewModel] = {
        let producers = [
            User(name: "Freddy", age: 1000, profession: "Killer", imageNames: ["freddy-ghost"]),
            User(name: "Big Pun", age: 10, profession: "Rapper", imageNames: ["beluga-whale"]),
            User(name: "Jane", age: 20, profession: "Nurse", imageNames: ["jane1", "jane2", "jane3"]),            Advertiser(title: "NFTs", brandName: "New Gold Rush", posterPhotoName: "nfts")
        ] as [ProducesCardViewModel]
        
        let viewModels = producers.map({return $0.toCardViewModel()})
        return viewModels
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupDummyCards()
    }
    
    fileprivate func setupDummyCards() {
        cardViewModels.forEach { (cardVM) in
            let cardView = CardView(frame: .zero)
            cardView.cardViewModel = cardVM
            cardsDeckView.addSubview(cardView)
            cardView.fillSuperview()
        }
    }
    
    // MARK:- Fileprivate
    
    fileprivate func setupLayout() {
        let overallStackView = UIStackView(arrangedSubviews: [topStackView, cardsDeckView, buttonsStackView])
        overallStackView.axis = .vertical
        overallStackView.backgroundColor = .systemBackground
        view.addSubview(overallStackView)
        overallStackView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
        overallStackView.isLayoutMarginsRelativeArrangement = true
        overallStackView.layoutMargins = .init(top: 0, left: 12, bottom: 0, right: 12)
        
        overallStackView.bringSubviewToFront(cardsDeckView)
    }

}
