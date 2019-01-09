//
//  ViewController.swift
//  RxSwiftByMvvm
//
//  Created by 国投 on 2018/12/3.
//  Copyright © 2018 FlyKite. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift
import RxDataSources

class RootViewController: UIViewController {

    lazy var tableView: UITableView = {
        let tableV = UITableView()
        tableV.frame = self.view.bounds
//        tableV.delegate = self
//        tableV.dataSource = self
        tableV.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: cellid)
        return tableV
    }()

    let cellid = "a"

    let diBg = DisposeBag()

    let vm = InfoViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        initView()
        bindVM()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }

    private func initView() {
        self.view.addSubview(tableView)

    }

    private func bindVM() {
        //     可以观察            观察者             signal
        //---observeral-------observerable-------observer---------------------------->
//        vm.infoArray.bind(to: tableView.rx.items(cellIdentifier: cellid)) { row,model,cell in
//            cell.textLabel?.text = model.name
//        }.disposed(by: diBg)

//        vm.infoArray.bind(to: tableView.rx.items) { tablev,row,model -> UITableViewCell in
//
//        }
        (tableView.rx.itemSelected).subscribe {  (event) in
            if let indexPath = event.element {
                self.tableView.deselectRow(at: indexPath, animated: true)
            }
        }

        let _ = tableView.rx.modelSelected(InfoModel.self).subscribe { (event) in
            if let model = event.element {

                debugPrint("点击了\(model.name ?? "")")
            }
        }
    }

}
//
//extension RootViewController: UITableViewDelegate,UITableViewDataSource {
//
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return vm.infoArray.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath)
//        cell.focusStyle = .default
//        cell.textLabel?.text = "\(vm.infoArray[indexPath.row].name ?? "")"
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
//}


struct InfoModel {

    var name:String?
    var age:Int?

    init(name: String,age: Int) {
        self.name = name
        self.age = age
    }

}

struct InfoViewModel {

    let infoArray = Observable.just([
         InfoModel.init(name: "a", age: 0),
         InfoModel.init(name: "b", age: 1),
         InfoModel.init(name: "c", age: 3),
         InfoModel.init(name: "d", age: 4)
    ])

}
