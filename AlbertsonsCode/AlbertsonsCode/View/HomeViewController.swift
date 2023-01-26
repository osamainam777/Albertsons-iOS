//
//  HomeViewController.swift
//  AlbertsonsCode
//
//  Created by Usama Inaam Rasheed on 1/26/23.
//

import SwiftUI

struct HomeViewController: View {
    
    /// ViewModel State Instance
    @StateObject private var viewModel = CatViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView { /// Adding scrollview in case if the cat fact increase more than screen size
                if viewModel.isLoad {
                    CatFactImageViewController(fact: $viewModel.factsDataSource, image: $viewModel.catImage)
                    
                } else {
                    ProgressView() ///Activity Spinnier while loading data
                        .frame(width: 800, height: 800)
                }
            }
            .frame(width: UIScreen.main.bounds.width)
            .edgesIgnoringSafeArea(.bottom)
            .edgesIgnoringSafeArea(.top)
            .onTapGesture { viewModel.loadDatasource() } // Loading Data on Tapping the screen
            .onAppear() { viewModel.loadDatasource() } // Loading Data on screen loading.
        }
    }
}

struct HomeViewController_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewController()
    }
}
