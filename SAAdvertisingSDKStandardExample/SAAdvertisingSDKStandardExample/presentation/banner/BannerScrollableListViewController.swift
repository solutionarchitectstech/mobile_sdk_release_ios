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

class BannerScrollableListViewController: UICollectionViewController {

    private let reusableIdentifier = "BannerCell"

    private let sectionInsets = UIEdgeInsets(
        top: 50.0,
        left: 20.0,
        bottom: 50.0,
        right: 20.0
    )

    private let itemsPerRow: CGFloat = 1

    private var banners = [BannerEntity]()

    private var bannerViews = [String: BannerView]()

    override func viewDidLoad() {
        super.viewDidLoad()
        reload()
    }

    private func reload() {
        fetchBanners() { banners, error in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                if let error = error {
                    print("ERROR: Unable to fetch STUB banners due error: \(error.localizedDescription)")
                    return
                }
                self.banners = banners
                self.collectionView.reloadData()
            }
        }
    }
}

// MARK: - UICollectionViewDataSource

extension BannerScrollableListViewController {

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

        let banner = banner(for: indexPath)
        cell.bannerLabel.text = banner.id
        cell.bannerLabel.textColor = banner.isEmpty ? .white : .black

        let bannerView = bannerView(for: banner)
        if let bannerView = bannerView {
            cell.bannerContainerView.backgroundColor = .white
            addBannerView(bannerView, to: cell.bannerContainerView)
        } else {
            cell.bannerContainerView.backgroundColor = .lightGray
            cell.bannerContainerView.subviews.forEach { $0.removeFromSuperview() }
        }

        return cell
    }

    private func banner(for indexPath: IndexPath) -> BannerEntity {
        return banners[(indexPath.section + 1) * indexPath.row]
    }

    private func bannerView(for banner: BannerEntity) -> BannerView? {
        guard !banner.isEmpty else { return nil }

        if let bannerView = bannerViews[banner.id] {
            return bannerView
        }

        let bannerView = BannerView()
        bannerView.delegate = self
        if let query = banner.query {
            bannerView.loadData(refresh: 10.0, query: query)
        }
        bannerViews[banner.id] = bannerView

        return bannerView
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

// MARK: - BannerViewDelegate

extension BannerScrollableListViewController: BannerViewDelegate {

    public func onLoadDataSuccess(placementId: String) {
        print("Banner.onLoadDataSuccess[\(placementId)]")
    }

    public func onLoadDataFail(placementId: String, reason: String) {
        print("Banner.onLoadDataFail[\(placementId)]: \(reason)")
    }

    public func onLoadContentSuccess(placementId: String) {
        print("Banner.onLoadContentSuccess[\(placementId)]")
    }

    public func onLoadContentFail(placementId: String, reason: String) {
        print("Banner.onLoadContentFail[\(placementId)]: \(reason)")
    }

    public func onClose(placementId: String) {
        print("Banner.onClose[\(placementId)]")
    }

    public func onDebugSentLoadStatistic(placementId: String) {
        Toast(text: "LOAD statistic: \(placementId)", duration: Delay.short).show()
    }

    public func onDebugSentViewStatistic(placementId: String) {
        Toast(text: "VIEW statistic: \(placementId)", duration: Delay.short).show()
    }

    public func onDebugSentClickStatistic(placementId: String) {
        Toast(text: "CLICK statistic: \(placementId)", duration: Delay.short).show()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension BannerScrollableListViewController: UICollectionViewDelegateFlowLayout {

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

struct BannerEntity: Identifiable {
    var id: String
    var query: SSPAdvertisementQuery?

    var isEmpty: Bool {
        query == nil
    }
}

extension BannerScrollableListViewController {

    private func fetchBanners(block: @escaping ([BannerEntity], Error?) -> Void) {
        // Here is generated STUB data with only one real banner inside. Other items are empty due query is nil.
        DispatchQueue.global(qos: .utility).async {
            var result = [BannerEntity]()
            let num = 20
            for i in 0..<num {
                var query: SSPAdvertisementQuery?
                let id = "Banner-\(i + 1)"
                if i == num / 2 {
                    query = SSPAdvertisementQuery(
                        placementId: id,
                        closeButtonType: CloseButtonType.VISIBLE,
                        sizes: [SSPSizeEntity(width: 1200, height: 470)]
                    )
                }
                result.append(BannerEntity(
                    id: id,
                    query: query
                ))
            }
            block(result, nil)
        }
    }
}
