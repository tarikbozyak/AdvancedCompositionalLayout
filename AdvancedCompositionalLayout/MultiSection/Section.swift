//
//  Section.swift
//  AdvancedCompositionalLayout
//
//  Created by Ahmed Tarık Bozyak on 16.06.2023.
//

import Foundation
import UIKit

typealias SectionLayout = (Int, NSCollectionLayoutEnvironment, Int, PageListener?, UICollectionViewLayout) -> NSCollectionLayoutSection

class Section: Hashable {
    
    let uuid = UUID()
    let title: String
    let data: [AnyHashable]
    let cellType: UICollectionViewCell.Type
    let headerType: UICollectionReusableView.Type?
    let footerType: UICollectionReusableView.Type?
    let layout: SectionLayout
    
    lazy var pageListener = PageListener()
    
    init(
        title: String ,
        data: [AnyHashable],
        cellType: UICollectionViewCell.Type,
        headerType: UICollectionReusableView.Type? = nil,
        footerType: UICollectionReusableView.Type? = nil,
        layout: @escaping SectionLayout
    ) {
        self.title = title
        self.data = data
        self.cellType = cellType
        self.headerType = headerType
        self.footerType = footerType
        self.layout = layout
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }

    public static func == (lhs: Section, rhs: Section) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}

extension Section {
    static var defaultData1: [Section] {
        return [
            Section(title: "Person List", data: Person.defaultData, cellType: PersonCell.self, layout: { _,_,_,_,_   in
                let layout: NSCollectionLayoutSection = .personSection()
                layout.addHeader()
                return layout
            }),
            
            Section(title: "Task Banner", data: Task.defaultData, cellType: TaskCell.self, footerType: PagerFooterView.self, layout: { sectionIndex, _,_,pageListener,_   in
                let layout: NSCollectionLayoutSection = .taskCaptionSection()
                layout.addHeader()
                layout.addPagerFooter()
                layout.addVisibleItemsHandler(with: pageListener, sectionIndex: sectionIndex)
                return layout
            }),
            
            Section(title: "Task Statistics", data: TaskStatistics.defaultData, cellType: TaskStatisticsCell.self, layout: { _,_,_,_,_   in
                let layout: NSCollectionLayoutSection = .taskStatisticsSection()
                layout.addHeader()
                return layout
            }),
            
            Section(title: "Grand", data: Section.defaultGrandData, cellType: GrandTaskCell.self, headerType: TabHeaderView.self, footerType: PagerFooterView.self, layout: { sectionIndex, _,_,pageListener,_   in
                let layout: NSCollectionLayoutSection = .grandTaskSection()
                layout.addHeader()
                layout.addVisibleItemsHandler(with: pageListener, sectionIndex: sectionIndex)
                return layout
            }),
            
            
            Section(title: "Horizontal Nested Group Layout 1", data: [Int](1...70), cellType: NestedCell.self, layout: { _,_,_,_,_   in
                let layout: NSCollectionLayoutSection = .nestedGroupLayout1()
                layout.addHeader()
                layout.addFooter()
                return layout
            }),
            
            Section(title: "Horizontal Nested Group Layout 2", data: [Int](71...130), cellType: NestedCell.self, layout: { sectionIndex,_,_,_,_   in
                let layout: NSCollectionLayoutSection = .nestedGroupLayout2(type: .horizontal(layoutId: 2))
                layout.addHeader()
                return layout
            }),
            
            Section(title: "Horizontal Nested Group Layout 3", data: [Int](131...200), cellType: NestedCell.self, layout: { _,_,_,_,_   in
                let layout: NSCollectionLayoutSection = .nestedGroupLayout3()
                layout.addHeader()
                return layout
            }),
            
            Section(title: "Vertical Waterfall Layout", data: [Int](201...240), cellType: WaterfallCell.self, layout: { _,environment,dataCount,_,_   in
                let config = WaterfallConfiguration(dataCount: dataCount, columnCount: 2, itemSpacing: 10, sectionHorizontalSpacing: 3, itemHeightProvider: { CGFloat.random(in: 250...500) }, environment: environment)
                let layout: NSCollectionLayoutSection = .verticalWaterfallSection(config: config)
                layout.addHeader()
                return layout
            })
        ]
    }
    
    static var decorationViewData: [Section] {
        return [
            
            Section(title: "Section 1", data: [Int](1...21), cellType: NestedCell.self, headerType: TitleHeaderView.self, layout: { sectionIndex,_,_,_,collectionViewLayout in
                let layout: NSCollectionLayoutSection = .nestedGroupLayout2(type: .horizontal(layoutId: 2))
                layout.addHeader(pinToVisibleBounds: false)
                layout.addDecorationView(decorationView: GradientDecorationView1.self, elementKind: "decorationView\(sectionIndex)", layout: collectionViewLayout)
                return layout
            }),
            
            Section(title: "Section 2", data: [Int](22...29), cellType: NestedCell.self, headerType: TitleHeaderView.self, layout: { sectionIndex,_,_,_,collectionViewLayout in
                let layout: NSCollectionLayoutSection = .gridSection(columnCount: 3)
                layout.addHeader(pinToVisibleBounds: false)
                layout.addDecorationView(decorationView: GradientDecorationView2.self, elementKind: "decorationView\(sectionIndex)", layout: collectionViewLayout)
                return layout
            }),
            
            Section(title: "Section 3", data: [Int](30...42), cellType: NestedCell.self, headerType: TitleHeaderView.self, layout: { sectionIndex,_,_,_,collectionViewLayout in
                let layout: NSCollectionLayoutSection = .gridSection(columnCount: 5)
                layout.addHeader(pinToVisibleBounds: false)
                layout.addDecorationView(decorationView: GradientDecorationView3.self, elementKind: "decorationView\(sectionIndex)", layout: collectionViewLayout)
                return layout
            }),
            
            
            
        ]
    }
}

extension Section {
    static var defaultGrandData: [Section] {
        return [
            Section(title: "Todo", data: Task.defaultData2, cellType: TaskActivityCell.self, layout: { _,_,_,_,_   in
                let layout: NSCollectionLayoutSection = .taskActivitySection()
                return layout
            }),
            
            Section(title: "In Progress", data: Task.defaultData3, cellType: TaskActivityCell.self, layout: { _,_,_,_,_   in
                let layout: NSCollectionLayoutSection = .taskActivitySection()
                return layout
            }),
            
            Section(title: "Waiting Info", data: Task.defaultData4, cellType: TaskActivityCell.self, layout: { _,_,_,_,_   in
                let layout: NSCollectionLayoutSection = .taskActivitySection()
                return layout
            }),
            
            Section(title: "Waiting Test", data: Task.defaultData4, cellType: TaskActivityCell.self, layout: { _,_,_,_,_   in
                let layout: NSCollectionLayoutSection = .taskActivitySection()
                return layout
            }),
            
            Section(title: "Done", data: Task.defaultData5, cellType: TaskActivityCell.self, layout: { _,_,_,_,_   in
                let layout: NSCollectionLayoutSection = .taskActivitySection()
                return layout
            })
        ]
    }
}
