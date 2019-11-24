//
//  ViewController.swift
//  wallet-new
//
//  Created by Matis Luzi on 9/18/19.
//  Copyright © 2019 Matis Luzi. All rights reserved.
//

import MaterialComponents
import UIKit

class ViewController: UIViewController {

    @IBOutlet var masterView: UIView!
    
    // BUDGET VIEW
    @IBOutlet var budgetView: UIView!
    @IBOutlet var budgetViewExpenseView: UIView!
    @IBOutlet var budgetViewExpenseViewImage: UIImageView!
    @IBOutlet var budgetViewIncomeView: UIView!
    @IBOutlet var budgetViewIncomeViewImage: UIImageView!
    @IBOutlet var budgetViewLabelMinus: UILabel!
    @IBOutlet var budgetViewLabelPlus: UILabel!
    @IBOutlet var budgetViewLabelExpenses: UILabel!
    @IBOutlet var budgetViewLabelIncome: UILabel!
    
    // Add expense/income buttons
    @IBOutlet var addExpenseButton: UIButton!
    @IBOutlet var addIncomeButton: UIButton!
    
    // Money Left
    @IBOutlet var moneyLeftLabel: UILabel!
    @IBOutlet var moneyLeftValueLabel: UILabel!
    
    // Recent Spendings
    @IBOutlet var recentSpendingLabel: UILabel!
    @IBOutlet var recentSpendingViewMoreButton: UIButton!
    @IBOutlet var recentSpendingView: UIView!
    @IBOutlet var recentSpendingTableView: UITableView!
    
    // Pop-up Window
    @IBOutlet var popUpView: UIView!
    @IBOutlet var popUpLabel: UILabel!
    @IBOutlet var popUpCancelButton: UIButton!
    @IBOutlet var popUpDoneButton: UIButton!
    @IBOutlet var popUpField1: MDCTextField!
    @IBOutlet var popUpField2: MDCTextField!
    var popUpField1Controller = MDCTextInputControllerOutlined()
    var popUpField2Controller = MDCTextInputControllerOutlined()
    @IBOutlet var popUpField1View: UIView!
    @IBOutlet var popUpField2View: UIView!
    
    //CONSTRAINTS
    var screenHeight: CGFloat!
    var screenWidth: CGFloat!
    
    @IBOutlet var budgetViewTop: NSLayoutConstraint!
    @IBOutlet var budgetViewWidth: NSLayoutConstraint!
    @IBOutlet var budgetViewHeight: NSLayoutConstraint!
    
    @IBOutlet var expenseButtonLeft: NSLayoutConstraint!
    @IBOutlet var expenseButtonTop: NSLayoutConstraint!
    @IBOutlet var incomeButtonRight: NSLayoutConstraint!
    @IBOutlet var incomeButtonTop: NSLayoutConstraint!
    
    @IBOutlet var moneyLeftAmountLeft: NSLayoutConstraint!
    @IBOutlet var moneyLeftLabelLeft: NSLayoutConstraint!

    @IBOutlet var moneyLeftViewLeft: NSLayoutConstraint!
    @IBOutlet var recentSpendingViewHeight: NSLayoutConstraint!
    @IBOutlet var recentSpendingViewWidth: NSLayoutConstraint!
    @IBOutlet var recentSpendingLabelLeft: NSLayoutConstraint!
    
    @IBOutlet var popUpCenterX: NSLayoutConstraint!
    @IBOutlet var popUpCenterY: NSLayoutConstraint!
    @IBOutlet var popUpOpacityView: UIVisualEffectView!
    @IBOutlet var popUpView2Top: NSLayoutConstraint!
    
    
    // ================================
    // VARIABLES
    // ================================
    let defaults = UserDefaults.standard
    
    var currency:String = "KM"
    var currentBudget: Double!
    var monthlyExpense: Double!
    var monthlyIncome: Double!
    var spending_names: [String]! = []
    var spending_dates: [String]! = []
    var spending_amounts: [String]! = []
    var income_names: [String]! = []
    var income_dates: [String]! = []
    var income_amounts: [String]! = []
    var recentSpending: [String: [String]]! = [:]
    var addType:String!
    var sTsT:Bool = false
    var month:Double!
    
