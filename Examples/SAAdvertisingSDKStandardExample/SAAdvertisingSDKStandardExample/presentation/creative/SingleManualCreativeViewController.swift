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

class SingleManualCreativeViewController: UIViewController {

    @IBOutlet weak var creativeView: CreativeView!

    @IBOutlet weak var formView: UIView!

    @IBOutlet weak var spinnerView: UIActivityIndicatorView!

    @IBOutlet weak var bannerUrlTextField: UITextField!

    @IBOutlet weak var userIdTextField: UITextField!

    @IBOutlet weak var placementIdTextField: UITextField!

    @IBOutlet weak var widthTextField: UITextField!

    @IBOutlet weak var heightTextField: UITextField!

    @IBOutlet weak var errorLabel: UILabel!

    private var creative: Creative!

    // Form / Keyboard management
    // Ordered list of text fields to support Next/Previous navigation
    private lazy var formTextFields: [UITextField] = []

    // Track the currently active text field (while form navigation)
    private weak var activeTextField: UITextField?

    private var appSettings: AppSettings {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.appSettings
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        bannerUrlTextField.text = appSettings.initConfigCore.bannerUrl
        userIdTextField.text = TechAdvertising.shared.uid
        configureTextFields()

        self.creative = .init(creativeView: creativeView)
        self.creative.delegate = self

        // Dismiss keyboard when tapping outside the Form View
        let backgroundTap = UITapGestureRecognizer(target: self, action: #selector(handleBackgroundTap(_:)))
        backgroundTap.cancelsTouchesInView = false
        view.addGestureRecognizer(backgroundTap)
    }

    @IBAction func onLoadClick(_ sender: Any) {
        hideKeyboard()
        initSdk()
        loadCreative()
    }

    private func initSdk() {
        let bannerUrl = bannerUrlTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let initConfigCore = InitConfigCoreEntity(
            bannerUrl: bannerUrl,
            productUrl: appSettings.initConfigCore.productUrl,
        )
        TechAdvertising.initialize(options: TechAdvertisingOptions(
            storeUrl: "YOUR_STORE_URL",
            initConfig: .init(core: initConfigCore),
            debugMode: true,
            locationEnabled: false
        ))

        let userId = userIdTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        TechAdvertising.shared.uid = userId.isEmpty ? nil : userId
    }

    private func loadCreative() {
        showLoading()
        let placementId = placementIdTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        guard let widthText = widthTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), let width = Int(widthText) else {
            hideLoading(errorMessage: "Width parameter is required")
            return
        }
        guard let heightText = heightTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), let height = Int(heightText) else {
            hideLoading(errorMessage: "Height parameter is required")
            return
        }
        creativeView.query = CreativeQuery(
            placementId: placementId,
            sizes: [
                SizeEntity(width: width, height: height)
            ]
        )
        creative.load()
    }

    private func showLoading() {
        disableForm()
        creativeView.isHidden = true
        errorLabel.text = nil
        errorLabel.isHidden = true
        spinnerView.isHidden = false
    }

    private func hideLoading(errorMessage: String? = nil) {
        spinnerView.isHidden = true
        if let errorMessage {
            creativeView.isHidden = true
            errorLabel.text = errorMessage
            errorLabel.isHidden = false
        } else {
            creativeView.isHidden = false
            errorLabel.text = nil
            errorLabel.isHidden = true
        }
        enableForm()
    }

    private func hideCreative() {
        creativeView.isHidden = true
        errorLabel.text = nil
        errorLabel.isHidden = true
        spinnerView.isHidden = true
        enableForm()
    }

    private func enableForm() {
        formView.isUserInteractionEnabled = true
        formView.alpha = 1.0
    }

    private func disableForm() {
        formView.isUserInteractionEnabled = false
        formView.alpha = 0.5
    }
}

// MARK: - CreativeDelegate

extension SingleManualCreativeViewController: CreativeDelegate {

    public func onLoadDataSuccess(creativeView: CreativeView) {
        let placementId = creativeView.query?.placementId
        log("onLoadDataSuccess[\(placementId ?? "")]")
    }

