//
//  AddEditItemTableViewController.swift
//  TodoList
//
//  Created by Takayuki Yamaguchi on 2021-01-08.
//

import UIKit

protocol AddEditItemTableViewControllerDelegate : class {
    func addItem(newItem: Todo)
    func editItem(editedItem: Todo, selectedPath: IndexPath)
}

class AddEditItemTableViewController: UITableViewController {
    
    var headerTitles = ["Todo", "Priority","Descriptions"]
    
    // Store the current path and item you're editing. (if add -> nil)
    // path is used to specify which cell to update.
    var selectedPath : IndexPath?
    var selectedItem : Todo?
    
    // receive those who delegate
    weak var delegate: AddEditItemTableViewControllerDelegate?
    
    // prepare what cell to use
    var titleCell = AddEditIItemTableViewCell(style: .default, reuseIdentifier: nil, cellType: .textField)
    var descriptionCell = AddEditIItemTableViewCell(style: .default, reuseIdentifier: nil, cellType: .textField)
    var priorityCell = AddEditIItemTableViewCell(style: .default, reuseIdentifier: nil, cellType: .segmentControl)

    override func viewDidLoad() {
        super.viewDidLoad()
        

        // prepare navigation buttons
        navigationController?.navigationBar.topItem?.backButtonTitle = "Cancel"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonPressed))
        
        
        
        // add target action to each textField of each cell
        // if textfield is changed, it will update save button status
        titleCell.textField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        descriptionCell.textField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        
        
        // If you're editing something -> edit mode. If edit nothing -> add mode
        if let selectedItem = selectedItem{
            navigationItem.title = "Edit item"
            titleCell.textField.text = selectedItem.title
            descriptionCell.textField.text = selectedItem.todoDescription
            priorityCell.segmentControl.selectedSegmentIndex = selectedItem.priority
        }else{
            navigationItem.title = "Add item"
        }
        
        // Detect you can save now ? or not
        updateSaveButtonState()
        
    }
    
    // Change save button, enable or disable. If title is filled, enable.
    func updateSaveButtonState(){
        navigationItem.rightBarButtonItem?.isEnabled =
            titleCell.textField.text?.count ?? 0 > 0
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return headerTitles.count
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
          return priorityCell
        case [2, 0]:
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
            title: titleCell.textField.text ?? "No title",
            todoDescription: descriptionCell.textField.text ?? "",
            priority: priorityCell.segmentControl.selectedSegmentIndex,
            isCompleted: selectedItem?.isCompleted ?? false
        )

        selectedItem == nil ?
            delegate?.addItem(newItem: item) :
            delegate?.editItem(editedItem: item, selectedPath: selectedPath!)

    }
    
    // If textField is changed
    @objc func textFieldChanged(){
        updateSaveButtonState()
    }

}
