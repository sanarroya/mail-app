//
//  DetailViewController.swift
//  MailApp
//
//  Created by Santiago Avila Arroyave on 2/23/19.
//  Copyright © 2019 Santiago Avila Arroyave. All rights reserved.
//

import UIKit
import ViewAnimator
import SwiftEntryKit

class DetailViewController: UIViewController {
  
  @IBOutlet private weak var descriptionTitleLabel: UILabel!
  @IBOutlet private weak var descriptionLabel: UILabel!
  @IBOutlet private weak var userTitleLabel: UILabel!
  @IBOutlet private weak var nameLabel: UILabel!
  @IBOutlet private weak var emailLabel: UILabel!
  @IBOutlet private weak var phoneLabel: UILabel!
  @IBOutlet private weak var websiteLabel: UILabel!
  @IBOutlet private weak var spinner: UIActivityIndicatorView!
  
  var post: Post!
  private var presenter: DetailPresenter!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    presenter = DetailPresenter(view: self, post: post)
    setupView()
    setupNavigationBar()
    presenter.loadUserInformation()
  }
}

extension DetailViewController: DetailView, NotificationProtocol {
  
  func updateView(_ user: User) {
    nameLabel.text = user.name
    emailLabel.text = user.email
    phoneLabel.text = user.phone
    websiteLabel.text = user.website
    
    UIView.animate(views: [userTitleLabel, emailLabel, emailLabel, phoneLabel, websiteLabel],
                   animations: [AnimationType.zoom(scale: 1)])
  }
  
  func startSpinner() {
    spinner.startAnimating()
  }
  
  func stopSpinner() {
    spinner.stopAnimating()
  }
  
  func showError(_ error: Error) {
    showError(withMessage: error.localizedDescription)
  }
  
}

private extension DetailViewController {
  
  func setupView() {
    title = presenter.screenTitle()
    descriptionTitleLabel.text = presenter.descriptionTitle()
    userTitleLabel.text = presenter.userTitle()
    descriptionLabel.text = post.body
  }
  
  func setupNavigationBar() {
    let favButton = UIBarButtonItem(image: UIImage(named: "star")?.withRenderingMode(.alwaysTemplate),
                                    style: .plain, target: self, action: #selector(addOrRemoveFromFavorites))
    favButton.tintColor = presenter.post.favorite ? .cornYellow : .white
    navigationItem.rightBarButtonItem = favButton
  }
  
  @objc func addOrRemoveFromFavorites() {
    presenter.updateFavoriteStatus()
    navigationItem.rightBarButtonItem?.customView?.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
    navigationItem.rightBarButtonItem?.tintColor = !presenter.post.favorite ? .white : .cornYellow
    UIView.animate(withDuration: 0.5, delay: 0, options: UIView.AnimationOptions.curveEaseInOut, animations: {
      self.navigationItem.rightBarButtonItem?.customView?.transform = CGAffineTransform.identity
    }, completion: nil)
  }
}