    // ==================================
    // VIEWDIDLOAD
    // ==================================
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (defaults.string(forKey: "hasFinishedSetup") != "yes") {
            setup()
        }
        else {
            
            // ======================
            // VARIABLES
            // ======================
            
            currentBudget = defaults.double(forKey: "currentBudget")
            
            if !(defaults.double(forKey: "month") == 0) {
                month = defaults.double(forKey: "month")
            }
            else {
                month = 0
            }
            let newDate = Date()
            let newFormatter = DateFormatter()
            newFormatter.dateFormat = "M"
            let newMonthString = newFormatter.string(from: newDate)
            let newMonth = Double(newMonthString)
            if (newMonth != month) {
                month = newMonth
                monthlyIncome = 0
                monthlyExpense = 0
                defaults.set(month, forKey:"month")
                defaults.set(monthlyIncome, forKey: "monthlyIncome")
                defaults.set(monthlyExpense, forKey: "monthlyExpense")
            }
            print(month)
            
            if !(defaults.array(forKey: "spending_names") as? [String] == nil || defaults.array(forKey: "spending_dates") as? [String] == nil || defaults.array(forKey: "spending_amounts") as? [String] == nil) {
                spending_names = defaults.array(forKey: "spending_names") as? [String]
                spending_dates = defaults.array(forKey: "spending_dates") as? [String]
                spending_amounts = defaults.array(forKey: "spending_amounts") as? [String]
            }
            
            if !(defaults.array(forKey: "income_names") as? [String] == nil || defaults.array(forKey: "income_dates") as? [String] == nil || defaults.array(forKey: "income_amounts") as? [String] == nil) {
                income_names = defaults.array(forKey: "income_names") as? [String]
                income_dates = defaults.array(forKey: "income_dates") as? [String]
                income_amounts = defaults.array(forKey: "spending_amounts") as? [String]
            }
            
            if !(spending_names == nil || spending_dates == nil || spending_amounts == nil) {
                recentSpending = [
                    "names": Array(spending_names.prefix(3)),
                    "dates": Array(spending_dates.prefix(3)),
                    "amounts": Array(spending_amounts.prefix(3)),
                ]
            }
            if !(defaults.double(forKey: "monthlyIncome") == 0) {
                monthlyIncome = defaults.double(forKey: "monthlyIncome")
            }
            else {
                monthlyIncome = 0
            }
            if !(defaults.double(forKey: "monthlyExpense") == 0) {
                monthlyExpense = defaults.double(forKey: "monthlyExpense")
            }
            else {
                monthlyExpense = 0
            }
            
            moneyLeftValueLabel.text = String(round(currentBudget*100)/100) + " " + currency
            budgetViewLabelIncome.text = String(round(monthlyIncome*100)/100) + " " + currency
            budgetViewLabelExpenses.text = String(round(monthlyExpense*100)/100) + " " + currency
            
        }
        // ======================
        // CONSTRAINTS
        // ======================
        screenHeight = UIScreen.main.bounds.height
        screenWidth = UIScreen.main.bounds.width
        
        budgetViewTop.constant = screenHeight * 0.05
        budgetViewWidth.constant = screenWidth * 0.8
        budgetViewHeight.constant = screenHeight * 0.25
        expenseButtonLeft.constant = 0.12 * screenWidth
        expenseButtonTop.constant = 0.04 * screenHeight
        incomeButtonRight.constant = 0.12 * screenWidth
        incomeButtonTop.constant = 0.04 * screenHeight
        moneyLeftViewLeft.constant = (0.2 * screenWidth) + 5
        recentSpendingLabelLeft.constant = (0.2 * screenWidth)
        recentSpendingViewWidth.constant = 0.8 * screenWidth
        recentSpendingViewHeight.constant = 0.2 * screenHeight
        popUpView2Top.isActive = false
        
        // TABLE VIEW
        recentSpendingTableView.dataSource = self
        recentSpendingTableView.delegate = self
        
        //KB
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        // OTHER
        popUpField1.placeholder = "Name"
        popUpField1.delegate = self as? UITextFieldDelegate
        popUpField2.delegate = self as? UITextFieldDelegate
        popUpField1Controller = MDCTextInputControllerOutlined(textInput: popUpField1)
        popUpField2Controller = MDCTextInputControllerOutlined(textInput: popUpField2)
        
