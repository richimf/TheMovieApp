//
//  CategoryFilterViewController.swift
//  TheMovieApp
//
//  Created by Richie on 10/7/19.
//  Copyright © 2019 Rappi. All rights reserved.
//

import UIKit

protocol CategoryFilterDelegate: class {
  func filteredSections(ids: [Int])
}
class CategoryFilterViewController: UIViewController {
  
  // IBOUTLETS
  @IBOutlet private weak var tableView: UITableView!
  @IBOutlet weak var clearButton: UIButton!
  @IBOutlet weak var filterButton: RoundButton!
  
  // PRIVATE VARS
  private var colors: [UIColor] = []
  
  // DELEGATE
  var delegate: CategoryFilterDelegate?
  
  // DATA
  var items: [Genre] = []
  var selectedGenresIds: [Int] = []
  
  // CONSTANTS
  private let cellHeight: CGFloat = 175.0
  private lazy var identifier: String = CategoryTableViewCell.reuseIdentifier()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    //Select items previously selected
    defaultSelectedItems()
    // Do any additional setup after loading the view.
    setupTableView()
    // Generate Rows colors
    for _ in 0..<items.count {
      colors.append(UIColor.random)
    }
  }
  
  @IBAction func filter(_ sender: Any) {
    delegate?.filteredSections(ids: selectedGenresIds)
    self.dismiss(animated: true, completion: nil)
  }
  
  @IBAction func clearSelections(_ sender: Any) {
    selectedGenresIds = []
    delegate?.filteredSections(ids: selectedGenresIds)
    self.dismiss(animated: true, completion: nil)
  }
  
  private func setupTableView() {
    //clear background
    self.view.backgroundColor = UIColor.clear
    
    // Tableview setup
    self.tableView.backgroundColor = UIColor.clear
    self.tableView.delegate = self
    self.tableView.dataSource = self
    self.tableView.allowsMultipleSelection = true
    self.tableView.estimatedRowHeight = cellHeight
    self.tableView.rowHeight = UITableView.automaticDimension
    self.tableView.register(CategoryTableViewCell.nib(), forCellReuseIdentifier: identifier)

    // Blur Effect
    let blurEffectView = BlurEffectHelper.getBlurEffect(frame: self.view.frame, style: .prominent)
    self.view.insertSubview(blurEffectView, at: 0)
  }
}
extension CategoryFilterViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? CategoryTableViewCell else
    { return UITableViewCell() }
    let item = items[indexPath.row]
    cell.setup(item: item, color: colors[indexPath.row], select: item.selected)
    performSelectionAt(tableView, at: indexPath, select: items[indexPath.row].selected )
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let isSelected = !items[indexPath.row].selected
    performSelectionAt(tableView, at: indexPath, select: isSelected)
    items[indexPath.row].selected = isSelected
    saveSelectedItems(at: indexPath, select: isSelected)
  }
  
  private func performSelectionAt(_ tableView: UITableView, at indexPath: IndexPath, select: Bool) {
    if select {
      tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
    } else {
      tableView.deselectRow(at: indexPath, animated: false)
    }
  }
  
  private func defaultSelectedItems() {
    for row in 0..<items.count {
      let item = self.items[row]
      self.items[row].selected = selectedGenresIds.contains(item.id)
    }
  }
  
  private func saveSelectedItems( at indexPath: IndexPath, select: Bool) {
    let id = items[indexPath.row].id
    if select {
      if !selectedGenresIds.contains(id) {
        selectedGenresIds.append(id)
      }
    } else {
      var index = 0
      selectedGenresIds.forEach { genre in
        if genre == id && index < selectedGenresIds.count{
          selectedGenresIds.remove(at: index)
        }
        index += 1
      }
    }
  }
}
