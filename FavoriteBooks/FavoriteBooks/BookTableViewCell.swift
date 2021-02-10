//
//  BookTableViewCell.swift
//  FavoriteBooks
//
//  Created by Viktor Khotimchenko on 2021-02-10.
//

import UIKit

class BookTableViewCell: UITableViewCell {
//    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var titleValue: UILabel!
//    @IBOutlet var authorLabel: UILabel!
    @IBOutlet var authorValue: UILabel!
//    @IBOutlet var genreLabel: UILabel!
    @IBOutlet var genreValue: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func update(with book: Book) {
        titleValue.text = book.title
        authorValue.text = book.author
        genreValue.text = book.genre
    }

}
