//
//  ContentView.swift
//  github-merge
//
//  Created by Paul Pacheco on 13/10/24.
//

import SwiftUI
import SwiftData

//struct ContentView: View {
//    @Environment(\.modelContext) private var modelContext
//    @Query private var items: [Item]
//
//    var body: some View {
//        NavigationSplitView {
//            List {
//                ForEach(items) { item in
//                    NavigationLink {
//                        Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
//                    } label: {
//                        Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
//                    }
//                }
//                .onDelete(perform: deleteItems)
//            }
//#if os(macOS)
//            .navigationSplitViewColumnWidth(min: 180, ideal: 200)
//#endif
//            .toolbar {
//#if os(iOS)
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    EditButton()
//                }
//#endif
//                ToolbarItem {
//                    Button(action: addItem) {
//                        Label("Add Item", systemImage: "plus")
//                    }
//                }
//            }
//        } detail: {
//            Text("Select an item")
//        }
//    }
//
//    private func addItem() {
//        withAnimation {
//            let newItem = Item(timestamp: Date())
//            modelContext.insert(newItem)
//        }
//    }
//
//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            for index in offsets {
//                modelContext.delete(items[index])
//            }
//        }
//    }
//}

struct ContentView: View {
	@StateObject var viewModel = FollowersViewModel()
    var body: some View {
		List(viewModel.followerList, id: \.id) { follower in
			FollowerItemListView(
				imageUrl: follower.avatarUrl,
				name: follower.login,
				profileUrl: follower.htmlUrl
			)
		}
		.onAppear {
			Task {
				await viewModel.getFollowers()
			}
		}
    }
}

struct FollowerItemListView: View {
    let imageUrl: String
    let name: String
    let profileUrl: String
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 10)
                .fill(.white)
                .shadow(radius: 4)
            HStack(spacing: 16) {
                AsyncImage(url: URL(string: imageUrl)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100.0, height: 100.0)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .scaleEffect(1.25)
                        .clipped()
                        .overlay {
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(.gray, lineWidth: 0.25)
                        }
                } placeholder: {
                    ProgressView()
                        .frame(width: 100.0, height: 100.0)
                }
                VStack(alignment: .leading) {
					Text("\(name)")
						.fontWeight(.bold)
						.foregroundStyle(.black)
                    Text("\(profileUrl)")
						.fontWeight(.medium)
						.foregroundStyle(.gray)
                }
			}.clipped()
        }.frame(height: 100)
			.clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview(traits: .sizeThatFitsLayout, body: {
    FollowerItemListView(
        imageUrl: "https://t.vndb.org/ch/38/164538.jpg",
        name: "Feddroid",
        profileUrl: "https://api.github.com/users/Feddroid"
    )
})
