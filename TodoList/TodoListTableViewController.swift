//
//  TodoListTableViewController.swift
//  TodoList
//
//  Created by Takayuki Yamaguchi on 2021-01-07.
//

import UIKit

class TodoListTableViewController: UITableViewController {
    
    var todoItems : [Todo] = Todo.sampleData
    
    //Create button (to make self first, I made it lazy)
    lazy var removeButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(removeItems))
    lazy var addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonPressed))


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        tableView.register(TodoTableViewCell.self, forCellReuseIdentifier: todoCell)
        
        // add edit button on left
        navigationItem.leftBarButtonItem = editButtonItem
        // Allow editing mode to multiple selection
        // If cell is selected, it will invoke usual didSelectRowAt
        tableView.allowsMultipleSelectionDuringEditing = true
        
        
        // add delete button on right (by default, not enable)
        navigationItem.rightBarButtonItems =  [addButton, removeButton]
        removeButton.isEnabled = false
        
        // dynamic row height
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 32

    }

    // move to Add(Edit) item screen.
    func moveToAddEditItemVC(currentPath: IndexPath? = nil){
        let nextVC = AddEditItemTableViewController(style: .grouped)
        nextVC.delegate = self
        // if you're editing, assign current selected item.
        if let currentPath = currentPath{
            nextVC.currentPath = currentPath
            nextVC.currentItem = todoItems[currentPath.row]
        }
        navigationController?.pushViewController(nextVC, animated: true)
    }

}


// objc functions. Actions if pressed.
extension TodoListTableViewController{
    @objc func addButtonPressed(){
        moveToAddEditItemVC()
    }
    
    @objc func removeItems(){
        // Get current selected paths
        guard let indexPaths = tableView.indexPathsForSelectedRows else {return}
        // Get ids from selected paths
        let ids = indexPaths.map {todoItems[$0.row].id}
        // remove all items that has id by using ids
        todoItems.removeAll {ids.contains($0.id)}
        // update view
        tableView.deleteRows(at: indexPaths, with: .automatic)
        // End the deletion mode
        removeButton.isEnabled = false
        

     //let indexesToRemove = indexPaths.map {$0.row}.sorted()
//        var offSet = 0
//        for var i in indexesToRemove{
//            i -= offSet
//            TodoData.remove(at: i)
//            offSet += 1
//        }
    }
}


extension TodoListTableViewController: AddEditItemTableViewControllerDelegate{
    
    // delegator will invoke this when save button is pressed
    func addItem(todoItem: Todo) {
        
        // add to data
        todoItems.insert(todoItem, at: todoItems.count)
        // update view (warning?)
        tableView.insertRows(at: [IndexPath(row: todoItems.count - 1, section: 0)], with: .none)
        // back to main tableview
        navigationController?.popToRootViewController(animated: true)
        //print(todoItems.map{$0.title})
    }
    
    // delegator will invoke this when save button is pressed
    func editItem(todoItem: Todo, currentPath: IndexPath) {
        print(currentPath)
        // remove previous item
        todoItems.remove(at: currentPath.row)
        // add the new item
        todoItems.insert(todoItem, at: currentPath.row)
        // update view (warning?)
        tableView.reloadRows(at: [currentPath], with: .none)
        // back to main tableview
        navigationController?.popToRootViewController(animated: true)
//        print(todoItems.map{$0.title})
    }
    
    
}


extension TodoListTableViewController{
    
    // MARK: - Table view data source
    
    // How many sections?
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    // How many raws at each sections?
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return todoItems.count
    }

    
    // How(What) do you create next cell from reusable cells?
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // dequeue from reusable cell
        let cell = tableView.dequeueReusableCell(withIdentifier: todoCell, for: indexPath) as! TodoTableViewCell
        
        // fill current content
        cell.updateUI(todo:  todoItems[indexPath.row])
        
        // Specify accessory
        cell.accessoryType = .detailButton
        
        return cell
    }

    // When accessory view in cell is tapped
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        
        moveToAddEditItemVC(currentPath: indexPath)

    }
    
    // What happens When each cell is selected ?
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        /*
         If it's editing mode
         - allow deletion
         - not allow switching ☑️ switch
         */
        if tableView.isEditing{
            removeButton.isEnabled = true
            return
        }


        // get current cell as todoTableview cell
        guard let cell = tableView.cellForRow(at: indexPath) as? TodoTableViewCell else{return}

        // reverse completion both cell's Label and data
        let isComplete = todoItems[indexPath.row].isCompleted
        cell.reverseCompletion(isComplete: isComplete)
        todoItems[indexPath.row].isCompleted = !isComplete

        tableView.deselectRow(at: indexPath, animated: true)

    }
    

    
}
