//
//  PaymentHeaderView.swift
//  Frames
//
//  Created by Ehab Alsharkawy
//  Copyright © 2022 Checkout. All rights reserved.
//

import UIKit

public final class PaymentHeaderView: UIView {
  private var style: PaymentHeaderCellStyle?
  private let supportedSchemes: [Card.Scheme]
  private lazy var backgroundView: UIView = {
    UIView().disabledAutoresizingIntoConstraints()
  }()

  private lazy var stackView: UIStackView = {
    let view = UIStackView().disabledAutoresizingIntoConstraints()
    view.axis = .vertical
    view.spacing = 10
    return view
  }()

  private lazy var headerLabel: LabelView = {
    LabelView()
  }()

  private lazy var subtitleLabel: LabelView = {
    LabelView()
  }()

  private(set) lazy var iconsViewContainer: UIView = {
    UIView()
  }()

  private(set) lazy var iconsStackView: UIStackView = {
    let view = UIStackView().disabledAutoresizingIntoConstraints()
    view.axis = .horizontal
    view.alignment = .leading
    view.distribution = .fillEqually
    view.spacing = Constants.Padding.xs.rawValue
    return view
  }()

  init(supportedSchemes: [Card.Scheme]) {
  self.supportedSchemes = supportedSchemes
    super.init(frame: .zero)
    setupViewsInOrder()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func update(style: PaymentHeaderCellStyle?) {
    guard let style = style else { return }
    self.style = style

    backgroundView.backgroundColor = style.backgroundColor
    headerLabel.isHidden = style.headerLabel == nil
    subtitleLabel.isHidden = style.subtitleLabel == nil

    if let headerStyle = style.headerLabel {
      headerLabel.update(with: headerStyle)
    }
    if let subtitleStyle = style.subtitleLabel {
      subtitleLabel.update(with: subtitleStyle)
    }

    updateIconsStack()
  }

  private func updateIconsStack() {
    iconsStackView.isHidden = style?.isIconsViewHidden ?? true
    for scheme in supportedSchemes {
      let imageView = UIImageView().disabledAutoresizingIntoConstraints()
      imageView.image = Constants.Bundle.SchemeIcon(scheme: scheme).image?.withRenderingMode(.alwaysOriginal)
      imageView.contentMode = .scaleAspectFit
      imageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
      imageView.widthAnchor.constraint(equalToConstant: 33).isActive = true
      iconsStackView.addArrangedSubview(imageView)
    }
  }
}

extension PaymentHeaderView {

  private func setupViewsInOrder() {
    setupBackgroundView()
    setupMainStackView()
    setupIconStackView()
    addArrangedSubview()
  }

  private func setupBackgroundView() {
    addSubview(backgroundView)
    NSLayoutConstraint.activate([
      backgroundView.topAnchor.constraint(equalTo: topAnchor,
                                          constant: -Constants.Padding.l.rawValue),
      backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor,
                                              constant: -Constants.Padding.l.rawValue),
      backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor,
                                               constant: Constants.Padding.l.rawValue),
      backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }

  private func addArrangedSubview() {
    stackView.addArrangedSubview(headerLabel)
    stackView.addArrangedSubview(subtitleLabel)
    stackView.addArrangedSubview(iconsViewContainer)
  }

  private func setupMainStackView() {
    addSubview(stackView)
    stackView.setupConstraintEqualTo(view: self)
  }

  private func setupIconStackView() {
    iconsViewContainer.addSubview(iconsStackView)
    NSLayoutConstraint.activate([
      iconsStackView.topAnchor.constraint(equalTo: iconsViewContainer.topAnchor),
      iconsStackView.leadingAnchor.constraint(equalTo: iconsViewContainer.safeLeadingAnchor),
      iconsStackView.trailingAnchor.constraint(lessThanOrEqualTo: iconsViewContainer.safeTrailingAnchor),
      iconsStackView.bottomAnchor.constraint(equalTo: iconsViewContainer.bottomAnchor, constant: -Constants.Padding.l.rawValue)
    ])
  }
}
