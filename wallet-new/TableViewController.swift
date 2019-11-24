//
//  TableViewController.swift
//  wallet-new
//
//  Created by Matis Luzi on 9/20/19.
//  Copyright © 2019 Matis Luzi. All rights reserved.
//

import UIKit

class TableViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
            
        tableView.dataSource = self
        tableView.delegate = self
       
        navigationController?.navigationBar.barTintColor = UIColor(red: 107/255, green: 109/255, blue: 210/255, alpha: 1)
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor:UIColor.white]
        self.title = "Spending History"
        
    }
    
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int ) -> Int {
        if !(UserDefaults.standard.object(forKey: "spending_names") == nil) {
                return UserDefaults.standard.array(forKey: "spending_names")!.count
        }
        else {
            return 0
        }
    }
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! CustomCell
        cell.layer.backgroundColor = UIColor.clear.cgColor

        if !(UserDefaults.standard.object(forKey: "spending_names") == nil) {
            cell.showCellData(name: UserDefaults.standard.array(forKey: "spending_names")?.reversed()[indexPath.row] as! String, date: UserDefaults.standard.array(forKey: "spending_dates")?.reversed()[indexPath.row] as! String, amount: UserDefaults.standard.array(forKey: "spending_amounts")?.reversed()[indexPath.row] as! String)
        }
        return cell
    }
    public override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
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
