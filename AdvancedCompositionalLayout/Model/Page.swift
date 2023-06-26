//
//  Page.swift
//  AdvancedCompositionalLayout
//
//  Created by Ahmed Tarık Bozyak on 25.06.2023.
//

import Foundation
import Combine

typealias PageListener = PassthroughSubject<Page, Never>

struct Page: Equatable, Hashable {
    let pageIndex: Int
    let sectionIndex: Int
}
