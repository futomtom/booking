//
//  ExampleViewController.swift
//  Segmentio
//
//  Created by Dmitriy Demchenko
//  Copyright © 2016 Yalantis Mobile. All rights reserved.
//

import UIKit
import Segmentio
import SideMenu



class putOrderVC: UIViewController {
    
    var segmentioStyle = SegmentioStyle.imageBeforeLabel
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet fileprivate weak var segmentViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet fileprivate weak var segmentioView: Segmentio!
    @IBOutlet fileprivate weak var containerView: UIView!
  //  @IBOutlet fileprivate weak var scrollView: UIScrollView!
    fileprivate lazy var viewControllers: [UIViewController] = []
  
    var products:[String]=[]
    var order:[String]=[]
    var  beginOrder = false
    

  

    
    // MARK: - Init
    
    class func create() -> putOrderVC {
        let board = UIStoryboard(name: "Main", bundle: nil)
        return board.instantiateViewController(withIdentifier: String(describing: self)) as! putOrderVC
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        
        switch segmentioStyle {
        case .onlyLabel, .imageBeforeLabel, .imageAfterLabel:
            segmentViewHeightConstraint.constant = 50
        case .onlyImage:
            segmentViewHeightConstraint.constant = 100
        default:
            break
        }
        
        let RightButtonItem = UIBarButtonItem(image: UIImage(named: "ic_menu"), style: .plain, target: self, action:  #selector(self.OpenMenu))
        self.navigationItem.setLeftBarButton(RightButtonItem, animated: true)
        
        (collectionView.collectionViewLayout as! UICollectionViewFlowLayout).sectionHeadersPinToVisibleBounds = true
        
        LoadData()
    }
    
    func LoadData() {
     
        print(products.count)
   
    
    }
    
    @IBAction func orderSwitch_ValueChange(_ sender: UISwitch) {
        if sender.isOn {
           BeginOrder()
            
        } else {
            let alertController = UIAlertController(title: NSLocalizedString("Clean Order",comment:""), message: NSLocalizedString("want clean orders",comment:""), preferredStyle:UIAlertControllerStyle.alert)
            
            let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel",comment:""), style: .cancel) { _ in
                sender.isOn = true
            }
            alertController.addAction(cancelAction)
            
            let OKAction = UIAlertAction(title: NSLocalizedString("OK",comment:""), style: .default) { _ in
               self.CleanOrder()
               
                
            }
            alertController.addAction(OKAction)
            
            self.present(alertController, animated: true, completion:nil)

        }
    
    }
    func BeginOrder() {
        
        beginOrder = true
        
    }
    
    
    func CleanOrder() {
         beginOrder = false
        
    }
    
    
   
    
  
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
            
        case UICollectionElementKindSectionHeader:
            
            let headerView:CollectionHeadView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                             withReuseIdentifier: "headview",
                                                                             for: indexPath) as! CollectionHeadView
   
            
            
            return headerView
        default:
            
            fatalError("Unexpected element kind")
        }
    }
    
    func OpenMenu() {
        present(SideMenuManager.menuLeftNavigationController!, animated: true, completion: nil)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupSegmentioView()
       
        setupBadgeCountForIndex(1)
    }
    
    
    
}

extension putOrderVC: UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
     func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
  
        return 9
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:ItemCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ItemCell
      //  cell.setData(item: products[indexPath.row], index: indexPath.row)
        
        
        return cell
    }
    
    
    
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
    
        let cell = collectionView.cellForItem(at: indexPath)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.width - 10*5) / 3
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
       
        return UIEdgeInsetsMake(0, 10, 0, 10)
    }
    
    
    
}

extension putOrderVC {
    
    fileprivate func setupSegmentioView() {
        segmentioView.setup(
            content: segmentioContent(),
            style: segmentioStyle,
            options: segmentioOptions()
        )
        
        segmentioView.selectedSegmentioIndex = selectedSegmentioIndex()
        
        segmentioView.valueDidChange = { [weak self] _, segmentIndex in
            print (segmentIndex )
        }
    }
    
    fileprivate func setupBadgeCountForIndex(_ index: Int) {
        segmentioView.addBadge(at: index, count: 10, color: ColorPalette.coral)
    }

    
    fileprivate func segmentioContent() -> [SegmentioItem] {
        return [
            SegmentioItem(title: "菜", image: UIImage(named: "tornado")),
            SegmentioItem(title: "湯", image: UIImage(named: "earthquakes")),
            SegmentioItem(title: "素", image: UIImage(named: "heat")),
            SegmentioItem(title: "點心", image: UIImage(named: "eruption")),
            SegmentioItem(title: "飲料", image: UIImage(named: "floods")),
            SegmentioItem(title: "飯", image: UIImage(named: "wildfires"))
        ]
    }
    
    fileprivate func segmentioOptions() -> SegmentioOptions {
        var imageContentMode = UIViewContentMode.center
        switch segmentioStyle {
        case .imageBeforeLabel, .imageAfterLabel:
            imageContentMode = .scaleAspectFit
        default:
            break
        }
        
        return SegmentioOptions(
            backgroundColor: ColorPalette.white,
            maxVisibleItems: 3,
            scrollEnabled: true,
            indicatorOptions: segmentioIndicatorOptions(),
            horizontalSeparatorOptions: segmentioHorizontalSeparatorOptions(),
            verticalSeparatorOptions: segmentioVerticalSeparatorOptions(),
            imageContentMode: imageContentMode,
            labelTextAlignment: .center,
            segmentStates: segmentioStates()
        )
    }
    
    fileprivate func segmentioStates() -> SegmentioStates {
        let font = UIFont(name: "Avenir-Book", size: 13)!
        return SegmentioStates(
            defaultState: segmentioState(
                backgroundColor: .clear,
                titleFont: font,
                titleTextColor: ColorPalette.grayChateau
            ),
            selectedState: segmentioState(
                backgroundColor: .clear,
                titleFont: font,
                titleTextColor: ColorPalette.black
            ),
            highlightedState: segmentioState(
                backgroundColor: ColorPalette.whiteSmoke,
                titleFont: font,
                titleTextColor: ColorPalette.grayChateau
            )
        )
    }

    
    fileprivate func segmentioState(backgroundColor: UIColor, titleFont: UIFont, titleTextColor: UIColor) -> SegmentioState {
        return SegmentioState(backgroundColor: backgroundColor, titleFont: titleFont, titleTextColor: titleTextColor)
    }
    
    fileprivate func segmentioIndicatorOptions() -> SegmentioIndicatorOptions {
        return SegmentioIndicatorOptions(type: .bottom, ratio: 1, height: 5, color: ColorPalette.coral)
    }
    
    fileprivate func segmentioHorizontalSeparatorOptions() -> SegmentioHorizontalSeparatorOptions {
        return SegmentioHorizontalSeparatorOptions(type: .topAndBottom, height: 1, color: ColorPalette.whiteSmoke)
    }
    
    fileprivate func segmentioVerticalSeparatorOptions() -> SegmentioVerticalSeparatorOptions {
        return SegmentioVerticalSeparatorOptions(ratio: 1, color: ColorPalette.whiteSmoke)
    }
    
    fileprivate func selectedSegmentioIndex() -> Int {
        return 0
    }

    
    
    
    
}
