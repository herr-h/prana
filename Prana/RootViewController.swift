//
//  ViewController.swift
//  Prana
//
//  Created by Jan Alexander on 3/22/20.
//  Copyright © 2020 Jan Alexander. All rights reserved.
//

import UIKit

class RootViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
	struct Inset {
		static var left: Int = 16
		static var right: Int = 16
	}

	var challenges: [Challenge] = [
		Challenge(title: "Atmen", goal: "3 Runden", totalDays: 10, currentDays: 6),
		Challenge(title: "Kalt duschen", goal: "15 Sekunden", totalDays: 10, currentDays: 3)
	]

	override func viewDidLoad() {
		super.viewDidLoad()

		view.backgroundColor = .white

		let headLabel = UILabel()
		headLabel.text = "Herausforderungen"
		headLabel.font = .systemFont(ofSize: 24, weight: .bold)
		headLabel.textColor = .black
		headLabel.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(headLabel)

		let flowLayout = UICollectionViewFlowLayout()
		let collectionView = UICollectionView(frame: CGRect(x: 0, y: 150, width: view.bounds.width, height: 260), collectionViewLayout: flowLayout)
		let itemWidth = view.bounds.width - CGFloat(Inset.left + Inset.right)
		flowLayout.itemSize = CGSize(width: itemWidth, height: 100)
		collectionView.backgroundColor = .white
        collectionView.register(ChallengeCell.self, forCellWithReuseIdentifier: "challengeCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)

		let actionHeadLabel = UILabel()
		actionHeadLabel.text = "Übungen"
		actionHeadLabel.font = .systemFont(ofSize: 24, weight: .bold)
		actionHeadLabel.textColor = .black
		actionHeadLabel.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(actionHeadLabel)

		NSLayoutConstraint.activate([
			headLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24.0),
			headLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24.0),

//			collectionView.topAnchor.constraint(equalTo: headLabel.bottomAnchor, constant: 24.0),
//			collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24.0),
//			collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24.0),
//			collectionView.heightAnchor.constraint(equalToConstant: 200),

			actionHeadLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 48.0),
			actionHeadLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24.0),
		])
	}
}

extension RootViewController {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		2
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "challengeCell", for: indexPath as IndexPath) as? ChallengeCell else { return UICollectionViewCell() }
		let challenge = challenges[indexPath.row]

		cell.backgroundColor = .white
		cell.layer.cornerRadius = 10
		cell.addShadow(offset: CGSize(width: 0, height: 10), color: .black, radius: 10, opacity: 0.1)
		cell.title = challenge.title
		cell.subtitle = challenge.goal
		return cell
	}

	func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
		return CGSize(width: 200, height: 50)
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 24, bottom: 5, right: 24)
    }
}



class ChallengeCell: UICollectionViewCell {
	let label = UILabel()
	let subtitleLabel = UILabel()
	var title: String = "" {
		didSet {
			label.text = title
		}
	}
	var subtitle: String = "" {
		didSet {
			subtitleLabel.text = subtitle
		}
	}

	override init(frame: CGRect) {
		super.init(frame: frame)
		setup()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func setup() {
		label.text = title
		label.font = .systemFont(ofSize: 24, weight: .bold)
		label.textColor = .brandDarkGray
		label.translatesAutoresizingMaskIntoConstraints = false
		contentView.addSubview(label)

		subtitleLabel.text = subtitle
		subtitleLabel.font = .systemFont(ofSize: 16, weight: .medium)
		subtitleLabel.textColor = .brandLightGray
		subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
		contentView.addSubview(subtitleLabel)



		let circleView = UIView()
		circleView.backgroundColor = .systemBlue
		circleView.isUserInteractionEnabled = true
		circleView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapStart)))
		contentView.addSubview(circleView)



		NSLayoutConstraint.activate([
			label.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 24),
			label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

			subtitleLabel.leftAnchor.constraint(equalTo: label.leftAnchor),
			subtitleLabel.topAnchor.constraint(equalTo: label.bottomAnchor),

			circleView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 24),
			circleView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
		])
	}

	@objc
	private func didTapStart() {
		print("Start")
	}
}


extension UIColor {
	static var brandWhite: UIColor {
		return #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
	}

	static var brandDarkGray: UIColor {
		return #colorLiteral(red: 0.1482537687, green: 0.1610547304, blue: 0.1782224774, alpha: 1)
	}

	static var brandLightGray: UIColor {
		return #colorLiteral(red: 0.5964161754, green: 0.6105053425, blue: 0.639172852, alpha: 1)
	}
}

extension UIFont {

}

extension UIView {

    func addShadow(offset: CGSize, color: UIColor, radius: CGFloat, opacity: Float)
    {
        layer.masksToBounds = false
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity

        let backgroundCGColor = backgroundColor?.cgColor
        backgroundColor = nil
        layer.backgroundColor =  backgroundCGColor
    }
}
