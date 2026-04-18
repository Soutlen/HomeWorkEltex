//
//  TradeScreenTableViewDataSource.swift
//  CryptoCoreApp
//
//  Created by Евгений Глоба on 4/13/26.
//

import UIKit

final class TradeScreenTableViewDataSource: NSObject, UITableViewDataSource {

    private var steps: [TradeStep] = []

    func updateData(_ steps: [TradeStep]) {
        self.steps = steps
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return steps.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: TradeScreenTableViewCell.reuseIdentifier,
            for: indexPath
        ) as? TradeScreenTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(step: steps[indexPath.row])
        cell.contentView.backgroundColor = .clear
        return cell
    }
}
