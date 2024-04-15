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
        UIColor(hex: K.HexColor.gold), UIColor(hex: K.HexColor.limeGreen), UIColor(hex: K.HexColor.blueViolet),
        .systemTeal, UIColor(hex: K.HexColor.tomato), UIColor(hex: K.HexColor.mediumSpringGreen), UIColor(hex: K.HexColor.royalBlue),
        UIColor(hex: K.HexColor.orangeRed), UIColor(hex: K.HexColor.saddleBrown), UIColor(hex: K.HexColor.seaGreen),
        UIColor(hex: K.HexColor.darkOrchid), UIColor(hex: K.HexColor.darkOrange), .cyan, .magenta, UIColor(hex: K.HexColor.grayishBlue),
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

