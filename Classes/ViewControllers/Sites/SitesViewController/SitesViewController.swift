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
    
    @IBOutlet weak var tView: UITableView!
    @IBOutlet weak var noSiteView: UIView!
    
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
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        commandHandler?.viewModel.delegate = self
        
        tView.register(SiteTableViewCell.nib, forCellReuseIdentifier: SiteTableViewCell.cellReuseIdentifier)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "add_site_icon"), style: .plain, target: self, action: #selector(addAction))
        
        reloadTable()
    }
    
    func reloadTable() {
        
        tView.reloadData()
        
        var sitesCount = 0
        
        if let viewModel = commandHandler?.viewModel{
            
            for category in viewModel.categories{
                sitesCount += category.sites.count
            }
        }
        
        noSiteView.isHidden = (sitesCount != 0)
        
        
    }
    
    //MARK: - Button Actions
    @objc @IBAction func addAction() {
        commandHandler?.didPressAdd()
    }
    
    //SitesViewModelDelegate functions
    
    func sitesViewModelDidStartUpdating(_ sitesViewModel: SitesViewModelProtocol) {
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(ActivityData.shared)
    }
    
    func sitesViewModelDidEndUpdating(_ sitesViewModel: SitesViewModelProtocol) {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
        
        reloadTable()
    }
    
    //MARK :- UITableViewDelegates
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let viewModel =  commandHandler?.viewModel{
            return viewModel.categories.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if let viewModel = commandHandler?.viewModel {
            
            if viewModel.categories.count > section {
                
                let imageName = "section_header_bkg\(section)"
                
                let sectionHeader =  Bundle.main.loadNibNamed("SiteCategorySectionHeaderView", owner: self, options: nil)?.first as! SiteCategorySectionHeaderView
                sectionHeader.configure(with: viewModel.categories[section], UIImage(named: imageName))
                
                return sectionHeader
                
            }
            
        }
        
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let viewModel = commandHandler?.viewModel {
            if viewModel.categories.count > section {
                return viewModel.categories[section].sites.count
            }
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let viewModel = commandHandler?.viewModel {
            
            if viewModel.categories.count > indexPath.section {
                
                let category = viewModel.categories[indexPath.section]
                
                if category.sites.count > indexPath.row {
                    
                    let site = category.sites[indexPath.row]
                    
                    let cell = tableView.dequeueReusableCell(withIdentifier: SiteTableViewCell.cellReuseIdentifier, for: indexPath) as! SiteTableViewCell
                    cell.configure(for: site)
                    
                    return cell
                }
                
            }
            
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        commandHandler?.didSelectSiteAtIndexPath(indexPath)
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
