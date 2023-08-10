//
//  TagList.swift
//  SwiftUILayout
//
//  Created by Mina Azer on 10/08/2023.
//

import SwiftUI
import Fakery

struct TagList: View {
    
    let list : [Tag] = .mocks()
    @State var selectedTags : [Tag] = []
    
    @Namespace private var animation
    
    private var notSelectedTags : [Tag] {
        list.filter { tag in
            !selectedTags.contains(tag)
        }
    }
    
    var body: some View {
        ScrollView {
            FlexibleStack(spacing: 10, alignment: .leading){
                
                listBuilder(
                    list: selectedTags,
                    action: removeTag(_:),
                    label: selectedItem
                )
                
                listBuilder(
                    list: notSelectedTags,
                    action: addTag(_:),
                    label: notSelectedItem
                )
                
            }.padding(16)
        }
    }
    
    @ViewBuilder
    func listBuilder<Content: View>(list : [Tag], action: @escaping (Tag) -> (), label : @escaping(Tag) -> (Content) ) -> some View {
        ForEach(list){ tag in
            Button {
                action(tag)
            } label: {
                label(tag)
            }
        }
    }
    
    func notSelectedItem(tag : Tag) -> some View {
        Text(tag.name)
            .padding(.vertical, 5)
            .padding(.horizontal, 10)
            .background {
                Capsule()
                    .stroke(lineWidth: 2)
                    .background{
                        Capsule().foregroundColor(.white)
                    }
                    
            }
            .foregroundColor(.indigo)
            .lineLimit(1)
            .matchedGeometryEffect(id: tag.id, in: animation)
    }
    
    func selectedItem(tag : Tag) -> some View {
        Text(tag.name)
            .foregroundColor(.white)
            .padding(.vertical, 5)
            .padding(.horizontal, 10)
            .background{
                Capsule().fill(.indigo)
            }
            .lineLimit(1)
            .matchedGeometryEffect(id: tag.id, in: animation)
    }
    
    func addTag(_ tag: Tag) {
        withAnimation() {
            selectedTags.append(tag)
        }
    }
    
    func removeTag(_ tag: Tag) {
        withAnimation() {
            selectedTags.removeAll(where: {$0 == tag})
        }    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TagList()
    }
}
