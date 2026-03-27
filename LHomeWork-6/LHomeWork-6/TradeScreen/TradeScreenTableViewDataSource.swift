//
//  TradeScreenTableViewDataSource.swift
//  LHomeWork-6
//
//  Created by Евгений Глоба on 3/27/26.
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
        let cell = tableView.dequeueReusableCell(
            withIdentifier: TradeScreenTableViewCell.reuseIdentifier,
            for: indexPath
        ) as! TradeScreenTableViewCell

        let step = steps[indexPath.row]

        cell.configure(
            primaryText: step.description,
            action: step.action
        )
        cell.contentView.backgroundColor = .clear
        return cell
    }
}
