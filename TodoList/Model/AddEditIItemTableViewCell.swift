//
//  AddEditIItemTableViewCell.swift
//  TodoList
//
//  Created by Takayuki Yamaguchi on 2021-01-08.
//

import UIKit

class AddEditIItemTableViewCell: UITableViewCell {

//    var maiTextView : UITextView = {
//        let tv = UITextView()
////        tv.constraintHeight(equalToConstant: 64)
//        tv.isEditable = true
//        tv.font = .systemFont(ofSize: 16)
//        return tv
//    }()
    
    var maiTextFiled : UITextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        return tf
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(maiTextFiled)
        maiTextFiled.matchParent(padding: .init(top: 8, left: 16, bottom: 8, right: 16))
        
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
