//
// Copyright © Gusev Andrew, Emelianov Andrew, Spinov Dmitry [collectively referred as the Authors], 2017 - All Rights Reserved.
// [NOTICE: All information contained herein is, and remains the property of the Authors.]
// The intellectual and technical concepts contained herein are proprietary to the Authors
// and may be covered by any existing patents of any country in the world, patents in
// process, and are protected by trade secret or copyright law.
//
// Dissemination of this information or reproduction of this material is strictly forbidden unless prior
// written permission is obtained from the Authors. Access to the source code contained herein is hereby forbidden
// to anyone except persons (natural person, corporate or unincorporated body, whether or not having a separate
// legal personality, and that person’s personal representatives, and successors)
// the Authors have granted permission and who have executed Confidentiality and Non-disclosure agreements
// explicitly covering such access.
//
// The copyright notice above does not provide evidence of any actual or intended publication or disclosure
// of this source code, which in
//

import UIKit
import SAAdvertisingSDKStandard
import Toaster

class BannerCell: UICollectionViewCell {

    @IBOutlet weak var bannerContainerView: UIView!

    @IBOutlet weak var bannerLabel: UILabel!

}

class SingleCollectionCreativeViewController: UICollectionViewController {

    private let reusableIdentifier = "MyCell"

    private let sectionInsets = UIEdgeInsets(
        top: 50.0,
        left: 20.0,
        bottom: 50.0,
        right: 20.0
    )

    private let itemsPerRow: CGFloat = 1

    private var banners = [Banner]()

    override func viewDidLoad() {
        super.viewDidLoad()
        reload()
    }

    private func reload() {
        // Here is generated STUB data with only one real banner inside. Other items are empty.
        var result = [Banner]()
        let num = 20
        for i in 0..<num {
            var holder: CreativeHolder?
            let id = "Banner-\(i + 1)"
            if i % 2 == 0 {
                holder = CreativeHolder(
                    query: CreativeQuery(
                        placementId: "YOUR_PLACEMENT_ID",
                        sizes: [SizeEntity(width: 260, height: 106)]
                    )
                )
                holder!.delegate = self
            }
            result.append(Banner(
                id: id,
                holder: holder
            ))
        }
        self.banners = result
        self.collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource

extension SingleCollectionCreativeViewController {

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return banners.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: reusableIdentifier,
            for: indexPath
        ) as! BannerCell

        let banner = self.banners[(indexPath.section + 1) * indexPath.row]
        cell.bannerLabel.text = banner.id

        if let holder = banner.holder {
            cell.bannerLabel.textColor = .black
            cell.bannerContainerView.backgroundColor = .white
            self.addCreativeView(holder.creativeView, to: cell.bannerContainerView)
            holder.loadIfNeeded()
        } else {
            cell.bannerLabel.textColor = .white
            cell.bannerContainerView.backgroundColor = .lightGray
            cell.bannerContainerView.subviews.forEach { $0.removeFromSuperview() }
        }

        return cell
    }

    private func addCreativeView(_ creativeView: CreativeView, to superview: UIView) {
        superview.subviews.forEach { $0.removeFromSuperview() }

        superview.addSubview(creativeView)

        creativeView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint(
            item: creativeView,
            attribute: .top,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: superview.safeAreaLayoutGuide,
            attribute: .top,
            multiplier: 1,
            constant: 0
        ).isActive = true

        NSLayoutConstraint(
            item: creativeView,
            attribute: .bottom,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: superview.safeAreaLayoutGuide,
            attribute: .bottom,
            multiplier: 1,
            constant: 0
        ).isActive = true

        NSLayoutConstraint(
            item: creativeView,
            attribute: .leading,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: superview.safeAreaLayoutGuide,
            attribute: .leading,
            multiplier: 1,
            constant: 0
        ).isActive = true

        NSLayoutConstraint(
            item: creativeView,
            attribute: .trailing,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: superview.safeAreaLayoutGuide,
            attribute: .trailing,
            multiplier: 1,
            constant: 0
        ).isActive = true
    }
}

// MARK: - CreativeDelegate

extension SingleCollectionCreativeViewController: CreativeDelegate {

    public func onLoadDataSuccess(creativeView: CreativeView) {
        let placementId = creativeView.query?.placementId
        print("Creative.onLoadDataSuccess[\(String(describing: placementId))]")
    }

    public func onLoadDataFail(creativeView: CreativeView, error: Error) {
        let placementId = creativeView.query?.placementId
        print("Creative.onLoadDataFail[\(String(describing: placementId))]: \(error.localizedDescription)")
    }

    public func onLoadContentSuccess(creativeView: CreativeView) {
        let placementId = creativeView.query?.placementId
        print("Creative.onLoadContentSuccess[\(String(describing: placementId))]")
    }

    public func onLoadContentFail(creativeView: CreativeView, error: Error) {
        let placementId = creativeView.query?.placementId
        print("Creative.onLoadContentFail[\(String(describing: placementId))]: \(error.localizedDescription)")
    }

    public func onNoAdContent(creativeView: CreativeView) {
        let placementId = creativeView.query?.placementId
        print("Creative.onNoAdContent[\(String(describing: placementId))]")
    }

    public func onClose(creativeView: CreativeView) {
        let placementId = creativeView.query?.placementId
        print("Creative.onClose[\(String(describing: placementId))]")
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension SingleCollectionCreativeViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow

        return CGSize(width: widthPerItem, height: widthPerItem * 6 / 9) // aspect ratio of cell size is 9:6
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}

// MARK: - Data / Entities

struct Banner {
    var id: String
    var holder: CreativeHolder?
}
