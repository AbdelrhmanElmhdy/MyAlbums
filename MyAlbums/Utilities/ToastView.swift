//
//  Toast.swift
//  MyAlbums
//
//  Created by Abdelrhman Elmahdy on 07/02/2023.
//

import UIKit
import Combine

class ToastView: UIView {
	
	private enum PresentationState {
		case presenting
		case dismissing
	}
	
	@Published var isPresented: Bool = false
	@Published var isExpanded: Bool = false
		
	var title: String = "" {
		didSet {
			collapsedTitleLabel.text = title
			expandedTitleLabel.text = title
		}
	}
	
	var detailsDescription: String = "" {
		didSet {
			detailsDescriptionLabel.text = detailsDescription
		}
	}
	
	var titleTextColor: UIColor = .accent {
		didSet {
			collapsedTitleLabel.textColor = titleTextColor
			expandedTitleLabel.textColor = titleTextColor
		}
	}
	
	var detailsDescriptionTextColor: UIColor = .secondaryLabel {
		didSet {
			detailsDescriptionLabel.textColor = detailsDescriptionTextColor
		}
	}
	
	private let collapsedTitleLabel: UILabel = {
		let label = UILabel()
		label.minimumScaleFactor = 0.65
		label.adjustsFontSizeToFitWidth = true
		label.textColor = .accent
		return label
	}()
			
	private let accessoryImageView = UIImageView()
	
	private lazy var collapsedInnerContentView = {
		let stackView = UIStackView(arrangedSubviews: [collapsedTitleLabel, accessoryImageView])
		
		stackView.axis = .horizontal
		stackView.distribution = .fill
		collapsedTitleLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
		
		return stackView
	}()
	
	private let expandedTitleLabel: UILabel = {
		let label = UILabel()
		
		label.numberOfLines = 2
		label.minimumScaleFactor = 0.7
		label.adjustsFontSizeToFitWidth = true
		label.font = .systemFont(ofSize: 18, weight: .bold)
		label.textColor = .accent
		label.textAlignment = .center
		
		return label
	}()
	
	private let detailsDescriptionLabel: UILabel = {
		let label = UILabel()
		
		label.numberOfLines = 3
		label.minimumScaleFactor = 0.7
		label.adjustsFontSizeToFitWidth = true
		label.font = .systemFont(ofSize: 18)
		label.textColor = .secondaryLabel
		label.textAlignment = .center
		
		return label
	}()
	
	private lazy var expandedInnerContentView = {
		let stackView = UIStackView(arrangedSubviews: [expandedTitleLabel, detailsDescriptionLabel])
		
		stackView.axis = .vertical
		stackView.distribution = .fill
		stackView.alignment = .fill
		stackView.spacing = contentViewExpandedHeight * 0.3
		
		return stackView
	}()
		
	lazy var contentView: UIView = {
		let view = UIView()
		
		view.backgroundColor = .systemGroupedBackground
		view.layer.cornerRadius = 7
		
		let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(didTap))
		view.addGestureRecognizer(tapGesture)
		
		let panGesture = UIPanGestureRecognizer.init(target: self, action: #selector(didPan))
		view.addGestureRecognizer(panGesture)
		
		return view
	}()
	
	private var contentViewCollapsedHeight = 55.0
	private var contentViewExpandedHeight = 220.0
	
	private var contentViewYOriginWhenPresenting: CGFloat = 0
	
	private var contentViewHeightConstraint: NSLayoutConstraint!
	private var contentViewBottomAnchorConstraint: NSLayoutConstraint!
	
	private var expandedInnerContentViewConstraints: [NSLayoutConstraint]!
	
	override var intrinsicContentSize: CGSize {
		guard let contentViewHeightConstraint = contentViewHeightConstraint else { return .zero }
		return CGSize(width: 0, height: contentViewHeightConstraint.constant)
	}
	
	var delegate: ToastDelegate?
	
