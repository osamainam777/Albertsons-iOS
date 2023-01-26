//
//  CatFactImageViewController.swift
//  AlbertsonsCode
//
//  Created by Usama Inaam Rasheed on 1/26/23.
//

import SwiftUI

struct CatFactImageViewController: View {
    
    @Binding var fact: String
    @Binding var image: UIImage
    
    var body: some View {
        VStack {
            Spacer()
            Image(uiImage: image)
                .resizable()
                .frame(width: 300, height: 300)
                .scaledToFit()
                .cornerRadius(10)
            
            Text("Cat Fact:")
                .fontWeight(.heavy)
                .font(.headline)
                .padding(.top, 10)
            
            Text(fact)
                .bold()
                .padding([.bottom, .leading, .trailing], 10)
        }
        .padding(10)
        .padding([.top, .bottom], 75)
    }
}

struct CatFactImageViewController_Previews: PreviewProvider {
    @State static var fact: String = ""
    @State static var image = UIImage()
    static var previews: some View {
        CatFactImageViewController(fact: $fact, image: $image)
    }
}
