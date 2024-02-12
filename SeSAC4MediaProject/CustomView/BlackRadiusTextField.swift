//
//  BlackRadiusTextField.swift
//  SeSAC4Seflix
//
//  Created by Minho on 1/29/24.
//

import UIKit

/*
    스토리보드 기반 > required init
    코드 기반 > override init + required init
 */
@IBDesignable
class BlackRadiusTextField: UITextField {

    // 코드로만 작업하는 경우 init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    
    func configureView() {
        backgroundColor = .clear
        textAlignment = .center
        borderStyle = .none
        layer.cornerRadius = 8
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
    }
    
    // 스토리보드로 작업했을 때 init
    // 왜 실패가 될 수 있게, 초기화가 안 될 수 있게 해 둔 것일까?
    // 코드 베이스에서는 필요하지 않은 init이라 무조건 에러 남.
    // 추가적인 이해가 필요할 듯..
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        print("textField requied init")
        // fatalError 는 만나면 바로 종료됨.
        // fatalError("init(coder:) has not been implemented")
        configureView()
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
}

protocol Example {
    func example()
    init()
}

//class Apple: Mobile {
//
//        
//}
//
//class Mobile: Example {
//    
//    let name: String
//    
//    /*
//        프로토콜을 채택함으로서 프로토콜에서 온 init = required init
//        (override의 경우 superclass에서 온 init)
//        
//        반드시 채택을 하여야 할 이유가 있음.
//     */
//    required init() {
//        
//    }
//    
//    init(name: String) {
//        self.name = name
//    }
//    
//    func example() {
//        
//    }
//}
