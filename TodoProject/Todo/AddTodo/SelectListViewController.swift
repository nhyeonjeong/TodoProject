//
//  SelectListViewController.swift
//  TodoProject
//
//  Created by 남현정 on 2024/02/23.
//

import UIKit
import SnapKit
import RealmSwift

class SelectListViewController: BaseViewController {
    
    var list: Results<ListTable>!
    var selectedListIdx: ((Int) -> Void)?
    let listRepository = ListTableRepository()
    
    let tableView: UITableView = {
        let view = UITableView()
        view.rowHeight = UITableView.automaticDimension
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        list = listRepository.fetch()
        view.backgroundColor = Constants.Color.backgroundColor
        configureTableView()
        // Do any additional setup after loading the view.
    }
    
    override func configureHierarchy() {
        view.addSubview(tableView)
    }
    
    override func configureConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }


}

extension SelectListViewController: UITableViewDelegate, UITableViewDataSource {
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.identifier)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath) as? ListTableViewCell else {
            return UITableViewCell()
        }
        cell.configureCell(list[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedListIdx?(indexPath.row)
        navigationController?.popViewController(animated: true)
        
    }

}
