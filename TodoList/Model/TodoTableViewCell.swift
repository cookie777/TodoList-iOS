//
//  TodoTableViewCell.swift
//  TodoList
//
//  Created by Takayuki Yamaguchi on 2021-01-07.
//

import UIKit

class TodoTableViewCell: UITableViewCell {
    
    let mainLabel: UILabel = {
        let lb = UILabel()
        return lb
    }()
    
    
    let completionLabel: UILabel = {
        let lb = UILabel()
        lb.text = Symbol.unChecked
        lb.constraintWidth(equalToConstant: 40)
        lb.setContentHuggingPriority(.required, for: .horizontal)
        return lb
    }()
    
    lazy var mainStackView: UIStackView = HorizontalStackView(arrangedSubviews: [completionLabel, mainLabel], spacing: 16, alignment: .fill ,distribution: .fill)

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        contentView.addSubview(mainStackView)
        mainStackView.matchParent(padding: .init(top: 16, left: 16, bottom: 16, right: 106))
        

        accessoryType = .detailButton

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateUI(todo: Todo)  {
        mainLabel.text = todo.title
        completionLabel.text = todo.isCompleted ?  Symbol.checked : Symbol.unChecked
    }

    func reverseCompletion(isComplete: Bool) {
        completionLabel.text = isComplete ?  Symbol.unChecked : Symbol.checked
    }
    
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//        self.accessoryType = selected ? .checkmark : .none
//    }
    
}
