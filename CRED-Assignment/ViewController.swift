//
//  ViewController.swift
//  CRED-Assignment
//
//  Created by Sarthak Taneja on 21/11/23.
//

import UIKit

class ViewController: UIViewController {
    
//    static func getInstance() -> ViewController {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
//        let vm = MainControllerViewModel(dataSource: [.amountSelection])
//        vc.viewModel = vm
//        return vc
//    }
    
    // MARK: - IBOutlets
    @IBOutlet weak var tblView: UITableView! {
        didSet {
            tblView.delegate = self
            tblView.dataSource = self
            tblView.register(UINib(nibName: "AmountSelectionCircularProgressBarTableViewCell", bundle: nil), forCellReuseIdentifier: "AmountSelectionCircularProgressBarTableViewCell")
            tblView.register(UINib(nibName: "EMISelectionRepaymentTableViewCell", bundle: nil), forCellReuseIdentifier: "EMISelectionRepaymentTableViewCell")
            tblView.register(UINib(nibName: "SendMoneyToBankTableViewCellTableViewCell", bundle: nil), forCellReuseIdentifier: "SendMoneyToBankTableViewCellTableViewCell")
        }
    }
    @IBOutlet weak var bottomContainerView: UIView!
    
    // MARK: - Properties
    private var viewModel: MainControllerViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel = MainControllerViewModel(dataSource: [.amountSelection, .emiSelection])
        
        // MARK: - Add UIViews
        addBottomCTAView()
            //addAmountSelectionCircularProgressBar()
    }
    
//    private func addAmountSelectionCircularProgressBar() {
//        if let amountSelectionView = Bundle.main.loadNibNamed("AmountSelectionCircularProgressBarView", owner:
//                                                                self, options: nil)?.first as? AmountSelectionCircularProgressBarView {
//            amountSelectionView.translatesAutoresizingMaskIntoConstraints = false
//            self.view.addSubview(amountSelectionView)
//
//            amountSelectionView.configureView(vm: AmountSelectionCircularProgressBarViewModel(dataModel: AmountSelectionCircularProgressBarModel(selectedAmount: 1000, interestRate: 20, isCurrentlyActiveView: false)))
//
//            amountSelectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
//            amountSelectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
//            amountSelectionView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
//        }
//    }
    
    private func addBottomCTAView() {
        let bottomCTAView = BottomCTAView(viewModel: BottomCTAViewModel(model: BottomCTAModel(ctaTitleString: "Something")))
        bottomCTAView.translatesAutoresizingMaskIntoConstraints = false
        bottomCTAView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(bottomCTATapped)))
        self.bottomContainerView.addSubview(bottomCTAView)
        
        bottomCTAView.leadingAnchor.constraint(equalTo: self.bottomContainerView.leadingAnchor).isActive = true
        bottomCTAView.trailingAnchor.constraint(equalTo: self.bottomContainerView.trailingAnchor).isActive = true
        bottomCTAView.bottomAnchor.constraint(equalTo: bottomContainerView.bottomAnchor).isActive = true
        bottomCTAView.topAnchor.constraint(equalTo: bottomContainerView.topAnchor).isActive = true
    }
    
    @objc func bottomCTATapped() {
        viewModel.bottomCTATapped(on: viewModel.getCurrentlySelectedView())
        tblView.reloadData()
    }
}

// MARK: - UITableViewDelegate and Datasource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getNumberOfRowsInTableView()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let tableViewRowData = viewModel.getDataForRow(at: indexPath.row) {
            if let amountSelectionData = tableViewRowData as? AmountSelectionCircularProgressBarModel {
                let amountSelectionTblViewCell: AmountSelectionCircularProgressBarTableViewCell = tableView.dequeueReusableCell(withIdentifier: "AmountSelectionCircularProgressBarTableViewCell") as! AmountSelectionCircularProgressBarTableViewCell
                amountSelectionTblViewCell.configureView(vm: AmountSelectionCircularProgressBarViewModel(dataModel: amountSelectionData))
                return amountSelectionTblViewCell
            } else if let emiSelectionData = tableViewRowData as? EMISelectionRepaymentTableViewCell.Model {
                let emiSelectionTblViewCell: EMISelectionRepaymentTableViewCell = tableView.dequeueReusableCell(withIdentifier: "EMISelectionRepaymentTableViewCell") as! EMISelectionRepaymentTableViewCell
                emiSelectionTblViewCell.configureView(with: emiSelectionData)
                return emiSelectionTblViewCell
            } else if let bankSelectionData = tableViewRowData as? SendMoneyToBankTableViewCellTableViewCell.Model {
                let bankSelectionTblViewCell: SendMoneyToBankTableViewCellTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SendMoneyToBankTableViewCellTableViewCell") as! SendMoneyToBankTableViewCellTableViewCell
                bankSelectionTblViewCell.configureView(with: bankSelectionData)
                return bankSelectionTblViewCell
            }
        }
        
        return UITableViewCell()
    }
}