        budgetViewExpenseView.clipsToBounds = true
        budgetViewIncomeView.clipsToBounds = true
        budgetViewExpenseViewImage.layer.cornerRadius = 20
        budgetViewIncomeViewImage.layer.cornerRadius = 20
        budgetViewExpenseViewImage.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        budgetViewIncomeViewImage.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        budgetViewExpenseView.layer.cornerRadius = 5
        budgetViewExpenseView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        budgetViewIncomeView.layer.cornerRadius = 5
        budgetViewIncomeView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        budgetView.layer.shadowColor = UIColor.black.cgColor
        budgetView.layer.shadowOffset = CGSize(width: -15.0, height: 15.0)
        budgetView.layer.shadowOpacity = 0.2
        budgetView.layer.shadowRadius = 15.0
        recentSpendingTableView.layer.cornerRadius = 5
        recentSpendingTableView.layer.maskedCorners = [.layerMinXMinYCorner]
        addExpenseButton.titleLabel?.adjustsFontSizeToFitWidth = true
        addExpenseButton.titleLabel?.lineBreakMode = .byClipping
        addIncomeButton.titleLabel?.adjustsFontSizeToFitWidth = true
        addIncomeButton.titleLabel?.lineBreakMode = .byClipping
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        // POP UP CONSTRAINTS
        popUpCenterX.constant = 5000
        popUpCenterY.isActive = true
        
        popUpOpacityView.isHidden = true
        popUpView.layer.cornerRadius = 3
        popUpView.backgroundColor = UIColor.white
        popUpView.layer.shadowColor = UIColor.black.cgColor
        popUpView.layer.shadowOffset = CGSize(width: -15.0, height: 15.0)
        popUpView.layer.shadowOpacity = 0.2
        popUpView.layer.shadowRadius = 15.0
        popUpLabel.textColor = UIColor.black
        popUpView.tintColor = UIColor(red: 150/255, green: 24/255, blue: 247/255, alpha: 1)
        popUpView.backgroundColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
        popUpDoneButton.layer.cornerRadius = 20
        
        popUpField1View.backgroundColor = UIColor.clear
        popUpField2View.backgroundColor = UIColor.clear
        popUpField1Controller.textInputFont = UIFont(name: "System", size: 17)
        popUpField1Controller.inlinePlaceholderFont = UIFont(name: "System", size: 17)
        popUpField2Controller.textInputFont = UIFont(name: "System", size: 25)
        popUpField2Controller.inlinePlaceholderFont = UIFont(name: "System", size: 25)
        
        if (sTsT == true && defaults.string(forKey: "hasFinishedSetup") != "yes") {
            popUpView(type: "setup")
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if (self.popUpCenterY.constant == 0) {
                if (keyboardSize.height>(0.25*screenHeight)){
                    UIView.animate(withDuration: 0.5, animations: {
                        self.popUpCenterY.constant += -1 * self.screenHeight * 0.15
                        self.masterView.layoutIfNeeded()
                        })
                }
                else {
                    UIView.animate(withDuration: 0.5) {
                        self.popUpCenterY.constant += -1 * keyboardSize.height * 0.2
                        self.masterView.layoutIfNeeded()
                    }
                }
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 0.5) {
            self.popUpCenterY.constant = 0
        }
    }

