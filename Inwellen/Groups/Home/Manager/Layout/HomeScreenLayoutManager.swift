//
//  HomeScreenLayoutManager.swift
//  Inwellen
//
//  Created by Dzmitry Shuysky on 18.07.21.
//  Copyright © 2021 Inwellen. All rights reserved.
//

import UIKit
import SnapKit

final class HomeScreenLayoutManager {

    private unowned let vc: HomeScreenViewController

    // - Init
    init(vc: HomeScreenViewController) {
        self.vc = vc
    }

}

// MARK: -
// MARK: - Layout

extension HomeScreenLayoutManager {

    func removeNoFavoriteProjectsBanner() {
        layoutTopSectionView(isHidden: true) { [weak vc] in
            guard let vc = vc else { return }
            vc.noFavoriteProjectsBanner.removeFromSuperview()
            vc.topSectionViewTopConstraint.constant = 0
        }
    }

    func layoutTopSectionView(isHidden: Bool, completion: (() -> Void)? = nil) {
        vc.topSectionView.layoutIfNeeded()
        let topSectionViewHeight = vc.topSectionView.bounds.height

        UIView.animate(withDuration: 0.3, animations: { [weak vc] in
            guard let vc = vc else { return }
            vc.topSectionViewTopConstraint.constant = isHidden ? -topSectionViewHeight : 0
            vc.view.layoutIfNeeded()
        }, completion: { [weak vc] _ in
            guard let vc = vc else { return }
            vc.dataSource.updateScreenEmptyStateCellHeight()
            completion?()
        })
    }

    func populateTopSectionView(shouldDisplayProjectShelf: Bool) {
        vc.topSectionView.subviews.forEach { $0.removeFromSuperview() }
        vc.topSectionViewTopConstraint.constant = 0

        if shouldDisplayProjectShelf {
            displayProjectShelfView()
        } else {
            displayNoFavoriteProjectsBanner()
        }
    }

    private func displayProjectShelfView() {
        let projectShelfView = ProjectShelfView(height: 80)
        vc.topSectionView.addSubview(projectShelfView)
        vc.projectShelfView = projectShelfView

        vc.projectShelfView.snp.makeConstraints { make in
            make.height.equalTo(80)
            make.edges.equalToSuperview()
        }
    }

    private func displayNoFavoriteProjectsBanner() {
        vc.topSectionView.addSubview(vc.noFavoriteProjectsBanner)

        vc.noFavoriteProjectsBanner.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

}
