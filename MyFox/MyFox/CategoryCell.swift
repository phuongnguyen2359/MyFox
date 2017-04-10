//
//  CategoryCell.swift
//  MyFox
//
//  Created by Chris on 4/7/17.
//  Copyright © 2017 RMIT. All rights reserved.
//

import UIKit
import AFNetworking
import RxSwift

class CategoryCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    var disposableBag = DisposeBag()
    
    @IBOutlet weak var noContent: UILabel!
    @IBOutlet weak var inDicator: UIActivityIndicatorView!
   
    
    var mediasObservable: Variable<[Media]> = Variable([])
    var Medias: [Media] {
        get {
            return mediasObservable.value
        }
        set {
            mediasObservable.value = newValue
        }
    }
    
    func loadData(withCategory: Category) {

        CategoryProvider().fetchMediaFor(category: withCategory).subscribe(onNext: { media in
            if let media = media {
                self.Medias = media
            }
            self.collectionView.reloadData()
        }, onError: { (error) in
            self.noContent.isHidden = self.Medias.count == 0 ? false : true
            self.inDicator.stopAnimating()
        }, onCompleted: {
            self.noContent.isHidden = self.Medias.count == 0 ? false : true
            self.inDicator.stopAnimating()
        }).addDisposableTo(disposableBag)
    }
}

class myCollViewCell: UICollectionViewCell {
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var seriesTitle: UILabel!
}


extension CategoryCell : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Medias.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "videoCell", for: indexPath) as? myCollViewCell {
            self.mediasObservable.asObservable().subscribe(onNext: { media in
                if let mediaPoster = media[indexPath.item].cover {
                    collectionCell.poster.setImageWith(URL(string: mediaPoster)!)
                }
                    collectionCell.seriesTitle.text = media[indexPath.item].name
                
            }).addDisposableTo(disposableBag)
            return collectionCell
        }
        return UICollectionViewCell()
    }
    
}

extension CategoryCell : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow:CGFloat = 4
        let hardCodedPadding:CGFloat = 5
        let itemWidth = (collectionView.bounds.width / itemsPerRow) - hardCodedPadding + 30
        let itemHeight = collectionView.bounds.height - (2 * hardCodedPadding)
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
}
