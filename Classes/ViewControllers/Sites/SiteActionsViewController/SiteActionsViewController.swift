//
//  SiteActionsViewController.swift
//  Lock Bear
//
//  Created by Teodor Rotaru on 17/06/2019.
//  Copyright © 2019 Flavian Rotaru. All rights reserved.
//

import UIKit

class SiteActionsViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var tView: UITableView!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var headerImgView: UIImageView!
    
    var commandHandler: SiteActionsCommandHandlerProtocol?
    
    required init(with commandHandler: SiteActionsCommandHandlerProtocol?) {
        super.init(nibName: String(describing: SiteActionsViewController.self), bundle: nil)
        self.commandHandler = commandHandler
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tView.register(SiteActionTableViewCell.nib, forCellReuseIdentifier: SiteActionTableViewCell.cellReuseIdentifier)
        
        headerLabel.text = self.commandHandler?.viewModel.selectedSite?.name
        headerImgView.image = self.commandHandler?.viewModel.selectedSite?.icon
        
        self.view.backgroundColor = UIColor(white: 0.0, alpha: 0.75)
        self.view.isOpaque = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let size = CGSize(width: self.headerImgView.bounds.width * UIScreen.main.scale, height: self.headerImgView.bounds.height * UIScreen.main.scale)
        DispatchQueue.global().async {
            let resizedImage = self.commandHandler?.viewModel.selectedSite?.icon.resize(width: size.width, height: size.height)
            DispatchQueue.main.async {
                self.headerImgView.image = resizedImage
            }
        }
    }
    
    //MARK: - UITableView Delegates
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commandHandler?.viewModel.actions.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SiteActionTableViewCell.cellReuseIdentifier, for: indexPath) as! SiteActionTableViewCell
        cell.logoImageView.image = commandHandler?.viewModel.actions[indexPath.row].getLogo()
        cell.optionLabel.text = commandHandler?.viewModel.actions[indexPath.row].getName()
        cell.optionLabel.textColor = commandHandler?.viewModel.actions[indexPath.row].getColor()
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.commandHandler?.didSelectAction(at: indexPath.row)
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
