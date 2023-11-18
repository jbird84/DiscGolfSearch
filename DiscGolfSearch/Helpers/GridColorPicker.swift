//
//  GridColorPicker.swift
//  DiscGolfSearch
//
//  Created by Kinney Kare on 11/15/23.
//
import UIKit

protocol GridColorPickerDelegate: AnyObject {
    func colorWasSelected(selectedColor: UIColor)
}

class GridColorPickerViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    let colors: [UIColor] = [
        .systemRed, .brown, .systemOrange, .systemGreen,
        .systemBlue, .systemPurple, .systemPink, .systemGray,
        UIColor(hex: "#FFD700"), UIColor(hex: "#32CD32"), UIColor(hex: "#8A2BE2"),
        .systemTeal, UIColor(hex: "#FF6347"), UIColor(hex: "#00FA9A"), UIColor(hex: "#4169E1"),
        UIColor(hex: "#FF4500"), UIColor(hex: "#8B4513"), UIColor(hex: "#2E8B57"),
        UIColor(hex: "#9932CC"), UIColor(hex: "#FF8C00"), .cyan, .magenta, .lightGray,
        .systemIndigo,
       ]

    weak var delegate: GridColorPickerDelegate?
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "ColorCell")
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    lazy var titleLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "Pick A Color For Your Bag"
            label.textColor = .white
            label.font = UIFont.boldSystemFont(ofSize: 20)
            return label
        }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black
        view.addSubview(titleLabel)
        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
                    titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
                    titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                    collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
                    collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                    collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
                ])
    }

    // MARK: - UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColorCell", for: indexPath)
        cell.backgroundColor = colors[indexPath.item]
        return cell
    }

    // MARK: - UICollectionViewDelegate

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedColor = colors[indexPath.item]
        // Handle the selected color as needed
        delegate?.colorWasSelected(selectedColor: selectedColor)
        print("Selected color: \(selectedColor)")
        dismiss(animated: true, completion: nil)
    }

    // MARK: - UICollectionViewDelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (collectionView.bounds.width - 32) / 4 // Adjust spacing as needed
        return CGSize(width: cellWidth, height: cellWidth)
    }
}

