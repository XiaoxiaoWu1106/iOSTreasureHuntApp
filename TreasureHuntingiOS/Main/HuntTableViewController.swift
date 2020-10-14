//
//  HuntTableViewController.swift
//  TreasureHuntingiOS
//
//  Created by Ye Lu on 5.9.2020.
//  Copyright © 2020 Xiaoxiao Wu. All rights reserved.
//

import UIKit

class HuntTableViewController: UITableViewController {
    fileprivate var dataSection: [Hunt] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "HuntTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "HuntTableViewCell")
        initData()
        let tempImageView = UIImageView(image: UIImage(named: "HomeViewTableBackground"))
        tempImageView.frame = self.tableView.frame
        self.tableView.backgroundView = tempImageView
    }
    /*override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillDisappear(animated)
    }*/
    fileprivate func initData() {
        dataSection.removeAll()
        dataSection.append(JSONParser.init().parseHunt(fileName: "demo_hunt")!)
        tableView.reloadData()
        tableView.hideEmptyCells()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataSection.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HuntTableViewCell", for: indexPath)
        if let customCell = cell as? HuntTableViewCell {
            customCell.configure(dataSection[indexPath.row])
        }

        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showMasterPlayerDialog(self.navigationController!, viewToAnchor: tableView.cellForRow(at: indexPath)!) {
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showHuntDetail", let huntItem = sender as? Hunt {
            guard let vc = segue.destination as? HuntDetailViewController else {
                // Display a UIAlertController telling the user to check for an updated app..
                return
            }
            vc.huntItem = huntItem
        }
    }
    
    func showMasterPlayerDialog(_ navigationController: UINavigationController, viewToAnchor: UIView, _ completion: @escaping () -> Void) {
        let title = "Choose your role"
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Master", style: .default, handler: { [self] (alert) in
            showMasterCodeInputDialog(self.navigationController!) {
                
            }
        }))
        alert.addAction(UIAlertAction(title: "Player", style: .default, handler: { (alert) in
            self.performSegue(withIdentifier: "showHuntDetail", sender: self.dataSection[0])
        }))
        if let popoverPresentationController = alert.popoverPresentationController {
            popoverPresentationController.sourceView = viewToAnchor
            popoverPresentationController.sourceRect = CGRect(x: viewToAnchor.bounds.size.width / 2.0 , y: viewToAnchor.bounds.size.height / 2.0, width: 1.0, height: 1.0)
        }
        navigationController.present(alert, animated: true, completion: nil)
    }
    
    func showMasterCodeInputDialog(_ navigationController: UINavigationController, _ completion: @escaping () -> Void) {
        let title = "Enter master code"
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            
        }
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { (alertAction) in
            if let input = alert.textFields?[0].text {
                if input == "0000" {
                    self.performSegue(withIdentifier: "showHuntDetail", sender: self.dataSection[0])
                }
            }
        }))
        navigationController.present(alert, animated: true, completion: nil)
    }

}
