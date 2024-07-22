//
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

class RTBBannerCell: UICollectionViewCell {

    @IBOutlet weak var bannerContainerView: UIView!

    @IBOutlet weak var bannerLabel: UILabel!

}

class RTBCollectionCreativeViewController: UICollectionViewController {

    private let reusableIdentifier = "MyCell"

    private let sectionInsets = UIEdgeInsets(
        top: 50.0,
        left: 20.0,
        bottom: 50.0,
        right: 20.0
    )

    private let itemsPerRow: CGFloat = 1

    private var creativeHolders = [RTBCreativeHolder]()

    private let criterias: [(size: SizeEntity, markupType: MarkupType)] = [
        (size: SizeEntity(width: 240, height: 400), markupType: .BANNER),
        (size: SizeEntity(width: 288, height: 140), markupType: .BANNER),
        (size: SizeEntity(width: 260, height: 106), markupType: .VIDEO),
        (size: SizeEntity(width: 100, height: 100), markupType: .BANNER),
        (size: SizeEntity(width: 260, height: 106), markupType: .AUDIO),
        (size: SizeEntity(width: 240, height: 400), markupType: .BANNER),
        (size: SizeEntity(width: 288, height: 140), markupType: .BANNER),
        (size: SizeEntity(width: 260, height: 106), markupType: .VIDEO)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        reload()
    }

    private func reload() {
        self.creativeHolders = criterias.map {
            let creativeHolder = RTBCreativeHolder(
                id: UUID().uuidString,
                query: CreativeQuery(
                    sizes: [$0.size],
                    markupType: $0.markupType
                )
            )
            creativeHolder.delegate = self
            return creativeHolder
        }
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource

extension RTBCollectionCreativeViewController {

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return creativeHolders.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: reusableIdentifier,
            for: indexPath
        ) as! RTBBannerCell

        let index = (indexPath.section + 1) * indexPath.row
        let creativeHolder = self.creativeHolders[index]
        cell.bannerLabel.textColor = .white
        cell.bannerLabel.text = creativeHolder.query.placementId
        cell.bannerContainerView.backgroundColor = .lightGray
        creativeHolder.load(to: cell.bannerContainerView)
        cell.bannerContainerView.clipsToBounds = true

        return cell
    }
}

// MARK: - CreativeDelegate

extension RTBCollectionCreativeViewController: CreativeDelegate {

    public func onLoadDataSuccess(creativeView: CreativeView) {
        let placementId = creativeView.query?.placementId
        log("onLoadDataSuccess[\(placementId ?? "")]")
    }

    public func onLoadDataFail(creativeView: CreativeView, error: Error) {
        let placementId = creativeView.query?.placementId
        log("onLoadDataFail[\(placementId ?? "")]: \(error.localizedDescription)")
    }

    public func onLoadContentSuccess(creativeView: CreativeView) {
        let placementId = creativeView.query?.placementId
        log("onLoadContentSuccess[\(placementId ?? "")]")
    }

    public func onLoadContentFail(creativeView: CreativeView, error: Error) {
        let placementId = creativeView.query?.placementId
        log("onLoadContentFail[\(placementId ?? "")]: \(error.localizedDescription)")
    }

    public func onNoAdContent(creativeView: CreativeView) {
        let placementId = creativeView.query?.placementId
        log("onNoAdContent[\(placementId ?? "")]")
    }

    public func onClose(creativeView: CreativeView) {
        let placementId = creativeView.query?.placementId
        log("onClose[\(placementId ?? "")]")
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension RTBCollectionCreativeViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        let size = CGSize(width: widthPerItem, height: widthPerItem * 6 / 9) // aspect ratio of cell size is 9:6

        // Here is the trick how to re-calculate (re-assign) creative frame sizes,
        // after device portrait orientation changed (portrait <-> landscape) while
        // dynamic list on screen.
        let index = (indexPath.section + 1) * indexPath.row
        let creativeHolder = self.creativeHolders[index]
        DispatchQueue.main.async {
            if let bounds = creativeHolder.creativeView?.superview?.bounds {
                creativeHolder.creativeView?.frame = bounds
            }
        }

        return size
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20.0
    }
}

// MARK: - Data / Entities

class RTBCreativeHolder: Identifiable, CreativeDelegate {

    let id: String

    let query: CreativeQuery

    private(set) var creativeView: CreativeView?

    private let errorLabel = UILabel()

    private var creative: Creative?

    weak var delegate: CreativeDelegate?

    private var isLoaded: Bool {
        creative != nil
    }

    init(id: String, query: CreativeQuery) {
        self.id = id
        self.query = query
    }

    func load(path: String = "", to superview: UIView) {
        if let creativeView = self.creativeView {
            embedCreativeView(creativeView, to: superview)
            return
        }

        creativeView = .init()
        creativeView?.query = query
        embedCreativeView(creativeView!, to: superview)

        creative = .init(creativeView: creativeView!)
        creative?.delegate = self

        DispatchQueue.main.async { [weak self] in
            self?.creative?.load(path: path)
        }
    }

    private func embedCreativeView(_ creativeView: CreativeView, to superview: UIView) {
        superview.subviews.forEach { $0.removeFromSuperview() }
        superview.addSubview(creativeView)

        DispatchQueue.main.async {
            creativeView.frame = superview.bounds
        }
    }

    public func onLoadDataSuccess(creativeView: CreativeView) {
        delegate?.onLoadDataSuccess?(creativeView: creativeView)
        hideMessage(in: errorLabel)
    }

    public func onLoadDataFail(creativeView: CreativeView, error: Error) {
        delegate?.onLoadDataFail?(creativeView: creativeView, error: error)

        let placementId = creativeView.query?.placementId
        let msg = "onLoadDataFail[\(placementId ?? "")]: \(error.localizedDescription)"
        showMessage(msg, in: errorLabel, for: creativeView, withColor: .red)
    }

    public func onLoadContentSuccess(creativeView: CreativeView) {
        delegate?.onLoadContentSuccess?(creativeView: creativeView)
        hideMessage(in: errorLabel)
    }

    public func onLoadContentFail(creativeView: CreativeView, error: Error) {
        delegate?.onLoadDataFail?(creativeView: creativeView, error: error)

        let placementId = creativeView.query?.placementId
        let msg = "onLoadContentFail[\(placementId ?? "")]: \(error.localizedDescription)"
        showMessage(msg, in: errorLabel, for: creativeView, withColor: .red)
    }

    public func onNoAdContent(creativeView: CreativeView) {
        delegate?.onNoAdContent?(creativeView: creativeView)

        let placementId = creativeView.query?.placementId
        let msg = "onNoAdContent[\(placementId ?? "")]"
        showMessage(msg, in: errorLabel, for: creativeView, withColor: .red)
    }

    public func onClose(creativeView: CreativeView) {
        delegate?.onClose?(creativeView: creativeView)
        hideMessage(in: errorLabel)
    }
}
