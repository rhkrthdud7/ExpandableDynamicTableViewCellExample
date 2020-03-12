//
//  ViewController.swift
//  ExpandableDynamicTableViewCellExample
//
//  Created by Soso on 12/03/2020.
//  Copyright © 2020 Soso. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    var data: [ExpandableDynamicCellViewModel] = [
    ExpandableDynamicCellViewModel(titleText: "title", descriptionText: "description", contentText: "content"),
    ExpandableDynamicCellViewModel(titleText: "title laksd lka wklj lkawj owj pqwj qowj qowj pqowj pqowj pqojw pow", descriptionText: "description wio jqwij oiwj oqijw oiqjw oiqjw oijwoiqj oiqjwi ", contentText: "content oiqwj oiqj pqwj qowj qowj pqowj pqwj qowj qowj pqowj pqwj qowj qowj pqowj pqwj qowj qowj pqowj pqwj qowj qowj pqowjw oijqwo jqownd qmwnd ljwnef ekf jha soiwej lakf ioqewjlaksdiowefl kqepfoqwj qwm ;qwoi qowqw iqwj dlqkwdm ioqwj mqwkm ;qwok poqkw;qw;l qowk almwd oakwlaw; l"),
    ExpandableDynamicCellViewModel(titleText: "title laksd lka wklj lkawj owj pqwj qowj qowj pqowj pqowj pqojw pow", descriptionText: "description wio jqwij oiwj oqijw oiqjw oiqjw oi pqwj qowj qowj pqowj pqwj qowj qowj pqowj pqwj qowj qowj pqowj pqwj qowj qowj pqowjjwoiqj oiqjwi ", contentText: "content oiqwj oiqjw oijqwo jqownd qmwnd ljwnef ekf jha soiwej lakf ioqewjlaksdiowefl kqepfoqwj qwm ;qwoi qowqw iqwj dlqkwdm ioqwj mqwkm ;qwok poqkw;qw;l qowk almwd oakwlaw; l"),
    ExpandableDynamicCellViewModel(titleText: "title laksd lka wklj lkawj owj pqwj qowj qowj pqowj pqowj pqojw p pqwj qowj qowj pqowj pqwj qowj qowj pqowj pqwj qowj qowj pqowj pqwj qowj qowj pqowj pqwj qowj qowj pqowj pqwj qowj qowj pqowj pqwj qowj qowj pqowj pqwj qowj qowj pqowjow", descriptionText: "description wio jqwij oiwj oqijw oiqjw oiqjw oijwoiqj oiqjwi ", contentText: "content oiqwj oiqjw oijqwo jqownd qmwnd ljwnef ekf jha soiwej lakf ioqewjlaksdiowefl kqepfoqwj qwm ;qwoi qowqw iqwj dlqkwdm ioqwj mqwkm ;qwok poqkw;qw;l qowk almwd oakwlaw; l"),
    ExpandableDynamicCellViewModel(titleText: "title laksd lka wklj lkawj owj pqwj qowj qowj pqowj pqowj pqojw pow", descriptionText: "description wio jqwij oiwj oqijw oiqjw oiqjw oijwoiqj oiqjwi ", contentText: "content oiqwj oiqjw oijqwo jqownd qmwnd ljwnef ekf jha soiwej lakf ioqewjlaksdiowefl kqepfoqwj qwm ;qwoi qowqw iqwj dlqkwdm ioqwj mqwkm ;qwok poqkw;qw;l qowk almwd oakwlaw; l pqwj qowj qowj pqowj pqwj qowj qowj pqowj pqwj qowj qowj pqowj pqwj qowj qowj pqowj pqwj qowj qowj pqowj pqwj qowj qowj pqowj pqwj qowj qowj pqowj"),
    ExpandableDynamicCellViewModel(titleText: "title laksd lka wklj lkawj owj pqwj qowj qowj pqowj pqowj pqojw pow", descriptionText: "description wio jqwij oiwj oqijw oiqjw oiqjw oijwoiqj oiqjwi ", contentText: "content oiqwj oiqjw oijqwo jqownd qmwnd ljwnef ekf jha soiwej lakf ioqewjlaksdiowefl kqepfoqwj qwm ;qwoi qowqw iqwj dlqkwdm ioqwj mqwkm ;qwok poqkw;qw;l qowk almwd oak pqwj qowj qowj pqowj pqwj qowj qowj pqowj pqwj qowj qowj pqowjwlaw; l")
    ]
    
    @IBOutlet weak var tableView: UITableView!
    
    var cell: ExpandableDynamicCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }

    func setupViews() {
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        Observable.of(data).bind(to: tableView.rx.items) { tableView, row, element -> ExpandableDynamicCell in
            let cell = tableView.dequeueReusableCell(withIdentifier: "ExpandableDynamicCell") as! ExpandableDynamicCell
            cell.configure(element)
            return cell
        }.disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .subscribe { [unowned self] (indexPath) in
                if let row = indexPath.element?.row {
                    self.data[row].toggle()
                    self.tableView.beginUpdates()
                    self.tableView.endUpdates()
                }
        }.disposed(by: disposeBag)
    }
    
    func heightForData(_ data: ExpandableDynamicCellViewModel) -> CGFloat {
        if cell == nil {
            cell = tableView.dequeueReusableCell(withIdentifier: "ExpandableDynamicCell") as? ExpandableDynamicCell
        }
        cell.configure(data)
        cell.setNeedsLayout()
        cell.layoutIfNeeded()
        
        let sizeTop = cell.viewTop.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        let sizeBottom = cell.viewBottom.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        
        if data.isExpanded {
            return sizeTop.height + sizeBottom.height + 60
        } else {
            return sizeTop.height + 40
        }
    }
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightForData(data[indexPath.row])
    }
}
