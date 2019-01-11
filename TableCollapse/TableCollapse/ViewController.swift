//
//  ViewController.swift
//  TableCollapse
//
//  Created by Hector Climaco on 1/11/19.
//  Copyright © 2019 Hector Climaco. All rights reserved.
//

import UIKit

class ViewController: UIViewController,tapHeaderDelegadate {
    
    struct question{
        var Question : String = ""
        var Answer : String = ""
        var Collapse : Bool = false
    }
    
    var arrayQuestion : [question] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.data()
        self.loadConfiguration()
    }
    
    func loadConfiguration()
    {
        tableView.register(UINib(nibName: "TableViewHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "Header")
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = UITableView.automaticDimension
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    func data(){
        arrayQuestion.append(question(Question: "¿Question de una linea?", Answer: "Respuesta de una linea", Collapse: false))
        arrayQuestion.append(question(Question: "¿Question de mas de una linea con auto wrap en texto?", Answer: "Respuesta de mas de una linea", Collapse: false))
        arrayQuestion.append(question(Question: "¿Question de una linea?", Answer: "Respuesta de una linea", Collapse: false))
    }

    func tapSection(Section: Int) {
        var indexSetArray  = NSMutableIndexSet()
        
        for a in 0...(arrayQuestion.count - 1){
            if a != Section, self.arrayQuestion[a].Collapse{
                self.arrayQuestion[a].Collapse = false
                indexSetArray.add(a)
            }
        }
        
        indexSetArray.add(Section)
        let collapsable = !arrayQuestion[Section].Collapse
        self.arrayQuestion[Section].Collapse = collapsable
        
        UIView.setAnimationsEnabled(false)
        self.tableView.beginUpdates()
        self.tableView.reloadSections(indexSetArray as IndexSet, with: .automatic)
        self.tableView.endUpdates()
        
        
        if collapsable{
            self.tableView.scrollToRow(at: IndexPath(item: 0, section: Section), at: .none, animated: false)
        }else{
            UIView.setAnimationsEnabled(false)
            self.tableView.beginUpdates()
            self.tableView.reloadSections([Section] as IndexSet, with: .none)
            self.tableView.endUpdates()
        }
        
    }

}

extension ViewController : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayQuestion[section].Collapse ? 1 : 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrayQuestion.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        cell.labelCell.text = " \(indexPath.section) \(arrayQuestion[indexPath.section].Answer)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "Header") as! TableViewHeader
        header.labelHeader.text = "\(section)  \(arrayQuestion[section].Question)"
        header.section = section
        header.Delegate = self
        return header
    }
    
}

