//
//  ViewController.swift
//  GoGreen
//
//  Created by Sergey Morenko on 1/20/18.
//  Copyright © 2018 Sergey Morenko. All rights reserved.
//

import UIKit

struct SegueSelector {
    private init() {
    }
    
    static let showCaseSelector = "showCaseSelector"
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var _tableView: UITableView!
    private var _cases = [CaseEntity]()
    private let _repository = CaseRepository.instance

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Go Green"
        try! DataStore.instance.create()
        
        _cases = _repository.getAll()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _cases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CaseCellId", for: indexPath) as! CaseCell
        cell.selectionStyle = .gray
        let entity = _cases[indexPath.item]
        cell._value.text = entity.value
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) -> Void {
        let entity = _cases[indexPath.item]
        performSegue(withIdentifier: SegueSelector.showCaseSelector, sender: entity)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let trashAction = UIContextualAction(style: .destructive, title: "Trash") { [unowned self] (action, view, completionHandler) in
            
            let entity = self._cases[indexPath.item]
            
            self._cases.remove(at: indexPath.item)
            self._repository.remove(id: entity.id)
            self._tableView.beginUpdates()
            self._tableView.deleteRows(at: [indexPath], with: .automatic)
            self._tableView.endUpdates()
            completionHandler(true)
        }
        trashAction.backgroundColor = .red
        
        let configuration = UISwipeActionsConfiguration(actions: [trashAction])
        return configuration
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == SegueSelector.showCaseSelector {
            let controller = segue.destination as! CaseViewController
            controller.setup(entity: sender as! CaseEntity)
        }
    }

    @IBAction func onAddClicked(_ sender: Any) {
        
        let controller = UIAlertController(title: "Add Case", message: "", preferredStyle: .alert)
        controller.addTextField()
        
        let submitAction = UIAlertAction(title: "Ok", style: .default) { [unowned controller] _ in
            let field = controller.textFields![0]
            if let name = field.text, name != "" {
                let entity = CaseEntity(value: name)
                self._cases.append(entity)
                self._repository.save(entity: entity)
                self._tableView.reloadData()
            }
        }
        
        controller.addAction(submitAction)
        controller.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(controller, animated: true, completion: nil)
    }
}

final class CaseCell: UITableViewCell {
    @IBOutlet weak var _value: UILabel!
}
