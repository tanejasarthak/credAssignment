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
            tblView.bounces = false
            tblView.register(UINib(nibName: "AmountSelectionCircularProgressBarTableViewCell", bundle: nil), forCellReuseIdentifier: "AmountSelectionCircularProgressBarTableViewCell")
            tblView.register(UINib(nibName: "EMISelectionRepaymentTableViewCell", bundle: nil), forCellReuseIdentifier: "EMISelectionRepaymentTableViewCell")
            tblView.register(UINib(nibName: "SendMoneyToBankTableViewCellTableViewCell", bundle: nil), forCellReuseIdentifier: "SendMoneyToBankTableViewCellTableViewCell")
            tblView.register(UINib(nibName: "CollpasedTableViewCell", bundle: nil), forCellReuseIdentifier: "CollpasedTableViewCell")
        }
    }
    @IBOutlet weak var bottomContainerView: UIView!
    
    // MARK: - Properties
    private var viewModel: MainControllerViewModel!
    var bottomCTAView: BottomCTAView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel = MainControllerViewModel(dataSource: [.amountSelection, .emiSelection, .bankSelection])
        
        // MARK: - Add UIViews
        bottomCTAView = BottomCTAView(viewModel: BottomCTAViewModel(model: BottomCTAModel(ctaTitleString: viewModel.getPrimaryCTAStringBasedOnViewType())))
        addBottomCTAView()
    }
    
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func addBottomCTAView() {
        bottomCTAView.translatesAutoresizingMaskIntoConstraints = false
        bottomCTAView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(bottomCTATapped)))
        self.bottomContainerView.addSubview(bottomCTAView)
        
        bottomCTAView.leadingAnchor.constraint(equalTo: self.bottomContainerView.leadingAnchor).isActive = true
        bottomCTAView.trailingAnchor.constraint(equalTo: self.bottomContainerView.trailingAnchor).isActive = true
        bottomCTAView.bottomAnchor.constraint(equalTo: bottomContainerView.bottomAnchor).isActive = true
        bottomCTAView.topAnchor.constraint(equalTo: bottomContainerView.topAnchor).isActive = true
    }
    
    @objc func bottomCTATapped() {
        let previouslyCurrentlySelectedView = viewModel.getCurrentlySelectedView()
        if previouslyCurrentlySelectedView == .bankSelection {
            return
        }
        
        viewModel.bottomCTATapped(on: viewModel.getCurrentlySelectedView())
        let afterCurrentlySelectedView = viewModel.getCurrentlySelectedView()
        
        tblView.beginUpdates()
        if afterCurrentlySelectedView == .emiSelection {
            tblView.deleteRows(at: [IndexPath(row: 0, section: 0)], with: .top)
            tblView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .bottom)
            
            tblView.deleteRows(at: [IndexPath(row: 1, section: 0)], with: .bottom)
            tblView.insertRows(at: [IndexPath(row: 1, section: 0)], with: .bottom)
        } else if afterCurrentlySelectedView == .bankSelection {
            tblView.deleteRows(at: [IndexPath(row: 1, section: 0)], with: .top)
            tblView.insertRows(at: [IndexPath(row: 1, section: 0)], with: .bottom)
            
            tblView.deleteRows(at: [IndexPath(row: 2, section: 0)], with: .top)
            tblView.insertRows(at: [IndexPath(row: 2, section: 0)], with: .bottom)
        }
        tblView.endUpdates()
        
        bottomCTAView.populateDynamicData(with: BottomCTAModel(ctaTitleString: viewModel.getPrimaryCTAStringBasedOnViewType()))
    }
}

// MARK: - UITableViewDelegate and Datasource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getNumberOfRowsInTableView()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel.getTableViewCell(tableView, indexPath: indexPath, vc: self) ?? UITableViewCell()
    }
}



// MARK: - Collapsed TableView Delegate
extension ViewController: CollpasedTableViewCellProtocol {
    func collapsedTableViewCellTapped(at tag: Int) {
        print(tag)
        viewModel.expandView(at: tag)
       // tblView.reloadData()
        
        if tag == 0 {
            // delete 1 and 2
            tblView.beginUpdates()
            
            tblView.deleteRows(at: [IndexPath(row: 2, section: 0)], with: .bottom)
            tblView.insertRows(at: [IndexPath(row: 2, section: 0)], with: .bottom)
            
            tblView.deleteRows(at: [IndexPath(row: 1, section: 0)], with: .bottom)
            tblView.insertRows(at: [IndexPath(row: 1, section: 0)], with: .bottom)
            
            tblView.deleteRows(at: [IndexPath(row: 0, section: 0)], with: .bottom)
            tblView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .top)
            
            tblView.endUpdates()
        } else if tag == 1 {
            // delete 2 // 0 should still be collapsed
            tblView.beginUpdates()
            tblView.deleteRows(at: [IndexPath(row: 2, section: 0)], with: .bottom)
            tblView.insertRows(at: [IndexPath(row: 2, section: 0)], with: .bottom)
            
            tblView.deleteRows(at: [IndexPath(row: 1, section: 0)], with: .bottom)
            tblView.insertRows(at: [IndexPath(row: 1, section: 0)], with: .top)
            tblView.endUpdates()
        }
        bottomCTAView.populateDynamicData(with: BottomCTAModel(ctaTitleString: viewModel.getPrimaryCTAStringBasedOnViewType()))
    }
}

extension ViewController: EMISelectionRepaymentTableViewCellProtocol {
    func viewSelected(at uid: UUID) {
        viewModel.selectEMIPlan(for: uid)
    }
}
