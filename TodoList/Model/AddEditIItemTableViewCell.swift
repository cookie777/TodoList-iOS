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
    
    var textField : UITextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        return tf
    }()
    
    var segmentControll : UISegmentedControl = {
        let items = [PriorityTitle.First, PriorityTitle.Second,PriorityTitle.Third]
        let sc = UISegmentedControl(items: items)
        sc.selectedSegmentIndex = 1
        return sc
    }()
    
    init(style: UITableViewCell.CellStyle, reuseIdentifier: String? ,cellType: CellType) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        switch cellType {
        case .textField:
            contentView.addSubview(textField)
            textField.matchParent(padding: .init(top: 8, left: 16, bottom: 8, right: 16))
        case .segmentControl:
            contentView.addSubview(segmentControll)
            segmentControll.matchParent(padding: .init(top: 8, left: 16, bottom: 8, right: 16))
        case .date:
            print("date")
        }
    }
 


    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
