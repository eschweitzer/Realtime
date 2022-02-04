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

        if let data = DataSource.sharedDataSource.dataArray?.lfs {
            return data.count
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AbbreviationCell", for: indexPath)

        if let cell = cell as? AbbreviationCell, let data = DataSource.sharedDataSource.dataArray?.lfs {
            cell.titleLabel.text = data[indexPath.row].lf
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
                    if success {
                        self.Abbreviation = updatedText
                    } else {
                        DataSource.sharedDataSource.dataArray?.lfs = []
                    }
                    self.tableView.reloadData()
                }
            } else {
                DataSource.sharedDataSource.dataArray?.lfs = []
                self.tableView.reloadData()
            }
        }
        return true
    }
}
