//
//  TodoListTableViewController.swift
//  TodoList
//
//  Created by Takayuki Yamaguchi on 2021-01-07.
//

import UIKit

class TodoListTableViewController: UITableViewController {
    
    var todoItems : [Todo] = Todo.sampleData {
        // Print items whenever their values have changed
        didSet{
            print(todoItems.map{[$0.title,$0.priority]})
        }
    }
    var prioritySectionHeaders : [String] = [PriorityTitle.First, PriorityTitle.Second,PriorityTitle.Third]
    
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
        
        let ids = indexPaths.map { (indexPath)->String in
            let index = calculateTodoItemsIndexFromPriorityIndexPath(indexPath: indexPath)
            return todoItems[index].id
        }
        // remove all items that has id by using ids
        todoItems.removeAll {ids.contains($0.id)}
        // update view
        tableView.deleteRows(at: indexPaths, with: .automatic)
        // End the deletion mode
        removeButton.isEnabled = false
//        print(todoItems.map{$0.title})
        
    }
}


extension TodoListTableViewController: AddEditItemTableViewControllerDelegate{
    
    // delegator will invoke this when save button is pressed
    func addItem(todoItem: Todo) {
 
        let (insertIndex, insertIndexPath) = calculateInsertPriorityIndexFromTodoItem(item: todoItem)
        
        // add to data
        todoItems.insert(todoItem, at: insertIndex)
        // update view (warning?)
        tableView.insertRows(at: [insertIndexPath], with: .none)
        // back to main tableview
        navigationController?.popToRootViewController(animated: true)
//        print(todoItems.map{$0.title})
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

    }
    
    
    
    /*
     Get the index of todoItems from IndexPath split by priority
     eg,  [0,0,0,1,1,1,1,2,2,2,"2",3,3,3,3,3]
     -> IndexPath(section: 2, row : 3) split by priority means
        "first index of 2 (8th)" + 3 == 11th index in zeroSection index.
     */
    func calculateTodoItemsIndexFromPriorityIndexPath(indexPath: IndexPath)->Int{
        guard let firstIndexOfTheSection =  todoItems.firstIndex(where: {$0.priority == indexPath.section})else{return -1} // -1 is not good. May be better to change nil
        return firstIndexOfTheSection + indexPath.row
    }
    
    /*
     Get the IndexPath (slit by priority) from index of todoItems
     */
    func calculatePriorityIndexPathFromTodoItemsIndex(index: Int)->IndexPath{
        let currentSection = todoItems[index].priority
        guard let section =  todoItems.firstIndex(where: {$0.priority == currentSection}) else{return IndexPath()} // IndexPath(0,0) is not good. May be better to change nil
        
        let row = index - section
        return IndexPath(row: row, section: section)
    }
    
    /*
     Get index and indexPath from item you are going to insert.
     (not safe, may be have to be optional)
     */
    func calculateInsertPriorityIndexFromTodoItem(item: Todo) -> (Int, IndexPath) {
        let currentSection = item.priority
        let lastIndexOfSection = todoItems.lastIndex(where: {$0.priority == currentSection}) ?? 0
        let firstIndexOfSection = todoItems.firstIndex(where: {$0.priority == currentSection}) ?? 0

        let insertIndex = lastIndexOfSection + 1
        let insertPath = IndexPath(row: lastIndexOfSection - firstIndexOfSection + 1, section: currentSection)
        return (insertIndex, insertPath)
    }

    
}


extension TodoListTableViewController{
    
    // MARK: - Table view data source
    
    // How many sections?
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return prioritySectionHeaders.count
    }

    // How many raws at each sections?
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        // Section 0 (most important) has n items that has "priority = 0", return n
        return todoItems.filter {$0.priority == section}.count
    }

    
    // How(What) do you create next cell from reusable cells?
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // dequeue from reusable cell
        let cell = tableView.dequeueReusableCell(withIdentifier: todoCell, for: indexPath) as! TodoTableViewCell
        
        // Fill current content
        let index = calculateTodoItemsIndexFromPriorityIndexPath(indexPath: indexPath)
        cell.updateUI(todo:  todoItems[index])

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
        let index = calculateTodoItemsIndexFromPriorityIndexPath(indexPath: indexPath)
        let isCompleted = todoItems[index].isCompleted
        
        cell.reverseCompletionLabel(isCompleted: isCompleted)
        todoItems[index].isCompleted = !isCompleted

        tableView.deselectRow(at: indexPath, animated: true)

    }
    
    // Define each section's title
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return prioritySectionHeaders[section]
    }
    

    
}
