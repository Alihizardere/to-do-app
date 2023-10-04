//
//  ToDoCell.swift
//  ToDoList
//
//  Created by alihizardere on 2.10.2023.
//

import UIKit

class ToDoCell: UITableViewCell {

    @IBOutlet weak var labelToDo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
