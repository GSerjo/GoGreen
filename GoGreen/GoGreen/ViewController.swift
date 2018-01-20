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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
        
        let entity = _cases[indexPath.item]
        cell._value.text = entity.value
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) -> Void {
        
        tableView.deselectRow(at: indexPath, animated: true)
        let entity = _cases[indexPath.item]
        performSegue(withIdentifier: SegueSelector.showCaseSelector, sender: entity)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == SegueSelector.showCaseSelector {
            print("2")
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
                self._cases.append(CaseEntity(value: name))
                self._tableView.reloadData()
                print(name)
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
