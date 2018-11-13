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
import RxDataSources


class FirstPageViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    private let disBg = DisposeBag()


    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }

    private func initView() {
        tableView.tableFooterView = UIView()
//        tableView.dataSource = self

        let sections = Observable.just([
            ListDataBean.init(model: "123", items: [
                "12",
                "233",
                "434"
                ]),
            ListDataBean.init(model: "123", items: [
                "12",
                "233",
                "434"
                ]),
            ListDataBean.init(model: "123", items: [
                "12",
                "233",
                "434"
                ])
        ])

        let dataSource = RxTableViewSectionedReloadDataSource<ListDataBean>(
            configureCell: { dataSource,tableview,indexPath,info in
                let cell = tableview.dequeueReusableCell(withIdentifier: "FirstPageTableViewCell", for: indexPath) as! FirstPageTableViewCell
                cell.textlabel.text = info
                return cell
        },
            //设置分区头标题
            titleForHeaderInSection: { ds, index in
                return ds.sectionModels[index].title
        }
        )

        sections.bind(to: tableView.rx.items(dataSource: dataSource))

//        let item = Observable.just([
//            "文本输入框的用法",
//            "开关按钮的用法",
//            "进度条的用法",
//            "文本标签的用法",
//            ])
//        //设置单元格数据（其实就是对 cellForRowAt 的封装）
//        let _ = item.bind(to: tableView.rx.items(cellIdentifier: "FirstPageTableViewCell"))({ index,info,datacell in
//            if let cell = datacell as? FirstPageTableViewCell {
//                cell.textlabel.text = info
//            }
//        })
//
//        tableView.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
//            self?.tableView.deselectRow(at: indexPath, animated: true)
//            print("选中项的indexPath为：\(indexPath)")
//        }).disposed(by: disBg)



    }


}


class ListDataBean: SectionModelType {

    typealias Item = String

    var items: [String] = []

    var title: String = "你好啊"
    var desc: String = "呵呵"

    required init(original: ListDataBean, items: [String]) {

    }





}
