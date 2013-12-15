//
//  SPYCollectionController.m
//  SPYCollectionController
//
//  Created by Scott Petit on 11/9/13.
//  Copyright (c) 2013 Scott Petit. All rights reserved.
//

#import "SPYCollectionController.h"

@implementation SPYCollectionController

#pragma mark - Init

+ (instancetype)controllerWithIdentifier:(NSString *)cellIdentifier configurationBlock:(SPYCollectionCellConfigurationBlock)configurationBlock selectionBlock:(SPYCollectionCellSelectionBlock)selectionBlock
{
    return [[self alloc] initWithItems:nil identifier:cellIdentifier configurationBlock:configurationBlock selectionBlock:selectionBlock];
}

+ (instancetype)controllerWithItems:(NSArray *)items identifier:(NSString *)cellIdentifier configurationBlock:(SPYCollectionCellConfigurationBlock)configurationBlock selectionBlock:(SPYCollectionCellSelectionBlock)selectionBlock
{
    return [[self alloc] initWithItems:items identifier:cellIdentifier configurationBlock:configurationBlock selectionBlock:selectionBlock];
}

+ (instancetype)controllerWithItems:(NSArray *)items selectionBlock:(SPYCollectionCellSelectionBlock)selectionBlock
{
    return [[self alloc] initWithItems:items identifier:nil configurationBlock:nil selectionBlock:selectionBlock];
}

- (instancetype)initWithIdentifier:(NSString *)cellIdentifier configurationBlock:(SPYCollectionCellConfigurationBlock)configurationBlock selectionBlock:(SPYCollectionCellSelectionBlock)selectionBlock
{
    return [self initWithItems:nil identifier:cellIdentifier configurationBlock:configurationBlock selectionBlock:selectionBlock];
}

- (instancetype)initWithItems:(NSArray *)items selectionBlock:(SPYCollectionCellSelectionBlock)selectionBlock
{
    return [self initWithItems:items identifier:nil configurationBlock:nil selectionBlock:selectionBlock];
}

- (instancetype)initWithItems:(NSArray *)items identifier:(NSString *)cellIdentifier configurationBlock:(SPYCollectionCellConfigurationBlock)configurationBlock selectionBlock:(SPYCollectionCellSelectionBlock)selectionBlock
{
    self = [super init];
    if (self)
    {
        _items = items;
        _cellIdentifier = [cellIdentifier copy];
        _configurationBlock = [configurationBlock copy];
        _selectionBlock = [selectionBlock copy];
    }
    return self;
}

#pragma mark - Public

- (NSString *)description
{
	return [NSString stringWithFormat:@"<%@ %p> Items: %@", NSStringFromClass([self class]), self, self.items];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (!self.cellIdentifier)
    {
        NSAssert(NO, @"A cellIdentifier is a required property to dequeue collection view cells.");
    }
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.cellIdentifier forIndexPath:indexPath];
    
    if (!self.configurationBlock)
    {
        NSLog(@"No configuration block set so we're just returning the dequeud cell.  Please make sure you set a configuration block if you want SPYCollectionController to act as the data source for your collection view");
        return cell;
    }
    
    id item = self.items[indexPath.item];
    self.configurationBlock(cell, item);
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (!self.selectionBlock)
    {
        return;
    }
    
    id cell = [collectionView cellForItemAtIndexPath:indexPath];
    id item = self.items[indexPath.item];
    
    self.selectionBlock(cell, item);
}

@end
