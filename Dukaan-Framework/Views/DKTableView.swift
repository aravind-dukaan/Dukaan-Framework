//
//  DKTableView.swift
//  Dukaan
//
//  Created by Raja Earla on 22/12/21.
//

/*import UIKit

func dkTableView(_ style: UITableView.Style = .plain,
               delegateSources: UITableViewDelegate & UITableViewDataSource,
               _ cells: [UITableViewCell.Type],
               headerFooters: [UITableViewHeaderFooterView.Type]? = []) -> UITableView {
    let tableView                 = UITableView(frame: .zero, style: style)
    tableView.separatorStyle      = .none
    tableView.keyboardDismissMode = .onDrag
    tableView.backgroundColor     = .bgSecondary
    tableView.rowHeight           = UITableView.automaticDimension
    tableView.showsVerticalScrollIndicator              = false
    tableView.showsHorizontalScrollIndicator            = false
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.delegate                                  = delegateSources
    tableView.dataSource                                = delegateSources
    
    cells.forEach { cell in tableView.register(cell.self) }
    headerFooters?.forEach { view in tableView.register(view.self) }
    tableView.sectionHeaderHeight = 0
    tableView.sectionFooterHeight = 0
    if #available(iOS 15.0, *) {
        tableView.sectionHeaderTopPadding = 0
    }
    return tableView
}
*/
