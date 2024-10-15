//
//  FollowersViewModel.swift
//  github-merge
//
//  Created by Paul Pacheco on 13/10/24.
//

import Foundation
import SwordWard

enum Endpoints {
	static let followers = "https://api.github.com/user/followers"
}
@MainActor
final class FollowersViewModel: ObservableObject {
	@Published var followerList: [Follower] = []
	@Published var error: Error? = nil
	func getFollowers() async {
		let result: Result<[Follower], Error>? = try? await SwordWard.request(URL(string: Endpoints.followers)!, method: .get, authHeader: "YOUR_TOKEN",githubMode: true)
		switch result {
		case .success(let success):
			self.followerList = success
		case .failure(let failure):
			self.error = failure
		case nil:
			print("no data")
		}
	}
}
