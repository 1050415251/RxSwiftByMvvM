//
//  LoginViewmodel.swift
//  RxSwiftByMvvm
//
//  Created by 国投 on 2019/1/9.
//  Copyright © 2019 FlyKite. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift


class LoginViewmodel: NSObject {

    var accont: Driver<String?>!
    var password: Driver<String?>!

    weak var ctr: LoginViewController!

    let client = NetClient()

    convenience  init(vc: LoginViewController) {
        self.init()
        self.ctr = vc
    }

    override init() {
        super.init()

    }


    func clicklogin() {
        accont = (ctr.accontTextField.rx.text).asDriver()
        password = (ctr.passwordTextField.rx.text).asDriver()

//        client.login(accont: accont, password: password).subscribe { (event) in
//            if let login = event.element {
//                ///可以做如下处理
//            }
//        }


        //返回username和password组合后的元组流
        let usernameAndPassword = Observable.combineLatest(accont.asObservable(), password.asObservable()) {
            return ($0, $1)
            }.flatMapLatest { (arg0) -> Observable<Loginmodel> in
                let (user, pass) = arg0
                return self.client.login(accont: user!, password: pass!)
        }
    
    }

}


class NetClient: NSObject {

    func login(accont: String,password: String) -> Observable<Loginmodel> {


        return Observable<Loginmodel>.create({ (event) -> Disposable in
             sleep(2)

            let loginmodel = Loginmodel()
            loginmodel.status = "登录成功"
            loginmodel.username = "红鲤鱼与绿鲤鱼与驴"

            /// 直接向订阅者发送信号
            event.on(Event.next(loginmodel))
            event.on(Event.completed)

            //event.onNext(<#T##element: Loginmodel##Loginmodel#>)
            //event.onError(<#T##error: Error##Error#>)
            //event.onCompleted()
            /// 订阅next信号 和 err信号 还有完成信号 并进行不同的处理


            ///subscribe(onNext: <#T##((Loginmodel) -> Void)?##((Loginmodel) -> Void)?##(Loginmodel) -> Void#>, onError: <#T##((Error) -> Void)?##((Error) -> Void)?##(Error) -> Void#>, onCompleted: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>, onDisposed: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>)
            return Disposables.create {

            }
        })

    }

}


class Loginmodel: NSObject {

    var status = ""
    var username = ""

}
