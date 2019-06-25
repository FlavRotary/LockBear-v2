//
//  SitesViewController.swift
//  Lock Bear
//
//  Created by Flavian Rotaru on 08/10/2018.
//  Copyright © 2018 Flavian Rotaru. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class SitesViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource,SitesViewModelDelegate {
    
    @IBOutlet weak var sitesTableView: UITableView!
    
    weak var commandHandler: SitesCommandHandlerProtocol?
    
    required init?(with commandHandler: SitesCommandHandlerProtocol?) {
        super.init(nibName: String(describing: SitesViewController.self), bundle: nil)
        self.title = "Sites"
        self.commandHandler = commandHandler
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        sitesTableView.delegate = self
        sitesTableView.dataSource = self
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    //SitesViewModelDelegate functions
    
    func sitesViewModelDidStartUpdating(_ sitesViewModel: SitesViewModelProtocol) {
//        let activityData = ActivityData(size: CGSize(width: 100,height: 100),
//                                        message: "Loading...",
//                                        messageFont: UIFont.boldSystemFont(ofSize: 18.0),
//                                        messageSpacing: nil,
//                                        type: .circleStrokeSpin,
//                                        color: UIColor(red: 51.0/255.0, green: 214.0/255.0, blue: 193.0/255.0, alpha: 1.0),
//                                        padding: 10,
//                                        displayTimeThreshold: nil,
//                                        minimumDisplayTime: nil,
//                                        backgroundColor: UIColor.clear,
//                                        textColor: UIColor(red: 51.0/255.0, green: 214.0/255.0, blue: 193.0/255.0, alpha: 1.0))
//
//        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
    }
    
    func sitesViewModelDidEndUpdating(_ sitesViewModel: SitesViewModelProtocol) {
        //NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
        if self.sitesTableView != nil {
            self.sitesTableView.reloadData()
        } else {
            print(self.commandHandler?.viewModel?.categories.count as Any)
            print("Sites Table is empty")
        }
    }
    
    

    
    //MARK :- UITableViewDelegates
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let numSections =  commandHandler?.viewModel?.categories.count{
            print(numSections)
            return numSections
        } else{
            print("Can't get number of categories from viewModel")
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let categories = commandHandler?.viewModel?.categories, let catBackgrounds = commandHandler?.viewModel?.catBackgrounds{
            
            let sectionHeader =  Bundle.main.loadNibNamed("SiteCategorySectionHeaderView", owner: self, options: nil)?.first as! SiteCategorySectionHeaderView
            sectionHeader.configure(with: categories[section], catBackgrounds[section])
            
            return sectionHeader
            
        } else {
            let errorView = UIView()
            errorView.backgroundColor = .red
            return errorView
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let numRows = commandHandler?.viewModel?.categories[section].sites?.count {
            return numRows
        } else {
            print("Can't get number of rows from viewModel")
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let categories = commandHandler?.viewModel?.categories, let sites = categories[indexPath.section].sites{
            let siteCell = Bundle.main.loadNibNamed("SiteTableViewCell", owner: self, options: nil)?.first as! SiteTableViewCell
            siteCell.configure(for: sites[indexPath.row], UIImage(named: "threeDots") ?? UIImage(named: "pass_lock_icon_unselected")!)
            return siteCell
        } else {
            return UITableViewCell()
        }
        
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
