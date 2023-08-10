import UIKit

final class SearchViewController: UITableViewController {
    
    var searchTermsStorage: SearchTermsStoragable?

    func reloadData() {
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableCell", for: indexPath)
        cell.textLabel?.text = searchTermsStorage?.terms[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchTermsStorage?.terms.count ?? 0
    }
}
