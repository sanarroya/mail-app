//
//  FeedPresenter.swift
//  MailApp
//
//  Created by Santiago Avila Arroyave on 2/21/19.
//  Copyright © 2019 Santiago Avila Arroyave. All rights reserved.
//

import Foundation

class FeedPresenter {
  
  private let postService: PostService
  private weak var view: FeedView?
  private(set) var posts = [Post]()
  private var allPosts = [Post]()
  private var favoritePosts = [Post]()
  
  init(view: FeedView) {
    self.view = view
    self.postService = PostService()
  }
  
  func loadFeed() {
    view?.startSpinner()
    do {
      try postService.getPosts(withSuccess: { [weak self] posts in
        guard let strongSelf = self else {
          return
        }
        strongSelf.allPosts = posts
        strongSelf.posts = posts
        strongSelf.view?.stopSpinner()
        strongSelf.view?.updateView()
      }) { [weak self] error in
        guard let strongSelf = self else { return }
        strongSelf.view?.stopSpinner()
        strongSelf.view?.showError(error)
      }
    } catch let error {
      view?.stopSpinner()
      view?.showError(error)
    }
    
  }
  
  func removePostsFilter() {
    posts = allPosts
    view?.updateView()
  }
  
  func filterPosts() {
    favoritePosts = allPosts
    favoritePosts = favoritePosts.filter{ $0.favorite == true}
    posts = favoritePosts
    view?.updateView()
  }
  
  func deletePost(at index: Int) {
    let postToDelete = posts[index]
    guard let indexInAllPosts = allPosts.firstIndex(where: { $0.id == postToDelete.id }) else {
      return
    }
    posts.remove(at: index)
    allPosts.remove(at: indexInAllPosts)
    favoritePosts = allPosts
    favoritePosts = favoritePosts.filter{ $0.favorite == true}
    postService.deletePost(postToDelete)
  }
  
  func deletePosts() {
    posts.removeAll()
    favoritePosts.removeAll()
    allPosts.removeAll()
    postService.deletePosts()
  }
  
  func markAsRead(_ post: Post) {
    postService.markAsRead(id: post.id)
  }
  
  func screenTitle() -> String {
    return "Feed.NavigationBar.Title".localized(context: self)
  }
  
  func toolBarTitle() -> String {
    return "Feed.DeleteButton.Title".localized(context: self)
  }
  
  func allSegmentTitle() -> String {
    return "Feed.SegmentControl.All".localized(context: self)
  }
  
  func favoritesSegmentTitle() -> String {
    return "Feed.SegmentControl.Favorites".localized(context: self)
  }
}
