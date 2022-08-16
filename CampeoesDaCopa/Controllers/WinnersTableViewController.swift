//
//  WinnersTableViewController.swift
//  CampeoesDaCopa
//
//  Created by Jean Ricardo Cesca on 05/07/22.
//

import UIKit

class WinnersTableViewController: UITableViewController {

    var worldCups: [WorldCup] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadWorldCup()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return worldCups.count
    }
    
    func loadWorldCup() {
        
        if let fileURL = Bundle.main.url(forResource: "winners", withExtension: "json") {
            do {
                let jsonData = try! Data(contentsOf: fileURL)
                worldCups = try JSONDecoder().decode([WorldCup].self, from: jsonData)
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WorldCupTableViewCell
        
        let worldGame = worldCups[indexPath.row]
        cell.prepare(with: worldGame)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vC = segue.destination as! WorldCupViewController
        
        let worldCupVC = worldCups[tableView.indexPathForSelectedRow!.row]
        vC.worldCup = worldCupVC
        
    }

}
