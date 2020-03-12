//
//  ExpandableDynamicCell.swift
//  ExpandableDynamicTableViewCellExample
//
//  Created by Soso on 12/03/2020.
//  Copyright © 2020 Soso. All rights reserved.
//

import UIKit

class ExpandableDynamicCellViewModel {
    let titleText: String
    let descriptionText: String
    let contentText: String
    var isExpanded: Bool
    
    init(titleText: String, descriptionText: String, contentText: String) {
        self.titleText = titleText
        self.descriptionText = descriptionText
        self.contentText = contentText
        self.isExpanded = false
    }
    
    func toggle() {
        isExpanded = !isExpanded
    }
}

class ExpandableDynamicCell: UITableViewCell {
    
    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var viewBottom: UIView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var labelContent: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        labelTitle.text = nil
        labelDescription.text = nil
        labelContent.text = nil
    }
    
    func configure(_ data: ExpandableDynamicCellViewModel) {
        labelTitle.text = data.titleText
        labelDescription.text = data.descriptionText
        labelContent.text = data.contentText
    }

}
