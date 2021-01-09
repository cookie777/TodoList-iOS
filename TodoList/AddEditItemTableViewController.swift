//
//  AddEditItemTableViewController.swift
//  TodoList
//
//  Created by Takayuki Yamaguchi on 2021-01-08.
//

import UIKit

protocol AddEditItemTableViewControllerDelegate : class {
    func addItem(todoItem: Todo)
    func editItem(todoItem: Todo, currentPath: IndexPath)
}

class AddEditItemTableViewController: UITableViewController {
    
    var headerTitles = ["Todo", "Descriptions"]
    
    // Store the current path and item you're editing. (if add -> nil)
    // path is used to specify which cell to update.
    var currentPath : IndexPath?
    var currentItem : Todo?
    
    // receive those who delegate
    weak var delegate: AddEditItemTableViewControllerDelegate?
    
    // prepare what cell to use
    var titleCell = AddEditIItemTableViewCell()
    var descriptionCell = AddEditIItemTableViewCell()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // prepare navigation buttons
        navigationController?.navigationBar.topItem?.backButtonTitle = "Cancel"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonPressed))
        
        
        
        // add target action to each textField of each cell
        // if textfield is changed, it will update save button status
        titleCell.maiTextFiled.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        descriptionCell.maiTextFiled.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        
        
        // If you're editing something -> edit mode. If edit nothing -> add mode
        if let currentItem = currentItem{
            navigationItem.title = "Edit item"
            titleCell.maiTextFiled.text = currentItem.title
            descriptionCell.maiTextFiled.text = currentItem.todoDescription
        }else{
            navigationItem.title = "Add item"
        }
        
        // Detect you can save now ? or not
        updateSaveButtonState()
        
    }
    
    // Change save button, enable or disable. If title is filled, enable.
    func updateSaveButtonState(){
        navigationItem.rightBarButtonItem?.isEnabled =
            titleCell.maiTextFiled.text?.count ?? 0 > 0
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    // Define what cell to use
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch indexPath {
        case [0, 0]:
          return titleCell
        case [1, 0]:
          return descriptionCell
        default:
          fatalError("Invalid number of cells")
        }
    }
    
    
    // Define each header of section
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headerTitles[section]
    }

    // If save  button is pressed
    @objc func saveButtonPressed(){
        let item = Todo(
            title: titleCell.maiTextFiled.text ?? "No title",
            todoDescription: descriptionCell.maiTextFiled.text ?? "",
            priority: currentItem?.priority ?? 0 , // fix later
            isCompleted: currentItem?.isCompleted ?? false
        )
        
        currentItem == nil ?
            delegate?.addItem(todoItem: item) :
            delegate?.editItem(todoItem: item, currentPath: currentPath!)

    }
    
    // If textField is changed
    @objc func textFieldChanged(){
        updateSaveButtonState()
    }

}
