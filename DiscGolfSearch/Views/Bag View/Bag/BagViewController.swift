//
//  BagViewController.swift
//  DiscGolfSearch
//
//  Created by Kinney Kare on 12/24/23.
//

import UIKit
import DZNEmptyDataSet
import SwiftUI

class BagViewController: UIViewController {
    
    @IBOutlet weak var segControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    var coreDataManager: CoreDataManager!
    var bag: BagDataModel?
    var allDiscs: [DiscDataModel] = []
    var currentBagDiscs: [DiscDataModel] = []
    
    private var chartView: UIView?
    private var scatterChartView: UIView?
    private var oneDimensionalBarView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getDiscs()
    }
    
    private func setupView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("AppDelegate not found")
        }
        coreDataManager = appDelegate.coreDataManager
        
        segControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
    }
    
    // Function to handle segmented control value changed event
    @objc private func segmentedControlValueChanged() {
        switch segControl.selectedSegmentIndex {
        case 0:
            showDiscList()
        case 1:
            showCharts()
        default:
            break
        }
    }
    
    private func showDiscList() {
        tableView.isHidden = false
        scatterChartView?.isHidden = true
        oneDimensionalBarView?.isHidden = true
    }
    
    private func showCharts() {
        
        // Hide table view
        tableView.isHidden = true
        
        if let scatterChartView = scatterChartView {
            // Reuse existing scatter chart view
            scatterChartView.isHidden = false
        } else {
            createGraphs()
        }
        
        if let oneDimensionalBarView = oneDimensionalBarView {
            oneDimensionalBarView.isHidden = false
        }
    }
    
    private func getDiscs() {
        // Fetch discs from coreData
        let result = coreDataManager.fetch(DiscEntity.self)
        
        switch result {
        case .success(let discsFromCoreData):
            // Convert DiscEntity instances to DiscDataModel instances
            allDiscs = discsFromCoreData.map { DiscDataModel(id: $0.disc_id, selectedColor: $0.disc_color!, name: $0.disc_name!, nameSlug: $0.name_slug!, category: $0.category!, link: $0.link!, pic: $0.pic!, plastic: $0.plastic ?? "NA", stability: $0.stability!, speed: $0.speed!, glide: $0.glide!, turn: $0.turn!, fade: $0.fade!, brand: $0.brand!, bagName: $0.bag_name!, usedFor: $0.usedFor!, weight: $0.disc_weight ?? "NA") }
            filterDiscByBagId()
            tableView.reloadData()
        case .failure(let error):
            // Handle the error appropriately, e.g., show an alert or log the error
            print("Error fetching discs: \(error.localizedDescription)")
            AlertPresenter.instance.showAlert(title: "Error", body: "Failed to fetch discs. Please try again later.", iconImage: UIImage(systemName: "exclamationmark.circle.fill")!, bannerColor: .red) {
            }
        }
    }
    
    private func createGraphs() {
        // Create scatter chart view if it doesn't exist
        let controller = UIHostingController(rootView: BagScatterGraph(discs: currentBagDiscs))
        guard let newChartView = controller.view else { return }
        
        scrollView.addSubview(newChartView)
        scatterChartView = newChartView
        
        newChartView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            newChartView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 15),
            newChartView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            newChartView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            newChartView.heightAnchor.constraint(equalToConstant: 400)
        ])
        
        // Ensure the scatter chart view is correctly sized and laid out
        controller.view.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        controller.view.layoutIfNeeded()
        
        let oneDimensionalBar = OneDimensionalBar(isOverview: false)
        let swiftUIController = UIHostingController(rootView: oneDimensionalBar)
        swiftUIController.view.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(swiftUIController.view)
        
        NSLayoutConstraint.activate([
            swiftUIController.view.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            swiftUIController.view.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            swiftUIController.view.topAnchor.constraint(equalTo: newChartView.bottomAnchor),
            swiftUIController.view.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
        
        self.addChild(swiftUIController)
        swiftUIController.didMove(toParent: self)
        
        // Assign SwiftUI view to property
        oneDimensionalBarView = swiftUIController.view
        oneDimensionalBarView?.isHidden = true // Initially hide the SwiftUI view
    }
    
    private func filterDiscByBagId() {
        guard let bagId = bag?.id else { return }
        
        currentBagDiscs = allDiscs.filter { $0.id == bagId }
    }
}

//MARK: TableView Delegates
extension BagViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        currentBagDiscs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "discInBagCell", for: indexPath) as! DiscInBagCell
        cell.configure(with: currentBagDiscs[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let disc = currentBagDiscs[indexPath.item]
        
        let storyboard = UIStoryboard(name: "DiscInBagInfo", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "discInBagInfo") as? DiscInBagInfoViewController {
            vc.disc = disc
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

//MARK: Empty Data Source Delegates
extension BagViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
    func image(forEmptyDataSet scrollView: UIScrollView) -> UIImage? {
        return UIImage(named: "noDiscGolfDisc")
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let str = "No Discs Found"
        let attrs = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .headline)]
        return NSAttributedString(string: str, attributes: attrs)
    }
    
    func imageTintColor(forEmptyDataSet scrollView: UIScrollView) -> UIColor? {
        let userInterfaceStyle = scrollView.traitCollection.userInterfaceStyle
        if userInterfaceStyle != .dark {
            return UIColor.label
        } else {
            return UIColor.secondaryLabel
        }
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let str = "Tap the \"Disc\" tab, find & select a disc, tap the + at the top right and choose \"Add Disc To Bag\". "
        let attrs = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .body)]
        return NSAttributedString(string: str, attributes: attrs)
    }
    
}
