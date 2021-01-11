//
//  TodoListTableViewController.swift
//  TodoList
//
//  Created by Takayuki Yamaguchi on 2021-01-07.
//

import UIKit

// MARK: - Basic class definition
class TodoListTableViewController: UITableViewController {
    
    var todoItems : [Todo] = Todo.sampleData {
        // Print items whenever their values have changed
        didSet{
            print(todoItems.map{[$0.title,$0.priority,$0.isCompleted]})
        }
    }
    var prioritySectionHeaders : [String] = [PriorityTitle.First, PriorityTitle.Second,PriorityTitle.Third]
    
    //Create button (to make self first, I made it lazy)
    lazy var removeButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(removeItems))
    lazy var addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonPressed))


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        tableView.register(TodoTableViewCell.self, forCellReuseIdentifier: todoCell)
        
        // add edit button on left
        navigationItem.leftBarButtonItem = editButtonItem
        setEditing(false, animated: false)
        // Allow editing mode to multiple selection
        // If cell is selected, it will invoke usual didSelectRowAt
        tableView.allowsMultipleSelectionDuringEditing = true
        
        
        // add delete button on right (by default, not enable)
        navigationItem.rightBarButtonItems =  [addButton, removeButton]
        

    

    }

    // move to Add(Edit) item screen.
    func moveToAddEditItemVC(selectedPath: IndexPath? = nil){
        let nextVC = AddEditItemTableViewController(style: .grouped)
        nextVC.delegate = self
        
        // if you're editing, Get current IndexPath and index of items
        // and then assign to next VC
        if let selectedPath = selectedPath {
            let selectedIndex = calculateIndexFromIndexPath(indexPath: selectedPath)
            nextVC.selectedPath = selectedPath
            nextVC.selectedItem = todoItems[selectedIndex]
        }
        
        navigationController?.pushViewController(nextVC, animated: true)
    }


}



// MARK: - Basic data source setting
//Table view data source
extension TodoListTableViewController{
    
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
    
    // Define each section's title
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return prioritySectionHeaders[section]
    }
    
    // Set editing mode
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: true)
        if editing{
            self.editButtonItem.title = "Done"
        } else{
            self.editButtonItem.title = "Select"
            removeButton.isEnabled = false
        }
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

        tableView.deselectRow(at: indexPath, animated: true)
        moveToAddEditItemVC(selectedPath: indexPath)
    }
}








// MARK: - Prepare reusable cell + completion feature

//Custom tapGR to add indexPath
class CompletionTapGestureRecognizer: UITapGestureRecognizer {
    var tappedId : String!
}

extension TodoListTableViewController{
    
    // How(What) do you create next cell from reusable cells?
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // dequeue from reusable cell
        let cell = tableView.dequeueReusableCell(withIdentifier: todoCell, for: indexPath) as! TodoTableViewCell
        
        // Fill current content
        let index = calculateIndexFromIndexPath(indexPath: indexPath)
        cell.updateUI(todo:  todoItems[index])

        // Add gesture(tapped) to completion label
        let labelTap = CompletionTapGestureRecognizer(
            target: self,
            action: #selector(completionLabelTapped(_:))
        )
        labelTap.tappedId = todoItems[index].id//add id to gesture.
        cell.completionLabel.isUserInteractionEnabled = true
        cell.completionLabel.addGestureRecognizer(labelTap)
        
        
        return cell
    }

    
    @objc func completionLabelTapped(_ sender: CompletionTapGestureRecognizer){
        // Get current indexPath and index from sender
        guard let itemId = sender.tappedId else { return }

        // reverse completion data and reload
        guard let tappedIndex = todoItems.firstIndex(where: {$0.id == itemId}) else {return}
        let tappedIndexPath = calculateIndexPathFromIndex(index: tappedIndex)
        todoItems[tappedIndex].isCompleted = !todoItems[tappedIndex].isCompleted
        
        tableView.reloadRows(at: [tappedIndexPath], with: .none)
    }
    
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let swipedIndex = calculateIndexFromIndexPath(indexPath: indexPath)
        let swipeTitle = todoItems[swipedIndex].isCompleted ? "Uncheck" : "Done"
        
        let closeAction = UIContextualAction(
            style: .normal, title: swipeTitle, handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
                self.todoItems[swipedIndex].isCompleted = !self.todoItems[swipedIndex].isCompleted
                    tableView.reloadRows(at: [indexPath], with: .none)
                    success(true)
                }
            )
        closeAction.backgroundColor = .systemGreen
     
             return UISwipeActionsConfiguration(actions: [closeAction])
    }
    
}




// MARK: - Add or Edit cell

//  AddEditItem TableViewController Delegate
extension TodoListTableViewController: AddEditItemTableViewControllerDelegate{
    
    // delegator will invoke this when save button is pressed
    func addItem(newItem: Todo) {
 
        let (insertIndex, insertIndexPath) = calculateInsertIndexFromTodoItem(item: newItem)
        
        // add to data
        todoItems.insert(newItem, at: insertIndex)
        // update view (warning?)
        tableView.insertRows(at: [insertIndexPath], with: .none)
        // back to main tableview
        navigationController?.popToRootViewController(animated: true)
    }
    
