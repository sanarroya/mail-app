//
//  FeedViewController.swift
//  MailApp
//
//  Created by Santiago Avila Arroyave on 2/21/19.
//  Copyright © 2019 Santiago Avila Arroyave. All rights reserved.
//

import UIKit
import ViewAnimator

class FeedViewController: UIViewController {

  @IBOutlet private weak var tableView: UITableView!
  @IBOutlet private weak var deleteAllButton: UIButton!
  @IBOutlet private weak var segmentControl: UISegmentedControl!
  @IBOutlet private weak var spinner: UIActivityIndicatorView!
  
  private var presenter: FeedPresenter!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    presenter = FeedPresenter(view: self)
    setupView()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    presenter.loadFeed()
  }
  
  @IBAction func deleteAllPosts(_ sender: Any) {
    UIView.animate(
      views: tableView.visibleCells,
      animations: Constants.animations,
      reversed: true,
      initialAlpha: 1.0,
      finalAlpha: 0.0,
      completion: {
        self.presenter.deletePosts()
        self.tableView.reloadData()
    })
  }
  
  @IBAction func filterChanged(_ sender: UISegmentedControl) {
    if sender.selectedSegmentIndex == 0 {
      presenter.removePostsFilter()
    } else {
      presenter.filterPosts()
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == Constants.detailSegueId,
      let detailViewController = segue.destination as? DetailViewController,
      let post = sender as? Post {
      detailViewController.post = post
    }
  }
}

extension FeedViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return presenter.posts.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: FeedTableViewCell.reuseIdentifier, for: indexPath) as? FeedTableViewCell else {
      return UITableViewCell()
    }
    let post = presenter.posts[indexPath.row]
    cell.configure(with: post)
    return cell
  }
  
  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      tableView.beginUpdates()
      presenter.deletePost(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .left)
      tableView.endUpdates()
    }
  }
}

extension FeedViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let post = presenter.posts[indexPath.row]
    presenter.markAsRead(post)
    performSegue(withIdentifier: Constants.detailSegueId, sender: post)
    tableView.deselectRow(at: indexPath, animated: true)
  }
}

extension FeedViewController: FeedView, NotificationProtocol {
  
  func updateView() {
    tableView.reloadData()
    animateLoad(shouldAnimateButton: deleteAllButton.alpha == 0)
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

private extension FeedViewController {
  
  struct Constants {
    static let animations = [AnimationType.from(direction: .bottom, offset: 50.0)]
    static let detailSegueId = "DetailSegue"
  }
  func setupView() {
    tableView.delegate = self
    tableView.dataSource = self
    tableView.tableFooterView = UIView()
    tableView.tableFooterView?.backgroundColor = .darkGray
    registerCells()
    setupNavigationBar()
    
    title = presenter.screenTitle()
    deleteAllButton.setTitle(presenter.toolBarTitle(), for: .normal)
    deleteAllButton.layer.cornerRadius = 16.0
    deleteAllButton.layer.masksToBounds = true
    deleteAllButton.alpha = 0
    
    segmentControl.setTitle(presenter.allSegmentTitle(), forSegmentAt: 0)
    segmentControl.setTitle(presenter.favoritesSegmentTitle(), forSegmentAt: 1)
  }
  
  func registerCells() {
    tableView.register(UINib(nibName: String(describing: FeedTableViewCell.self), bundle: nil),
                       forCellReuseIdentifier: FeedTableViewCell.reuseIdentifier)
  }
  
  func setupNavigationBar() {
    let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refresh))
    refreshButton.tintColor = .white
    navigationItem.rightBarButtonItem = refreshButton
  }
  
  func animateLoad(shouldAnimateButton: Bool) {
    UIView.animate(views: tableView.visibleCells, animations: Constants.animations, completion: {
      guard shouldAnimateButton else {
        return
      }
      let animations = [AnimationType.zoom(scale: 1)]
      self.deleteAllButton.animate(animations: animations, initialAlpha: 0, finalAlpha: 1, delay: 0.2, duration: 0.5)
    })
  }
  
  @objc func refresh() {
    presenter.deletePosts()
    tableView.reloadData()
    presenter.loadFeed()
  }
}
