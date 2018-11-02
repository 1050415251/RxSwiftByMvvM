//
//  FirstPageViewController.swift
//  RxSwiftByMvvm
//
//  Created by 国投 on 2018/11/2.
//  Copyright © 2018 FlyKite. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa


class FirstPageViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    private let disBg = DisposeBag()

    static let cellid = "FirstPageTableViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }

    private func initView() {
        tableView.tableFooterView = UIView()
//        tableView.dataSource = self

        let item = Observable.just([
            "文本输入框的用法",
            "开关按钮的用法",
            "进度条的用法",
            "文本标签的用法",
            ])


        //设置单元格数据（其实就是对 cellForRowAt 的封装）
        let _ = item.bind(to: tableView.rx.items(cellIdentifier: "FirstPageTableViewCell"))({ index,info,datacell in
            if let cell = datacell as? FirstPageTableViewCell {
                cell.textlabel.text = info
            }
        })

        tableView.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
            self?.tableView.deselectRow(at: indexPath, animated: true)
            print("选中项的indexPath为：\(indexPath)")
        }).disposed(by: disBg)

         

    }


}

extension FirstPageViewController: UITableViewDelegate,UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FirstPageViewController.cellid) as! FirstPageTableViewCell
        cell.textlabel.text = "12"
        return cell
    }

}
