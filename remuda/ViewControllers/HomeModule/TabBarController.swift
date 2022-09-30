//
//  TabBarController.swift
//  remuda
//
//  Created by Macmini on 24/04/21.
//

import UIKit

class TabBarController: UITabBarController {
    
    var setSelectedIndex:Int?
    var categoryId: Int = 0
    var postId:Int = 0
    var categoryName: MarketPlaceMode?
    var viewModel = HomeViewModel()
    var arrDetails : PostsModel?
    var postData: [PostsData]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let homeVC = loadViewController(Storyboard: .Home, ViewController: .HomeVC)
        let marketPlaceVC = loadViewController(Storyboard: .MarketPlace, ViewController: .MarketPlacesHomeVC)
        let proVC = loadViewController(Storyboard: .Profile, ViewController: .ProfileVC)
        self.viewControllers = [homeVC,marketPlaceVC,proVC]
        setUpUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        switch self.setSelectedIndex {
        case 0:
            self.selectedIndex = 0
            self.setSelectedIndex = nil
            homeFeedCallAPI(city: "") {
                let vc = self.loadViewController(Storyboard: .Home, ViewController: .SelectedHomePostVC) as! SelectedHomePostViewController
                vc.arrDetails = self.postData?.first
                self.navigationController?.pushViewController(vc, animated: true)
            }
        case 1:
            self.selectedIndex = 1
            switch  self.categoryName{
            
            case .horse:
                navigationToDetailsVC(id: self.categoryId, mode: .horse)
            case .equipmment:
                navigationToDetailsVC(id: self.categoryId, mode: .equipmment)
            case .tack:
                navigationToDetailsVC(id: self.categoryId, mode: .tack)
            default:
                break
            }
        default:
            break
        }
    }
    
    func setUpUI(){
        tabBar.items?.first?.image = UIImage(named: "home_Icon")
        tabBar.items?[2].image = UIImage(named: "profile_Icon")
        tabBar.items?[1].image = UIImage(named: "marketplace_Icon")
        
        tabBar.items?.first?.title = "Home"
        tabBar.items?[2].title = "Profile"
        tabBar.items?[1].title = "MarketPlace"
        tabBar.tintColor = .app_green_color
        
    }
    
    func navigationToDetailsVC(id: Int, mode: MarketPlaceMode) {
        guard let vc = loadViewController(Storyboard: .MarketPlace, ViewController: .HorseDetailsVC) as? HorseDetailsViewController else {
            return
        }
        self.setSelectedIndex = nil
        vc.mode = mode
        vc.currentItemID = id
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
//MARK:- API call
extension TabBarController {
    private func homeFeedCallAPI(city: String, completion: @escaping () -> Void){
        viewModel.data.removeAll()
        showActivityIndicator(uiView: self.view)
        viewModel.getAppHomeFeedPosts { (isFinished, message) in
            
            if isFinished
            {
                self.arrDetails = self.viewModel.homeFeedPost
                self.postData = self.arrDetails?.data?.filter({ element in
                    return element.id == self.postId
                })
                print("success")
                completion()
            }
            else{
                self.showAlert(message: message)
            }
        }
    }
}