	init() {
		super.init(frame: .zero)
		setup()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: Setups
	
	private func setup() {
		setupContentView()
		setupCollapsedInnerContentView()
		setupExpandedInnerContentView()
		setupAccessoryImageView()
	}
	
	private func setupContentView() {
		addSubview(contentView)
		contentView.translatesAutoresizingMaskIntoConstraints = false


		contentViewHeightConstraint = contentView.heightAnchor.constraint(equalToConstant: contentViewCollapsedHeight)
		contentViewBottomAnchorConstraint = contentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: contentViewCollapsedHeight)


		NSLayoutConstraint.activate([
			contentView.centerXAnchor.constraint(equalTo:centerXAnchor),
			contentView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.95),
			contentViewHeightConstraint,
			contentViewBottomAnchorConstraint,
		])
	}
		
	private func setupCollapsedInnerContentView() {
		contentView.addSubview(collapsedInnerContentView)
		collapsedInnerContentView.translatesAutoresizingMaskIntoConstraints = false
		collapsedInnerContentView.fillSuperviewWithInsets(leading: 12, trailing: -12)
	}
	
	private func setupAccessoryImageView() {
		accessoryImageView.contentMode = .scaleAspectFit
		accessoryImageView.image = .info
		
		NSLayoutConstraint.activate([
			accessoryImageView.widthAnchor.constraint(equalToConstant: 25.0),
		])
	}
	
	private func setupExpandedInnerContentView() {
		contentView.addSubview(expandedInnerContentView)
		expandedInnerContentView.translatesAutoresizingMaskIntoConstraints = false

		expandedInnerContentView.backgroundColor = contentView.backgroundColor
		expandedInnerContentView.alpha = 0

		let verticalPadding = 18.0
		
		let heightConstraint = expandedInnerContentView.heightAnchor.constraint(lessThanOrEqualTo: contentView.heightAnchor,
																																						constant: -verticalPadding * 2)
		heightConstraint.priority = .defaultHigh

		expandedInnerContentViewConstraints = [
			expandedInnerContentView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: verticalPadding),
			expandedInnerContentView.leadingAnchor.constraint(equalTo: collapsedInnerContentView.leadingAnchor),
			expandedInnerContentView.trailingAnchor.constraint(equalTo: collapsedInnerContentView.trailingAnchor),
			heightConstraint,
		]
	}
	
	// MARK: API
	
	func present(withTitle title: String, andDescription description: String, animated: Bool) {
		self.title = title
		detailsDescription = description
		
		// Only show the info sign when there's a details description to view.
		accessoryImageView.alpha = description.isEmpty ? 0 : 1
		contentView.alpha = 0
		
		layoutIfNeeded() // to make sure all pending layout updates complete so they don't become part of the animation.
		
		configureConstraints(for: .presenting, animated: animated, withDuration: 0.5, springLoaded: true) { _ in
			self.contentViewYOriginWhenPresenting = self.contentView.frame.origin.y
			self.isPresented = true
			self.delegate?.didPresent(self)
		}
	}
	
	func dismiss(animated: Bool, withDuration duration: TimeInterval = 0.6, completion: ((Bool) -> Void)? = nil) {
		configureConstraints(for: .dismissing, animated: animated, withDuration: duration, springLoaded: true) { completed in
			if self.superview != nil {
				self.collapsedTitleLabel.text = ""
				self.isPresented = false
				self.collapse()
				self.delegate?.didDismiss(self)
				completion?(completed)
			}
		}
	}
	
	func expand() {
		guard !isExpanded, !detailsDescription.isEmpty else { return }
		
		// start the fade in animation from 0.5 because starting with 0 alpha will look flaky
		self.expandedInnerContentView.alpha = 0.5
		
		toggleExpansion {
			NSLayoutConstraint.activate(self.expandedInnerContentViewConstraints)
			self.contentViewHeightConstraint.constant = self.contentViewExpandedHeight
			self.expandedInnerContentView.alpha = 1
			self.collapsedInnerContentView.alpha = 0
			self.layoutIfNeeded()
			self.invalidateIntrinsicContentSize()
		}
	}
	
	func collapse() {
		guard isExpanded else { return }
		
		toggleExpansion {
			NSLayoutConstraint.deactivate(self.expandedInnerContentViewConstraints)
			self.contentViewHeightConstraint.constant = self.contentViewCollapsedHeight
			self.expandedInnerContentView.alpha = 0
			self.collapsedInnerContentView.alpha = 1
			self.layoutIfNeeded()
			self.invalidateIntrinsicContentSize()
		}
	}
	
	// MARK: Actions
	
	@objc private func didTap() {
		if isExpanded { collapse() } else { expand() }
	}
	
	@objc private func didPan(panGesture: UIPanGestureRecognizer) {
		let verticalTranslation = panGesture.translation(in: contentView).y
		let verticalTranslationVelocity = panGesture.velocity(in: contentView).y
		
		let translationFromOriginalYOrigin = contentView.frame.origin.y - contentViewYOriginWhenPresenting
		let translationDirectionIsUpwards = translationFromOriginalYOrigin < 0
		var translationMultiplier: CGFloat = 1
		
		if translationDirectionIsUpwards {
			let viewReachedUpwardsTranslation = abs(translationFromOriginalYOrigin) > 100
			translationMultiplier =  viewReachedUpwardsTranslation ? 0 : 0.1
		}
		
		contentView.frame.origin.y += verticalTranslation * translationMultiplier
		panGesture.setTranslation(.zero, in: contentView)
		
		if panGesture.state == .ended {
			let contentViewTranslatedDownwardForMoreThanHalfItsHeight = translationFromOriginalYOrigin > contentView.frame.height / 2
			let translationVelocityIsHigh = verticalTranslationVelocity > 400
			let shouldSnapToBottom = translationVelocityIsHigh || contentViewTranslatedDownwardForMoreThanHalfItsHeight
			
			if shouldSnapToBottom {
				let translationDuration = TimeInterval(translationFromOriginalYOrigin / verticalTranslationVelocity)
				dismiss(animated: true, withDuration: min(translationDuration, 0.25))
			} else {
				setContentViewYOrigin(to: contentViewYOriginWhenPresenting, animated: true, withDuration: 0.4, springLoaded: true)
			}
		}
	}
	
	// MARK: Convenience
	
	private func configureConstraints(for presentationState: PresentationState,
																		animated: Bool,
																		withDuration duration: TimeInterval = 0.4,
																		springLoaded: Bool = false,
																		completion: ((Bool) -> Void)? = nil) {
		let duration = animated ? duration : 0
		
		let animations = {
			if presentationState == .presenting {
				self.contentViewBottomAnchorConstraint.constant -= self.contentViewCollapsedHeight
				self.contentView.alpha = 1
			} else {
				self.contentViewBottomAnchorConstraint.constant += self.contentViewCollapsedHeight
				self.contentView.alpha = 0
			}
			self.layoutIfNeeded()
			self.invalidateIntrinsicContentSize()
		}
		
		animate(animations: animations, duration: duration, springLoaded: true, completion: completion)
	}
	
	private func toggleExpansion(animations: @escaping () -> Void) {
		layoutIfNeeded()
		
		animate(animations: animations,
						springDamping: 0.85,
						completion: { _ in
			self.contentViewYOriginWhenPresenting = self.contentView.frame.origin.y
			self.isExpanded = self.contentViewHeightConstraint.constant == self.contentViewExpandedHeight
		})
	}
	
	private func setContentViewYOrigin(to yOrigin: CGFloat,
																		 animated: Bool,
																		 withDuration duration: TimeInterval = 0.4,
																		 springLoaded: Bool = false,
																		 completion: ((Bool) -> Void)? = nil) {
		let duration = animated ? duration : 0
		
		animate(animations: {
			self.contentView.frame.origin.y = yOrigin
		}, duration: duration, springLoaded: springLoaded, completion: completion)
	}
	
	private func animate(animations: @escaping () -> Void,
											 duration: TimeInterval = 0.4,
											 springLoaded: Bool = true,
											 springDamping: CGFloat = 0.7,
											 completion: ((Bool) -> Void)? = nil) {
		UIView.animate(withDuration: duration,
									 delay: 0, usingSpringWithDamping: springLoaded ? springDamping : 1,
									 initialSpringVelocity: 4,
									 options: .curveEaseOut,
									 animations: animations,
									 completion: completion)
	}
}
