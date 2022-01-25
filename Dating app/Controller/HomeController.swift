//
//  ViewController.swift
//  Dating app
//
//  Created by Jonathan Hernandez on 11/29/21.
//


import UIKit
import FirebaseFirestore


class HomeController: UIViewController {
    
    let topStackView = TopNavigationStackView()
    let cardsDeckView = UIView()
    let buttonsStackView = HomeBottomControlsStackView()
    
    
//    let cardViewModels: [CardViewModel] = {
//        let producers = [
//            User(name: "Freddy", age: 1000, profession: "Killer", imageNames: ["freddy-ghost"]),
//            User(name: "Big Pun", age: 10, profession: "Rapper", imageNames: ["beluga-whale"]),
//            User(name: "Jane", age: 20, profession: "Nurse", imageNames: ["jane1", "jane2", "jane3"]),            Advertiser(title: "NFTs", brandName: "New Gold Rush", posterPhotoName: "nfts")
//        ] as [ProducesCardViewModel]
//
//        let viewModels = producers.map({return $0.toCardViewModel()})
//        return viewModels
//    }()
    
    var cardViewModels = [CardViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topStackView.settingsButton.addTarget(self, action: #selector(handleSettings), for: .touchUpInside)
        
        setupLayout()
        setupFirestoreUserCards()
        fetchUsersFromFireStore()
    }
    
    fileprivate func fetchUsersFromFireStore() {
        let query = Firestore.firestore().collection("users")
        query.getDocuments { (snapshot, err) in
            if let err = err {
                print("Failed to fetch users:", err)
                return
            }
            snapshot?.documents.forEach({ (documentsSnapshot) in
                let userDictionary = documentsSnapshot.data()
                let user = User(dictionary: userDictionary)
                self.cardViewModels.append(user.toCardViewModel())
                print(user.name ?? "", user.imageUrl1 ?? "")
            })
            self.setupFirestoreUserCards()
        }
    }
    
    @objc func handleSettings() {
        let registrationController = RegistrationController()
        registrationController.modalPresentationStyle = .fullScreen
        present(registrationController, animated: true)
        
    }
    
    fileprivate func setupFirestoreUserCards() {
        cardViewModels.forEach { (cardVM) in
            let cardView = CardView(frame: .zero)
            cardView.cardViewModel = cardVM
            cardsDeckView.addSubview(cardView)
            cardView.fillSuperview()
        }
    }
    
    // MARK:- Fileprivate
    
    fileprivate func setupLayout() {
        view.backgroundColor = .white
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
