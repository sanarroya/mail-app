//
//  FeedTableViewCell.swift
//  MailApp
//
//  Created by Santiago Avila Arroyave on 2/22/19.
//  Copyright © 2019 Santiago Avila Arroyave. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {

  @IBOutlet private weak var titleLabel: UILabel!
  @IBOutlet private weak var descriptionLabel: UILabel!
  @IBOutlet private weak var readIndicator: UIView!
  @IBOutlet private weak var favoriteIndicator: UIImageView!
  
  static let reuseIdentifier = "FeedTableViewCell"
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setupView()
  }
  
  func configure(with post: Post) {
    titleLabel.text = post.title
    descriptionLabel.text = post.body
    readIndicator.isHidden = post.read
    favoriteIndicator.isHidden = !post.favorite
  }
    
}

private extension FeedTableViewCell {
  func setupView() {
    readIndicator.layer.cornerRadius = readIndicator.bounds.width / 2
    readIndicator.layer.masksToBounds = true
    readIndicator.backgroundColor = .dodgerBlue
    readIndicator.isHidden = true
    favoriteIndicator.image = UIImage(named: "star")?.withRenderingMode(.alwaysTemplate)
    favoriteIndicator.tintColor = .cornYellow
    favoriteIndicator.isHidden = true
  }
}
