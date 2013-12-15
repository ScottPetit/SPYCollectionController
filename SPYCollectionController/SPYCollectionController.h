//
//  SPYCollectionController.h
//  SPYCollectionController
//
//  Created by Scott Petit on 11/9/13.
//  Copyright (c) 2013 Scott Petit. All rights reserved.
//

typedef void (^SPYCollectionCellConfigurationBlock)(id cell, id item);
typedef void (^SPYCollectionCellSelectionBlock)(id cell, id item);

@interface SPYCollectionController : NSObject <UICollectionViewDataSource, UICollectionViewDelegate>

/**
 *	A convenience initializer for SPYCollectionController when the collection items are not yet known
 *
 *	@param	cellIdentifier	The cellIdentifier that the collectionView cell was registered with.  This can be nil but will assert if nil and used as a datasource
 *	@param	configurationBlock	The configurationBlock used to configure your collection view cells.  This can be nil but will assert if nil and used as a datasource
 *  @param selectionBlock  The selectionBlock to be called on collectionView:didSelectItemAtIndexPath:.  This can be nil but can only be set in the initializer.
 *
 *	@return	An instance of SPYCollectionController
 */
+ (instancetype)controllerWithIdentifier:(NSString *)cellIdentifier configurationBlock:(SPYCollectionCellConfigurationBlock)configurationBlock selectionBlock:(SPYCollectionCellSelectionBlock)selectionBlock;

/**
 *	A convenience initializer for SPYCollectionController when the collection items are already known and you only want to use the delegate callbacks, and handle the datasource yourself.
 *
 *	@param	items	The array of items powering the data source.  This can be nil but you'd need to call 'setItems:' at some point in the future.
 *  @param selectionBlock  The selectionBlock to be called on collectionView:didSelectItemAtIndexPath:.  This can be nil but can only be set in the initializer.
 *
 *	@return	An instance of SPYCollectionController
 */
+ (instancetype)controllerWithItems:(NSArray *)items selectionBlock:(SPYCollectionCellSelectionBlock)selectionBlock;

/**
 *	A convenience initializer for SPYCollectionController when the collection items are already known
 *
 *	@param	items	The array of items powering the data source.  This can be nil but you'd need to call 'setItems:' at some point in the future.
 *	@param	cellIdentifier	The cellIdentifier that the collectionView cell was registered with.  This can be nil but will assert if nil and used as a datasource
 *	@param	configurationBlock	The configurationBlock used to configure your collection view cells.  This can be nil but will assert if nil and used as a datasource
 *  @param selectionBlock  The selectionBlock to be called on collectionView:didSelectItemAtIndexPath:.  This can be nil but can only be set in the initializer.
 *
 *	@return	An instance of SPYCollectionController
 */
+ (instancetype)controllerWithItems:(NSArray *)items identifier:(NSString *)cellIdentifier configurationBlock:(SPYCollectionCellConfigurationBlock)configurationBlock selectionBlock:(SPYCollectionCellSelectionBlock)selectionBlock;

/**
 *	An initializer for SPYCollectionController when the collection items are not yet known
 *
 *	@param	cellIdentifier	The cellIdentifier that the collectionView cell was registered with.  This can be nil but will assert if nil and used as a datasource.
 *	@param	configurationBlock	The configurationBlock used to configure your collection view cells.  This can be nil but will assert if nil and used as a datasource.
 *  @param selectionBlock  The selectionBlock to be called on collectionView:didSelectItemAtIndexPath:.  This can be nil but can only be set in the initializer.
 *
 *	@return	An instance of SPYCollectionController
 */
- (instancetype)initWithIdentifier:(NSString *)cellIdentifier configurationBlock:(SPYCollectionCellConfigurationBlock)configurationBlock selectionBlock:(SPYCollectionCellSelectionBlock)selectionBlock;

/**
 *	A convenience initializer for SPYCollectionController when the collection items are already known and you only want to use the delegate callbacks, and handle the datasource yourself.
 *
 *	@param	items	The array of items powering the data source.  This can be nil but you'd need to call 'setItems:' at some point in the future.
 *  @param selectionBlock  The selectionBlock to be called on collectionView:didSelectItemAtIndexPath:.  This can be nil but can only be set in the initializer.
 *
 *	@return	An instance of SPYCollectionController
 */
- (instancetype)initWithItems:(NSArray *)items selectionBlock:(SPYCollectionCellSelectionBlock)selectionBlock;

/**
 *	An initializer for SPYCollectionController when the collection items are already known
 *
 *	@param	items	The array of items powering the data source.  This can be nil but you'd need to call 'setItems:' at some point in the future.
 *	@param	cellIdentifier	The cellIdentifier that the collectionView cell was registered with.  This can be nil but will assert if nil and used as a datasource
 *	@param	configurationBlock	The configurationBlock used to configure your collection view cells.  This can be nil but will assert if nil and used as a datasource
 *  @param selectionBlock  The selectionBlock to be called on collectionView:didSelectItemAtIndexPath:.  This can be nil but can only be set in the initializer.
 *
 *	@return	An instance of SPYCollectionController
 */
- (instancetype)initWithItems:(NSArray *)items identifier:(NSString *)cellIdentifier configurationBlock:(SPYCollectionCellConfigurationBlock)configurationBlock selectionBlock:(SPYCollectionCellSelectionBlock)selectionBlock;

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, copy, readonly) NSString *cellIdentifier;
@property (nonatomic, copy, readonly) SPYCollectionCellConfigurationBlock configurationBlock;
@property (nonatomic, copy, readonly) SPYCollectionCellSelectionBlock selectionBlock;

@end
