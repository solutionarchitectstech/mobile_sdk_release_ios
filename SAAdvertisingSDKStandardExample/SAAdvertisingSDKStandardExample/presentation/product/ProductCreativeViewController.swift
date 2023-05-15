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

class ProductCreativeViewController: UIViewController {

    @IBOutlet weak var outputLabel: UILabel!

    @IBOutlet weak var spinner: UIActivityIndicatorView!

    override func viewDidLoad() {
    }

    @IBAction func onRequestButtonClick(_ sender: Any) {
        self.outputLabel.text = nil
        self.outputLabel.isHidden = true
        self.outputLabel.textColor = .black
        self.spinner.isHidden = false
        
        DispatchQueue.global(qos: .utility).async {
            TechAdvertising.shared.productCreativeService.fetch(query: ProductCreativeQuery(
                placementId: "YOUR_PLACEMENT_ID",
                customParams: [
                    "skuId": "LG00001",
                    "skuName": "Leggo bricks (speed boat)",
                    "category": "Kids",
                    "subСategory": "Lego"
                ]
            )) { entity, error in
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    
                    self.spinner.isHidden = true
                    self.outputLabel.isHidden = false
                    
                    if let error = error {
                        self.outputLabel.textColor = .red
                        self.outputLabel.text = "ERROR: \(error.localizedDescription)"
                        return
                    }
                    
                    self.outputLabel.text = "\(entity)"
                }
            }
        }
    }
}