    // delegator will invoke this when save button is pressed
    func editItem(editedItem: Todo, selectedPath: IndexPath) {

        // When there is a multi section, remove place != insert place
        
        // remove old(selected) item
        let selectedIndex = calculateIndexFromIndexPath(indexPath: selectedPath)
        todoItems.remove(at: selectedIndex)
        // update view
        tableView.deleteRows(at: [selectedPath], with: .none)
        
        // Insert new(edited) item
        let (insertIndex, insertIndexPath) = calculateInsertIndexFromTodoItem(item: editedItem)
        todoItems.insert(editedItem, at: insertIndex)
        
        // update view (warning?)
        tableView.insertRows(at: [insertIndexPath], with: .none)
        // back to main tableview
        navigationController?.popToRootViewController(animated: true)

    }
    
    
    // Define position swapping
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        // get source index and delete from items
        let sourceIndex = calculateIndexFromIndexPath(indexPath: sourceIndexPath)
        var movingItem = todoItems.remove(at: sourceIndex)
        movingItem.priority = destinationIndexPath.section

        
        // get destination index and insert to items
        // this is possible, because when you convert index from IndexPath, the items are already update(removed)
        let destinationIndex = calculateIndexFromIndexPath(indexPath: destinationIndexPath)
        todoItems.insert(movingItem, at: destinationIndex)
    }
    
    @objc func addButtonPressed(){
        moveToAddEditItemVC()
    }
}




// MARK: - Delete cell
extension TodoListTableViewController{
    
    
    // Prepare to swipe deletion
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    // While editing style, whenever they are done, this method is triggered.
    // eg, - edit button -> press delete button.
    //     - swipe and delete
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete{
            let currentIndex = calculateIndexFromIndexPath(indexPath: indexPath)
            todoItems.remove(at: currentIndex)
            // update view
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    @objc func removeItems(){
        // Get current selected paths
        guard let indexPaths = tableView.indexPathsForSelectedRows else {return}
        
        // Get ids from selected paths
        let ids = indexPaths.map { (indexPath)->String in
            let index = calculateIndexFromIndexPath(indexPath: indexPath)
            return todoItems[index].id
        }
        // remove all items that has id by using ids
        todoItems.removeAll {ids.contains($0.id)}
        // update view
        tableView.deleteRows(at: indexPaths, with: .automatic)
        // End the deletion mode
        removeButton.isEnabled = false
        
    }
}



// MARK: - Helper: Conversion between Index and IndexPath
extension TodoListTableViewController{
    /*
     Get the index of todoItems from IndexPath split by priority
     eg,  [0,0,0,1,1,1,1,2,2,2,"2",3,3,3,3,3]
     -> IndexPath(section: 2, row : 3) split by priority means
        "first index of 2 (8th)" + 3 == 11th index in zeroSection index.
     */
    func calculateIndexFromIndexPath(indexPath: IndexPath)->Int{
        
        // If no larger element than section == insert last
        guard let firstIndexOfTheSection =  todoItems.firstIndex(where: {$0.priority >= indexPath.section})else{return todoItems.count}
        
        return firstIndexOfTheSection + indexPath.row
    }
    
    /*
     Get the IndexPath (slit by priority) from index of todoItems
     */
    func calculateIndexPathFromIndex(index: Int)->IndexPath{
        let currentSection = todoItems[index].priority
        guard let sectionStartIndex =  todoItems.firstIndex(where: {$0.priority >= currentSection}) else{return IndexPath()} // IndexPath(0,0) is not good. May be better to change nil
        
        let row = index - sectionStartIndex
        return IndexPath(row: row, section: currentSection)
    }
    
    /*
     Get index and indexPath from item you are going to insert.
     (not safe, may be have to be optional)
     */
    func calculateInsertIndexFromTodoItem(item: Todo) -> (Int, IndexPath) {
        let currentSection = item.priority
        
        /*
         Basic idea:
            - [,,,,f,,,,,,l,,,,,]
         
            - f is first index that (element >= section number).
                - > is important because there could be no section
            - l is last index that (element <= section number)
            - This means "from f to l" represents the section
         
            - When you insert new item at this section,
                the item should insert at (l + 1) index.
            - And the row at section is "(l + 1) - f"
         
            - If there is no element at section, f and l position crosses but this is ok
                - [,,,,l,f,,,,,]
         
            - If there every element is > section number,
                l must be "-1" -> insert index becomes 0
            - l [f,,,,,,]
         
             - If there every element is < section number,
                 f must be "arr.count"
             - [,,,,,,,,l] f
         */
        let lastIndexOfSection = todoItems.lastIndex(where: {$0.priority <= currentSection}) ?? -1
        let firstIndexOfSection = todoItems.firstIndex(where: {$0.priority >= currentSection}) ?? todoItems.count

        let insertIndex = lastIndexOfSection + 1
        let insertPath = IndexPath(row: lastIndexOfSection - firstIndexOfSection + 1, section: currentSection)
        return (insertIndex, insertPath)
    }

    
}
