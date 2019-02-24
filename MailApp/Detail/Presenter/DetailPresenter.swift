//
//  DetailPresenter.swift
//  MailApp
//
//  Created by Santiago Avila Arroyave on 2/23/19.
//  Copyright © 2019 Santiago Avila Arroyave. All rights reserved.
//

import Foundation

class DetailPresenter {
  
  var post: Post
  private let userService: UserService
  private let postService: PostService
  private weak var view: DetailView?
  private(set) var user: User?
  
  init(view: DetailView,
      post: Post) {
    self.view = view
    self.post = post
    self.userService = UserService()
    self.postService = PostService()
  }
  
  func loadUserInformation() {
    view?.startSpinner()
    do {
      try userService.getUser(withId: post.userId, success: { [weak self] user in
        guard let strongSelf = self else { return }
        strongSelf.user = user
        strongSelf.view?.updateView(user)
        strongSelf.view?.stopSpinner()
      }, failure: { [weak self] error in
        guard let strongSelf = self else { return }
        strongSelf.view?.stopSpinner()
        strongSelf.view?.showError(error)
      })
    } catch let error {
      view?.stopSpinner()
      view?.showError(error)
    }
  }
  
  func screenTitle() -> String {
    return "Detail.NavigationBar.Title".localized(context: self)
  }
  
  func descriptionTitle() -> String {
    return "Detail.Content.Description".localized(context: self)
  }
  
  func userTitle() -> String {
    return "Detail.Content.User".localized(context: self)
  }
  
  func updateFavoriteStatus() {
    postService.updateFavoriteStatus(id: post.id, isFavorite: !post.favorite)
  }
}
