//
//  CommentsView.swift
//  RoutingExample
//
//  Created by Stoyan Stoyanov on 27.02.24.
//

import SwiftUI

struct CommentsView: View {
    
    @ObservedObject var viewModel: CommentsViewModel

    var body: some View {
        VStack {
            Text("Comment: \(viewModel.comment)")
        }
    }
}

// MARK: - Preview

struct CommentsView_Previews: PreviewProvider {
    static var previews: some View {
        CommentsView(viewModel: CommentsViewModel(comment: "preview comment"))
    }
}