    @IBAction func addExpense(_ sender: Any) {
        popUpView(type: "expense")
    }
    @IBAction func addIncome(_ sender: Any) {
        popUpView(type: "income")
    }
    @IBAction func cancelPopUp(_ sender: Any) {
        view.endEditing(true)
        
        //animation
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            self.popUpCenterX.constant = 1000
            self.popUpOpacityView.alpha = 0
            self.masterView.layoutIfNeeded()
        }, completion: {(finished:Bool) in
            // the code you put here will be compiled once the animation finishes
            self.popUpOpacityView.effect = nil
            self.popUpOpacityView.isHidden = true
            self.popUpField1.text = ""
            self.popUpField2.text = ""
            })
    }
    
    @IBAction func addPopUp(_ sender: Any) {
        
        // CODE HERE //
        
        if !(popUpField2.text == ""){
            if (addType != "setup"){
                let date = Date()
                let formatter = DateFormatter()
                formatter.dateFormat = "MMM d, yyyy"
                let tempDate = formatter.string(from: date)
                let tempName = popUpField1.text
                let tempAmount = popUpField2.text
                //expense
                if (addType == "expense") {
                    if (popUpField1.text == "") {
                        spending_names.append("None")
                    }
                    else {
                        spending_names.append(tempName!)
                    }
                    spending_dates.append(tempDate)
                    spending_amounts.append(tempAmount!)
                    currentBudget! = currentBudget! - Double(tempAmount!)!
                    defaults.set(round(currentBudget*100)/100, forKey: "currentBudget")
                    defaults.set(spending_names, forKey: "spending_names")
                    defaults.set(spending_dates, forKey: "spending_dates")
                    defaults.set(spending_amounts, forKey: "spending_amounts")
                    monthlyExpense = defaults.double(forKey: "monthlyExpense")
                    monthlyExpense += Double(tempAmount!)!
                    defaults.set(monthlyExpense, forKey: "monthlyExpense")
                }
                //income
                else if (addType == "income") {
                    if (popUpField1.text == "") {
                        income_names.append("None")
                    }
                    else {
                        income_names.append(tempName!)
                    }
                    income_dates.append(tempDate)
                    income_amounts.append(tempAmount!)
                    currentBudget! = currentBudget! + Double(tempAmount!)!
                    defaults.set(round(currentBudget*100)/100, forKey: "currentBudget")
                    defaults.set(income_names, forKey: "income_names")
                    defaults.set(income_dates, forKey: "income_dates")
                    defaults.set(income_amounts, forKey: "income_amounts")
                    monthlyIncome = defaults.double(forKey: "monthlyIncome")
                    monthlyIncome += Double(tempAmount!)!
                    defaults.set(monthlyIncome, forKey: "monthlyIncome")
                }
                self.refreshData()
            }
            else {
                currentBudget = Double(popUpField2.text!)
                defaults.set(round(currentBudget*100)/100, forKey: "currentBudget")
                defaults.set("yes", forKey: "hasFinishedSetup")
                monthlyExpense = 0
                monthlyIncome = 0
                defaults.set(monthlyIncome, forKey: "monthlyIncome")
                defaults.set(monthlyExpense, forKey: "monthlyExpense")
                let date1 = Date()
                let formatter1 = DateFormatter()
                formatter1.dateFormat = "M"
                let tempMonth = formatter1.string(from: date1)
                month = Double(tempMonth)!
                defaults.set(month, forKey: "month")
                self.refreshData()
            }
        
        
                // ======== //
                // end of coding area
            
                //animation
                UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
                    self.popUpCenterX.constant = 1000
                    self.popUpOpacityView.alpha = 0
                    self.masterView.layoutIfNeeded()
                }, completion: {(finished:Bool) in
                    // the code you put here will be compiled once the animation finishes
                    self.popUpOpacityView.effect = nil
                    self.popUpOpacityView.isHidden = true
                    self.popUpField1.text = ""
                    self.popUpField2.text = ""
                })
        }
        view.endEditing(true)
    }
    
    func popUpView(type:String) {
        if !(type=="setup"){
            popUpView2Top.isActive = false
            popUpLabel.text = "Add " + type
        }
        addType = type
        // animations
        if (type=="setup"){
            popUpField2.placeholder = "Your budget"
            self.popUpCancelButton.isHidden = true
            self.popUpField1View.isHidden = true
            popUpLabel.text = "Your budget"
            popUpView2Top.isActive = true
        }
        else {
            popUpField2.placeholder = "Amount"
            self.popUpCancelButton.isHidden = false
            self.popUpField1View.isHidden = false
            
        }
        self.popUpOpacityView.isHidden = false
        self.popUpOpacityView.alpha = 1
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            self.popUpCenterX.constant = 0
            self.popUpOpacityView.effect = UIBlurEffect(style: .dark)
            self.masterView.layoutIfNeeded()
        }, completion: {(finished:Bool) in
            self.popUpField2.text = ""
            self.popUpField1.text = ""
        })
    }
    
    func setup() {
        sTsT = true
    }
    
    func refreshData() {
        currentBudget = defaults.double(forKey: "currentBudget")
        
        self.moneyLeftValueLabel.text = String(self.currentBudget) + " " + self.currency
        self.budgetViewLabelIncome.text = String(self.monthlyIncome) + " " + self.currency
        self.budgetViewLabelExpenses.text = String(self.monthlyExpense) + " " + self.currency
        
        recentSpendingTableView.reloadData()
    }
    

}

extension UIViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int ) -> Int {
        if !(UserDefaults.standard.object(forKey: "spending_names") == nil) {
            return UserDefaults.standard.array(forKey: "spending_names")!.prefix(5).count
        }
        else {
            return 0
        }
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! CustomCell
        cell.layer.backgroundColor = UIColor.clear.cgColor
        if !(UserDefaults.standard.object(forKey: "spending_names") == nil) {
            cell.showCellData(name: UserDefaults.standard.array(forKey: "spending_names")?.reversed().prefix(5)[indexPath.row] as! String, date: UserDefaults.standard.array(forKey: "spending_dates")?.reversed().prefix(5)[indexPath.row] as! String, amount: UserDefaults.standard.array(forKey: "spending_amounts")?.reversed().prefix(5)[indexPath.row] as! String)
        }
        return cell
    }
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}



