import UIKit

final class SearchViewController: UITableViewController {
    
    var searchTermsStorage: SearchTermsStoragable?
    var didSelectTerm: ((String?) -> Void)?
    
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectTerm?(searchTermsStorage?.terms[indexPath.row])
    }
}
