//
//  LoginViewController.swift
//  RxSwiftByMvvm
//
//  Created by 国投 on 2019/1/9.
//  Copyright © 2019 FlyKite. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

class LoginViewController: UIViewController {



    
    @IBOutlet weak var accontTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var loginstatusLab: UILabel!
    @IBOutlet weak var msmlab: UILabel!

    lazy var vm = LoginViewmodel.init(vc: self)

    @IBAction func clicklogin(_ sender: Any) {
        //// 点击登录
            vm.clicklogin()
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSignal()
    }

}


extension LoginViewController {

    /// 被观察者 loginobserver
    private var loginobserver: AnyObserver<Bool> {
        return AnyObserver.init(eventHandler: { [weak self] (event) in
            if let canlogin = event.element {
                self?.loginBtn.backgroundColor = canlogin ?  UIColor.red:UIColor.gray
            }
        }).asObserver()
    }

    var finishbserver: AnyObserver<Loginmodel> {
        return AnyObserver.init(eventHandler: { [weak self] (event) in
            if let loginmodel = event.element {
                self?.loginstatusLab.text = loginmodel.username
            }
        }).asObserver()
    }

    /// 整个业务处理流程为 创建 账号密码输入框文字改变的观察者 ---》 发送响应信号 ---》 筛选并合并响应信号 ===》 订阅收到相应信号并处理
    private func setUpSignal() {
        ///
        let inputaccontObserVerable = accontTextField.rx.text
        let inputpasswordObserVerable = passwordTextField.rx.text



        /**
         Returns an observable sequence that **shares a single subscription to the underlying sequence**, and immediately upon subscription replays  elements in buffer.

         This operator is equivalent to:
         * `.whileConnected`
         ```
         // Each connection will have it's own subject instance to store replay events.
         // Connections will be isolated from each another.
         source.multicast(makeSubject: { Replay.create(bufferSize: replay) }).refCount()
         ```
         * `.forever`
         ```
         // One subject will store replay events for all connections to source.
         // Connections won't be isolated from each another.
         source.multicast(Replay.create(bufferSize: replay)).refCount()
         ```

         It uses optimized versions of the operators for most common operations.

         - parameter replay: Maximum element count of the replay buffer.
         - parameter scope: Lifetime scope of sharing subject. For more information see `SubjectLifetimeScope` enum.

         - seealso: [shareReplay operator on reactivex.io](http://reactivex.io/documentation/operators/replay.html)

         - returns: An observable sequence that contains the elements of a sequence produced by multicasting the source sequence.
         */

//        shareReplay 会返回一个新的事件序列，它监听底层序列的事件，并且通知自己的订阅者们。
//        解决有多个订阅者的情况下，map会被执行多次的问题。

          // 返回一个可观察序列，该序列**共享对基础序列**的单个订阅，并在订阅后立即在缓冲区中重播元素。

          //参数replay：重放缓冲区的最大元素计数。
      //  public func share(replay: Int = default, scope: RxSwift.SubjectLifetimeScope = default) -> RxSwift.Observable<Self.E>
        let accontobseque = inputaccontObserVerable.share(replay: 1).map {
            return $0!.count == 11
        }

        /// 返回一个可观察的序列 比如 输入的信号为 1，12，123 那么将这个信号转换为 false，false，false，具体可以根据业务需求来
        let passwordseque = inputpasswordObserVerable.share(replay: 1).map {
            return $0!.count == 6
        }


        /// 观察者合并两个信号 进行后续操作 可以是用bindto 也可以使用订阅
//        let _ = Observable.combineLatest(accontobseque, passwordseque) {
//            return $0 && $1
//            }.subscribe { (event) in
//                if let canlogin = event.element {
//                    ////
//                }
//        }
        let _ = Observable.combineLatest(accontobseque, passwordseque) {
            return $0 && $1
        }.bind(to: loginobserver)

    }

}
