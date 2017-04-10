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

class NoContentCell: BaseCell {
    
}
class CategoryCell: BaseCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var disposableBag = DisposeBag()
    
    @IBOutlet weak var noContent: UILabel!
    @IBOutlet weak var inDicator: UIActivityIndicatorView!
    
    var Medias: [Media] = []
    override func loadData(withModel: Any) {
        guard let cat = withModel as? Category else {
            return
        }
        if cat.mediaArray.count != 0 {
            Medias = cat.mediaArray
            collectionView.reloadData()
        } else {
            MovieViewModelCell.loadData(withModel: cat).subscribe(onNext: { media in
                if let media = media {
                    self.Medias = media
                    cat.mediaArray = media
                }
                self.collectionView.reloadData()
            }, onError: { error in
                self.inDicator.stopAnimating()
            }, onCompleted: {
                self.inDicator.stopAnimating()
            }).addDisposableTo(disposableBag)
        }
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
            
            if let mediaPoster = Medias[indexPath.item].cover {
                collectionCell.poster.setImageWith(URL(string: mediaPoster)!)
            }
            collectionCell.seriesTitle.text = Medias[indexPath.item].name
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
