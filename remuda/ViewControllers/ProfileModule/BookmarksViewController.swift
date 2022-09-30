//
//  BookmarksViewController.swift
//  remuda
//
//  Created by Macmini on 13/04/21.
//

import UIKit

class BookmarksViewController: UIViewController{
    
    private lazy var postsViewController: PostsViewController = {
        let viewController = self.loadViewController(Storyboard: .Profile, ViewController: .PostsVC) as! PostsViewController
        self.add(asChildViewController: viewController)
        return viewController
    }()
    private lazy var listingsViewController: ListingsViewController = {
        let viewController = self.loadViewController(Storyboard: .Profile, ViewController: .ListingsVC) as! ListingsViewController
        self.add(asChildViewController: viewController)
        return viewController
    }()
    @IBOutlet weak var interfaceSegmented: CustomSegmentedControl!{
        didSet{
            interfaceSegmented.setButtonTitles(buttonTitles: ["Posts","Listings"])
            interfaceSegmented.selectorViewColor = .app_green_color
            interfaceSegmented.selectorTextColor = .app_green_color
        }
    }
    @IBOutlet var mergeView: UIView!
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interfaceSegmented.delegate = self
        let codeSegmented = CustomSegmentedControl(frame: CGRect(x: 0, y: interfaceSegmented.frame.height , width: self.view.frame.width, height: interfaceSegmented.frame.height), buttonTitle: ["Posts","Listings"])
        codeSegmented.backgroundColor = .clear
        setUpUI()
        setupView()
    }
    func setUpUI(){
        self.title = ViewControllerTitle.bookmarks.rawValue
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))!]
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.setBackButtonTitleHide()
        self.setBackButton()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.shadowImage = .none
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    private func add(asChildViewController viewController: UIViewController) {
        addChild(viewController)
        mergeView.addSubview(viewController.view)
        viewController.view.frame = mergeView.bounds
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
            postsViewController.getSavedPostAPICall()
            remove(asChildViewController: listingsViewController)
            add(asChildViewController: postsViewController)
        } else {
            listingsViewController.getSavedListingsAPICall()
            remove(asChildViewController: postsViewController)
            add(asChildViewController: listingsViewController)
        }
    }
    
    func setupView() {
        updateView()
    }
}

extension BookmarksViewController: CustomSegmentedControlDelegate{
    func change(to index: Int) {
        currentIndex = index
        self.updateView()
    }
}
