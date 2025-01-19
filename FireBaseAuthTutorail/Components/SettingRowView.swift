//
//  SettingRowView.swift
//  FireBaseAuthTutorail
//
//  Created by Sudhanshu Singh Rajput on 19/01/25.
//

import SwiftUI

struct SettingRowView: View {
    let imageName:String
    let title:String
    let tintColor : Color
    var body: some View {
            HStack{
                Image(systemName: imageName)
                    .imageScale(.small)
                    .font(.title)
                    .foregroundStyle(tintColor)
                Text(title)
                    .font(.subheadline)
                    .foregroundStyle(Color.black)
        }
    }
}

#Preview {
    SettingRowView(imageName: "gear", title: "Version", tintColor: Color(.systemGray))
}
