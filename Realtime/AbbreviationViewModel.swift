//
//  AbbreviationViewModel.swift
//  Realtime
//
//  Created by Eric Schweitzer on 1/31/22.
//

import UIKit

extension ViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return DataSource.sharedDataSource.dataArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AbbreviationCell", for: indexPath)

        if let cell = cell as? AbbreviationCell, indexPath.row < DataSource.sharedDataSource.dataArray.count {
            cell.titleLabel.text = DataSource.sharedDataSource.dataArray[indexPath.row].lfs.first?.lf
            return cell
        }

        return UITableViewCell()
    }

}

class AbbreviationCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
}

extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text,
           let textRange = Range(range, in: text) {
           let updatedText = text.replacingCharacters(in: textRange,
                                                       with: string)
            
            if updatedText.count > 1 {
                DataSource.sharedDataSource.downloadData(abv: updatedText) { (success) in
                    self.Abbreviation = updatedText
                    self.tableView.reloadData()
                }
            } else {
                DataSource.sharedDataSource.dataArray = []
                self.tableView.reloadData()
            }
        }
        return true
    }
}
