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

class SingleCollectionWebBannerViewController: UICollectionViewController {

    private let reusableIdentifier = "BannerCell"

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
            var holder: BannerCreativeHolder?
            let id = "Banner-\(i + 1)"
            if i % 2 == 0 {
                holder = BannerCreativeHolder(
                    query: BannerCreativeQuery(
                        placementId: "YOUR_PLACEMENT_ID",
                        closeButtonType: CloseButtonType.VISIBLE,
                        sizes: [SizeEntity(width: 260, height: 106)]
                    ),
                    refresh: Double.random(in: 5.0...10.0) // 10.0
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

extension SingleCollectionWebBannerViewController {

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
            self.addBannerView(holder.bannerView, to: cell.bannerContainerView)
            holder.loadIfNeeded()
        } else {
            cell.bannerLabel.textColor = .white
            cell.bannerContainerView.backgroundColor = .lightGray
            cell.bannerContainerView.subviews.forEach { $0.removeFromSuperview() }
        }

        return cell
    }

    private func addBannerView(_ bannerView: BannerView, to superview: UIView) {
        superview.subviews.forEach { $0.removeFromSuperview() }

        superview.addSubview(bannerView)

        bannerView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint(
            item: bannerView,
            attribute: .top,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: superview.safeAreaLayoutGuide,
            attribute: .top,
            multiplier: 1,
            constant: 0
        ).isActive = true

        NSLayoutConstraint(
            item: bannerView,
            attribute: .bottom,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: superview.safeAreaLayoutGuide,
            attribute: .bottom,
            multiplier: 1,
            constant: 0
        ).isActive = true

        NSLayoutConstraint(
            item: bannerView,
            attribute: .leading,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: superview.safeAreaLayoutGuide,
            attribute: .leading,
            multiplier: 1,
            constant: 0
        ).isActive = true

        NSLayoutConstraint(
            item: bannerView,
            attribute: .trailing,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: superview.safeAreaLayoutGuide,
            attribute: .trailing,
            multiplier: 1,
            constant: 0
        ).isActive = true
    }
}

// MARK: - BannerCreativeDelegate

extension SingleCollectionWebBannerViewController: BannerCreativeDelegate {

    public func onLoadDataSuccess(bannerView: BaseBannerView) {
        let placementId = bannerView.query?.placementId
        print("Banner.onLoadDataSuccess[\(String(describing: placementId))]")
    }

    public func onLoadDataFail(bannerView: BaseBannerView, error: Error) {
        let placementId = bannerView.query?.placementId
        print("Banner.onLoadDataFail[\(String(describing: placementId))]: \(error.localizedDescription)")
    }

    public func onLoadContentSuccess(bannerView: BaseBannerView) {
        let placementId = bannerView.query?.placementId
        print("Banner.onLoadContentSuccess[\(String(describing: placementId))]")
    }

    public func onLoadContentFail(bannerView: BaseBannerView, error: Error) {
        let placementId = bannerView.query?.placementId
        print("Banner.onLoadContentFail[\(String(describing: placementId))]: \(error.localizedDescription)")
    }

    public func onNoAdContent(bannerView: BaseBannerView) {
        let placementId = bannerView.query?.placementId
        print("Banner.onNoAdContent[\(String(describing: placementId))]")
    }

    public func onClose(bannerView: BaseBannerView) {
        let placementId = bannerView.query?.placementId
        print("Banner.onClose[\(String(describing: placementId))]")
    }

    public func onDebugSentLoadStatistic(bannerView: BaseBannerView) {
        let placementId = bannerView.query?.placementId
        Toast(text: "LOAD statistic[\(String(describing: placementId))]", duration: Delay.short).show()
    }

    public func onDebugSentViewStatistic(bannerView: BaseBannerView) {
        let placementId = bannerView.query?.placementId
        Toast(text: "VIEW statistic[\(String(describing: placementId))]", duration: Delay.short).show()
    }

    public func onDebugSentClickStatistic(bannerView: BaseBannerView) {
        let placementId = bannerView.query?.placementId
        Toast(text: "CLICK statistic[\(String(describing: placementId))]", duration: Delay.short).show()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension SingleCollectionWebBannerViewController: UICollectionViewDelegateFlowLayout {

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
    var holder: BannerCreativeHolder?
}
