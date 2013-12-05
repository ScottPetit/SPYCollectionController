#SPYCollectionController

SPYCollectionController is a simple control to remove some of the boiler plate when setting up a UICollectionView.  SPYCollectionController is by no means built for every use case, but instead for the most basic of cases where you only want to show a single section collection view and get selection events.  

<br/>
[![Build Status](https://travis-ci.org/ScottPetit/SPYCollectionController.png?branch=master)](https://travis-ci.org/ScottPetit/SPYCollectionController)

##Initializing

SPYCollectionController has a few different init methods but the most encompassing is: 

```objective-c
controllerWithItems:(NSArray *)items identifier:(NSString *)cellIdentifier configurationBlock:(SPYCollectionCellConfigurationBlock)configurationBlock selectionBlock:(SPYCollectionCellSelectionBlock)selectionBlock;
```

The cellIdentifier should be the string value that you passed when registering the NIB or Cell with the collection view.  The configuration block gives you a chance to provide any context specific data to the cell.  In the example it is used as such 

```objective-c
^(id cell, UIColor *item) {
        [cell setBackgroundColor:item];
    }
```

The selection block works similarly and is called on 
```objective-c
collectionView: didSelectItemAtIndexPath:
```

and in the example app is used like

```objective-c
^(id cell, id item) {
        [self.collectionView setBackgroundColor:item];
    }];
```

As I said the Collection Controller is not meant for all use cases but as being a simple delegate/data source it is a simple, tested way of removing some UICollectionView boilerplate.
