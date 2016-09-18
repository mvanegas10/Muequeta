//
//  ImagesCollectionViewController.swift
//  Muequeta
//
//  Created by Meili Vanegas Hernández on 9/17/16.
//  Copyright © 2016 Meili Vanegas Hernández. All rights reserved.
//

import UIKit

class ImagesCollectionViewController: UIViewController {
    
    let identifier = "CellIdentifier"
    let headerViewIdentifier = "HeaderView"
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let dataSource = DataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        navigationItem.leftBarButtonItem = editButtonItem()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        if let indexPath = getIndexPathForSelectedCell() {
            highlightCell(indexPath, flag: false)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK:- prepareForSegue
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // retrieve selected cell & Foto
        
        if let indexPath = getIndexPathForSelectedCell() {
            
            let Foto = dataSource.fotosInGroup(indexPath.section)[indexPath.row]
            
            let detailViewController = segue.destinationViewController as! DetailViewController
            detailViewController.foto = Foto
        }
    }
    
    // MARK:- Should Perform Segue
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        return !editing
    }
    
    // MARK:- Selected Cell IndexPath
    
    func getIndexPathForSelectedCell() -> NSIndexPath? {
        
        var indexPath:NSIndexPath?
        
        if collectionView.indexPathsForSelectedItems()!.count > 0 {
            indexPath = collectionView.indexPathsForSelectedItems()![0]
        }
        return indexPath
    }
    
    // MARK:- Highlight
    
    func highlightCell(indexPath : NSIndexPath, flag: Bool) {
        
        let cell = collectionView.cellForItemAtIndexPath(indexPath)
        
        if flag {
            cell?.contentView.backgroundColor = UIColor.darkGrayColor()
        } else {
            cell?.contentView.backgroundColor = nil
        }
    }
    
    // MARK:- Editing
    
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        collectionView?.allowsMultipleSelection = editing
    }
    
    // MARK:- Add Cell
    
    @IBAction func addNewItem(sender: AnyObject) {
        
        let index = dataSource.addAndGetIndexForNewItem()
        let indexPath = NSIndexPath(forItem: index, inSection: 0)
        collectionView.insertItemsAtIndexPaths([indexPath])
    }
    
    
    @IBAction func deleteCells(sender: AnyObject) {
        
        var deletedFotos:[Foto] = []
        
        let indexpaths = collectionView?.indexPathsForSelectedItems()
        
        if let indexpaths = indexpaths {
            
            for item  in indexpaths {
                collectionView?.deselectItemAtIndexPath((item), animated: true)
                // Fotos for section
                let sectionFotos = dataSource.fotosInGroup(item.section)
                deletedFotos.append(sectionFotos[item.row])
            }
            
            dataSource.deleteItems(deletedFotos)
            
            collectionView?.deleteItemsAtIndexPaths(indexpaths)
        }
    }
}

// MARK:- UICollectionView DataSource

extension ImagesCollectionViewController : UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return dataSource.groups.count
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.numbeOfRowsInEachGroup(section)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(identifier,forIndexPath:indexPath) as! FotoCell
        
        let fotos: [Foto] = dataSource.fotosInGroup(indexPath.section)
        let foto = fotos[indexPath.row]
        
        let name = foto.name
        
        cell.imageView.image = UIImage(named: name)
        cell.caption.text = foto.descripcion
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        let headerView: FotosHeaderView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: headerViewIdentifier, forIndexPath: indexPath) as! FotosHeaderView
        
        headerView.sectionLabel.text = dataSource.gettGroupLabelAtIndex(indexPath.section)
        
        return headerView
    }
}

// MARK:- UICollectionViewDelegate Methods

extension ImagesCollectionViewController : UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        highlightCell(indexPath, flag: true)
    }
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        highlightCell(indexPath, flag: false)
    }
}

extension ImagesCollectionViewController: UICollectionViewDelegateFlowLayout {
    // MARK:- UICollectioViewDelegateFlowLayout methods
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
        // http://stackoverflow.com/questions/28872001/uicollectionview-cell-spacing-based-on-device-sceen-size
        
        let length = (UIScreen.mainScreen().bounds.width-15)/2
        return CGSizeMake(length,length);
    }
}