//
//  UserListingsViewController.swift
//  remuda
//
//  Created by Macmini on 04/05/21.
//

enum ListingMode : String{
    case selling = "selling"
    case expired = "expired"
    case sold    = "sold"
}

import UIKit

class UserListingsViewController: UIViewController {

    @IBOutlet weak var segmentView: UIView!
    @IBOutlet weak var interfaceSegmented: CustomSegmentedControl!{
        didSet{
            interfaceSegmented.setButtonTitles(buttonTitles: ["Selling","Expired","Sold"])
            interfaceSegmented.selectorViewColor = .app_green_color
            interfaceSegmented.selectorTextColor = .app_green_color
        }
    }
    var currentIndex = 0
    private lazy var sellingListVC: SellingListViewController = {
        let viewController = self.loadViewController(Storyboard: .MarketPlace, ViewController: .SellingListVC) as! SellingListViewController
        self.add(asChildViewController: viewController)
        return viewController
    }()
    private lazy var expiredListVC: ExpiredListViewController = {
        let viewController = self.loadViewController(Storyboard: .MarketPlace, ViewController: .ExpiredListVC) as! ExpiredListViewController
        self.add(asChildViewController: viewController)
        return viewController
    }()
    private lazy var soldListVC: SoldListViewController = {
        let viewController = self.loadViewController(Storyboard: .MarketPlace, ViewController: .SoldListVC) as! SoldListViewController
        self.add(asChildViewController: viewController)
        return viewController
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interfaceSegmented.delegate = self
        let codeSegmented = CustomSegmentedControl(frame: CGRect(x: 0, y: interfaceSegmented.frame.height, width: self.view.frame.width, height: interfaceSegmented.frame.height), buttonTitle: ["Selling","Expired","Sold"])
        codeSegmented.backgroundColor = .clear
    }
    
    override func viewDidLayoutSubviews() {
        self.setBackButtonTitleHide()
        setUpUI()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setBackButtonTitleHide()
        self.setBackButton()
    }
    
    func setUpUI(){
        self.setNavigationBarSubVCTitle(navTitle: .YourListings)
        
        let rightAdd  = UIButton(frame: CGRect(x: 0, y: 0, width: 40 * UIScreen.main.bounds.width / 375, height: 40 * UIScreen.main.bounds.width / 375))
        rightAdd.setImage(UIImage(named: "Add_icon"), for: .normal)
        rightAdd.titleLabel?.font = UIFont(name: FontName.Regular.rawValue, size: FontSize.Size_16.rawValue)
        rightAdd.backgroundColor = .app_green_color
        rightAdd.setRoundedView()
        rightAdd.addTarget(self, action: #selector(addNewListingTapped), for: .touchUpInside)
        self.navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: rightAdd)]
    }
    
    @objc func addNewListingTapped(){
        self.pushViewController(controllerID: .NewListingCategoryVC, storyBoardID: .NewListing)
    }

    private func add(asChildViewController viewController: UIViewController) {
        addChild(viewController)
        segmentView.addSubview(viewController.view)
        viewController.view.frame = segmentView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.didMove(toParent: self)
    }
    private func remove(asChildViewController viewController: UIViewController) {
        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }
    private func updateView() {
        if currentIndex == 0 {
            sellingListVC.mode = .selling
            remove(asChildViewController: expiredListVC)
            remove(asChildViewController: soldListVC)
            add(asChildViewController: sellingListVC)
        } else if currentIndex == 1 {
            expiredListVC.mode = .expired
            remove(asChildViewController: sellingListVC)
            remove(asChildViewController: soldListVC)
            add(asChildViewController: expiredListVC)
        }
        else{
            soldListVC.mode = .sold
            remove(asChildViewController: sellingListVC)
            remove(asChildViewController: expiredListVC)
            add(asChildViewController: soldListVC)
        }
    }
    func setupView() {
        updateView()
    }

}

extension UserListingsViewController : CustomSegmentedControlDelegate {
    func change(to index: Int) {
        currentIndex = index
        self.updateView()
    }
}
