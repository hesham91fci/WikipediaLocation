//
//  RepoFactory.swift
//  News
//
//  Created by Hesham Ali on 2/23/21.
//

import Foundation

protocol RepoFactoryProtocol {
    var articleManagerRepo: ArticleManagerRepo { get }
}

class RepoFactory: RepoFactoryProtocol {
    var articleManagerRepo: ArticleManagerRepo {
        ArticleManagerRepo()
    }

}
