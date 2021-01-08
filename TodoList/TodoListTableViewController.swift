//
//  TodoListTableViewController.swift
//  TodoList
//
//  Created by Takayuki Yamaguchi on 2021-01-07.
//

import UIKit

class TodoListTableViewController: UITableViewController {
//
//    var TodoData: [Todo] = [
//        Todo(title: "Clean dishes", todoDescription: "desc", priority: 3, isCompleted: false),
//        Todo(title: "Buy soy milk", todoDescription: "desc", priority: 3, isCompleted: true),
//        Todo(title: "Sleep well", todoDescription: "desc", priority: 2, isCompleted: true),
//        Todo(title: "Buy banana🍌", todoDescription: "desc", priority: 2, isCompleted: false),
//        Todo(title: "Eat slowly", todoDescription: "desc", priority: 1, isCompleted: false),
//    ]

    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        tableView.register(TodoTableViewCell.self, forCellReuseIdentifier: todoCell)
        
        // add edit button
        navigationItem.leftBarButtonItem = editButtonItem
        // Allow editting mode to multiple seletion
        // If cell is selected, it will invoke usual didSelectRowAt
        tableView.allowsMultipleSelectionDuringEditing = true
        
        
        // add delete button
        navigationItem.rightBarButtonItem =  UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(removeTodo))
        
        
 

        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    
    @objc func removeTodo(){
        
        guard let indexPaths = tableView.indexPathsForSelectedRows else {return}
        let ids = indexPaths.map {TodoData[$0.row].id}
        TodoData.removeAll {ids.contains($0.id)}
        tableView.deleteRows(at: indexPaths, with: .automatic)
        print(TodoData)
//        let indexesToRemove = indexPaths.map {$0.row}.sorted()
//        var offSet = 0
//        for var i in indexesToRemove{
//            i -= offSet
//            TodoData.remove(at: i)
//            offSet += 1
//        }
        


    }
    
    
    // MARK: - Table view data source

    
    // How many sections?
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    // How many raws at each sections?
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return TodoData.count
    }

    
    // How(What) do you create next cell from resubale cells?
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: todoCell, for: indexPath) as! TodoTableViewCell
        cell.updateUI(todo:  TodoData[indexPath.row])
        return cell
    }
    

    // What happens When each cell is selected ?
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        // if it's editing mode, do nothing.
        if tableView.isEditing{return}
        
        
        
        // get current cell as todoTableview cell
        guard let cell = tableView.cellForRow(at: indexPath) as? TodoTableViewCell else{return}

        // reverse completion both cell's Label and data
        let isComplete = TodoData[indexPath.row].isCompleted
        cell.reverseCompletion(isComptele: isComplete)
        TodoData[indexPath.row].isCompleted = !isComplete

        tableView.deselectRow(at: indexPath, animated: true)

    }
    


    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
