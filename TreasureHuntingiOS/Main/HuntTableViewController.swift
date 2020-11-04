//
//  HuntTableViewController.swift
//  TreasureHuntingiOS
//
//  Created by Ye Lu on 5.9.2020.
//  Copyright © 2020 Xiaoxiao Wu. All rights reserved.
//

import UIKit

class HuntTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    fileprivate var dataSection: [Hunt] = []
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "HuntTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "HuntTableViewCell")
        initData()
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "HomeViewTableBackground")?.draw(in: self.view.bounds)

        if let image = UIGraphicsGetImageFromCurrentImageContext(){
            UIGraphicsEndImageContext()
            self.view.backgroundColor = UIColor(patternImage: image)
        }else{
            UIGraphicsEndImageContext()
            debugPrint("Image not available")
        }
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
        for _ in 1...20 {
            dataSection.append(JSONParser.init().parseHunt(fileName: "demo_hunt")!)
            dataSection.append(JSONParser.init().parseHunt(fileName: "demo_hunt")!)
            dataSection.append(JSONParser.init().parseHunt(fileName: "demo_hunt")!)
        }
        tableView.reloadData()
        tableView.hideEmptyCells()
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataSection.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HuntTableViewCell", for: indexPath)
        if let customCell = cell as? HuntTableViewCell {
            let hunt = dataSection[indexPath.row]
            let rowType = GenericRow(rowType: .huntHeader, userInfo: ["hunt": hunt])
            customCell.configure(rowType)
        }
        // Configure the cell...
        let maskLayer = CAShapeLayer()
        let bounds = cell.bounds
        maskLayer.path = UIBezierPath(roundedRect: CGRect(x: 2, y: 6, width: bounds.width-4, height: bounds.height-12), cornerRadius: 0).cgPath
        cell.layer.mask = maskLayer
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showMasterPlayerDialog(self.navigationController!, viewToAnchor: tableView.cellForRow(at: indexPath)!) {

        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showHuntDetail", let huntItem = sender as? Hunt {
            guard let viewController = segue.destination as? HuntDetailViewController else {
                // Display a UIAlertController telling the user to check for an updated app..
                return
            }
            viewController.huntItem = huntItem
        }
    }

    func showMasterPlayerDialog(_ navigationController: UINavigationController,
                                viewToAnchor: UIView, _ completion: @escaping () -> Void) {
        let title = "Choose your role"
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Master", style: .default, handler: { [self] (_) in
            showMasterCodeInputDialog(self.navigationController!) {

            }
        }))
        alert.addAction(UIAlertAction(title: "Player", style: .default, handler: { (_) in
            self.performSegue(withIdentifier: "showHuntDetail", sender: self.dataSection[0])
        }))
        if let popoverPresentationController = alert.popoverPresentationController {
            popoverPresentationController.sourceView = viewToAnchor
            popoverPresentationController.sourceRect = CGRect(x: viewToAnchor.bounds.size.width / 2.0,
                                                              y: viewToAnchor.bounds.size.height / 2.0,
                                                              width: 1.0, height: 1.0)
        }
        navigationController.present(alert, animated: true, completion: nil)
    }

    func showMasterCodeInputDialog(_ navigationController: UINavigationController, _ completion: @escaping () -> Void) {
        let title = "Enter master code"
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addTextField { (_) in

        }
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { (_) in
            if let input = alert.textFields?[0].text {
                if input == "0000" {
                    self.performSegue(withIdentifier: "showHuntDetail", sender: self.dataSection[0])
                }
            }
        }))
        navigationController.present(alert, animated: true, completion: nil)
    }

}
