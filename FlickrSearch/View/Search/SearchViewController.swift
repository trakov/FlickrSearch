import UIKit

final class SearchViewController: UITableViewController {
    
    @UserDefaultsBacked(defaultValue: [], key: "results")
    var results: [String] {
        didSet {
            tableView.reloadData()
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableCell", for: indexPath)
        cell.textLabel?.text = results[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        results.count
    }
}