    public func onLoadDataFail(creativeView: CreativeView, error: Error) {
        let placementId = creativeView.query?.placementId
        let msg = "onLoadDataFail[\(placementId ?? "")]: \(error.localizedDescription)"
        log(msg)
        hideLoading(errorMessage: msg)
    }

    public func onLoadContentSuccess(creativeView: CreativeView, ext: [String: Any]) {
        let placementId = creativeView.query?.placementId
        let trackingId = ext["trackingId"] as? String
        let creativeId = ext["creativeId"] as? String
        log("onLoadContentSuccess[placementId: \(String(describing: placementId)), creativeId: \(String(describing: creativeId)), trackingId: \(String(describing: trackingId))]")
        hideLoading()
    }

    public func onLoadContentFail(creativeView: CreativeView, error: Error) {
        let placementId = creativeView.query?.placementId
        let msg = "onLoadContentFail[\(placementId ?? "")]: \(error.localizedDescription)"
        log(msg)
        hideLoading(errorMessage: msg)
    }

    public func onNoAdContent(creativeView: CreativeView) {
        let placementId = creativeView.query?.placementId
        let msg = "onNoAdContent[\(placementId ?? "")]"
        log(msg)
        hideLoading(errorMessage: msg)
    }

    public func onClose(creativeView: CreativeView) {
        let placementId = creativeView.query?.placementId
        log("onClose[\(placementId ?? "")]")
        hideCreative()
    }
}

// MARK: - UITextFieldDelegate (Form / Keyboard management)

extension SingleManualCreativeViewController: UITextFieldDelegate {
    // Dismiss keyboard when user taps outside of the Form View
    @objc private func handleBackgroundTap(_ gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: view)
        // Convert formView bounds to this view's coordinate space
        let formFrameInSelf = formView.convert(formView.bounds, to: view)
        // If tap is outside the form, end editing (hide keyboard)
        if !formFrameInSelf.contains(location) {
            hideKeyboard()
        }
    }

    private func hideKeyboard() {
        view.endEditing(true)
    }

    private func configureTextFields() {
        // Define the navigation order explicitly
        formTextFields = [
            bannerUrlTextField,
            userIdTextField,
            placementIdTextField,
            widthTextField,
            heightTextField
        ].compactMap { $0 }

        // Assign delegates, tags, return keys, and accessory toolbar
        let lastIndex = formTextFields.count - 1
        for (index, tf) in formTextFields.enumerated() {
            tf.delegate = self
            tf.tag = index
            tf.returnKeyType = (index == lastIndex) ? .done : .next
            tf.inputAccessoryView = makeAccessoryToolbar()
            tf.addTarget(self, action: #selector(textFieldEditingDidBegin(_:)), for: .editingDidBegin)
            tf.addTarget(self, action: #selector(textFieldEditingDidEnd(_:)), for: .editingDidEnd)
        }
    }

    private func makeAccessoryToolbar() -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.isTranslucent = true

        let previous = UIBarButtonItem(title: "Previous", style: .plain, target: self, action: #selector(previousField))
        let next = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextField))
        let flex = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneEditing))
        toolbar.items = [previous, next, flex, done]
        toolbar.sizeToFit()
        return toolbar
    }

    @objc private func previousField() {
        guard let current = activeTextField else { return }
        let previousTag = current.tag - 1
        if let previous = view.viewWithTag(previousTag) as? UITextField {
            previous.becomeFirstResponder()
        }
    }

    @objc private func nextField() {
        guard let current = activeTextField else { return }
        let nextTag = current.tag + 1
        if let next = view.viewWithTag(nextTag) as? UITextField {
            next.becomeFirstResponder()
        } else {
            // Last field
            doneEditing()
        }
    }

    @objc private func doneEditing() {
        hideKeyboard()
    }

    @objc private func textFieldEditingDidBegin(_ sender: UITextField) {
        activeTextField = sender
    }

    @objc private func textFieldEditingDidEnd(_ sender: UITextField) {
        if activeTextField === sender { activeTextField = nil }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTag = textField.tag + 1
        if let next = view.viewWithTag(nextTag) as? UITextField {
            next.becomeFirstResponder()
        } else {
            // Last field: dismiss and highlight the button for the user
            hideKeyboard()
        }
        return false
    }
}
