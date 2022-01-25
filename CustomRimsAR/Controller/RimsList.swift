//
//  RimsList.swift
//  CustomRimsAR
//
//  Created by Robert Vesa on 24.01.2022.
//

import SwiftUI
import UIKit

struct RimsList: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct RimsList_Previews: PreviewProvider {
    static var previews: some View {
        RimsList()
    }
}

class ChildHostingController: UIHostingController<RimsList> {
    required init?(coder: NSCoder) {
            super.init(coder: coder,rootView: RimsList());
        }

        override func viewDidLoad() {
            super.viewDidLoad()
        }
}
