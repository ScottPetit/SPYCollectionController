//
//  SPYCollectionControllerTests.m
//  SPYCollectionControllerTests
//
//  Created by Scott Petit on 11/9/13.
//  Copyright (c) 2013 Scott Petit. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Kiwi/Kiwi.h>
#import "SPYCollectionController.h"

SPEC_BEGIN(SPYCollectionControllerTests)

describe(@"SPYCollectionController", ^{
    context(@"after it was created", ^{
        context(@"with items", ^{
            it(@"can use the class method", ^{
                SPYCollectionController *collectionController = [SPYCollectionController controllerWithItems:@[] identifier:@"" configurationBlock:^(id cell, id item) {
                    
                } selectionBlock:^(id cell, id item) {
                    
                }];
                
                [[collectionController shouldNot] beNil];
            });
            
            it(@"can use the init method", ^{
                SPYCollectionController *collectionController = [[SPYCollectionController alloc] initWithItems:@[] identifier:@"" configurationBlock:^(id cell, id item) {
                    
                } selectionBlock:^(id cell, id item) {
                    
                }];
                
                [[collectionController shouldNot] beNil];
            });
        });
        
        context(@"without items", ^{
            it(@"can use the class method", ^{
                SPYCollectionController *collectionController = [SPYCollectionController controllerWithIdentifier:@"" configurationBlock:^(id cell, id item) {
                    
                } selectionBlock:^(id cell, id item) {
                    
                }];
                
                [[collectionController shouldNot] beNil];
            });
            
            it(@"can use the init method", ^{
                SPYCollectionController *collectionController = [[SPYCollectionController alloc] initWithIdentifier:@"" configurationBlock:^(id cell, id item) {
                    
                } selectionBlock:^(id cell, id item) {
                    
                }];
                
                [[collectionController shouldNot] beNil];
            });
        });
    });
    
    context(@"UICollectionViewDataSource", ^{
        __block id _mockCollectionView;
        
        beforeEach(^{
            _mockCollectionView = [KWMock mockForClass:[UICollectionView class]];
        });
        
        it(@"can configure cells", ^{
            __block UICollectionViewCell *configuredCell = nil;
            __block id configuredItem = nil;
            
            SPYCollectionCellConfigurationBlock configurationBlock = ^(UICollectionViewCell *cell, id item){
                configuredCell = cell;
                configuredItem = item;
            };
            
            NSString *cellIdentifier = @"identifier";
            NSArray *items = @[@"a", @"b"];
            SPYCollectionController *collectionController = [SPYCollectionController controllerWithItems:items identifier:cellIdentifier configurationBlock:configurationBlock selectionBlock:nil];
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
            UICollectionViewCell *cell = [[UICollectionViewCell alloc] init];
            
            [[_mockCollectionView should] receive:@selector(dequeueReusableCellWithReuseIdentifier:forIndexPath:) andReturn:cell withArguments:cellIdentifier, indexPath];
            
            [[cell shouldNot] beNil];
            [[configuredCell should] beNil];
            
            UICollectionViewCell *resultingCell = [collectionController collectionView:_mockCollectionView cellForItemAtIndexPath:indexPath];
            
            [[resultingCell shouldNot] beNil];
            [[resultingCell should] equal:cell];
            [[configuredCell should] equal:cell];
            [[configuredItem should] equal:[items firstObject]];
        });
        
        it(@"can return the number of items", ^{
            NSArray *items = @[@"1", @"2", @"3"];
            
            SPYCollectionController *collectionController = [SPYCollectionController controllerWithItems:items identifier:@"identifier" configurationBlock:^(id cell, id item) {
                
            } selectionBlock:nil];
            
            NSInteger numberOfItems = [collectionController collectionView:_mockCollectionView numberOfItemsInSection:0];
            [[theValue(numberOfItems) should] equal:theValue(items.count)];
        });
        
        it(@"throws without a cell identifier", ^{
            NSString *cellIdentifier = nil;
            
            SPYCollectionController *collectionController = [SPYCollectionController controllerWithItems:@[] identifier:cellIdentifier configurationBlock:^(id cell, id item) {
                
            } selectionBlock:^(id cell, id item) {
                
            }];
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
            UICollectionViewCell *cell = [[UICollectionViewCell alloc] init];
            [[_mockCollectionView shouldNot] receive:@selector(dequeueReusableCellWithReuseIdentifier:forIndexPath:) andReturn:cell withArguments:cellIdentifier, indexPath];
            
            [[theBlock(^{
                [collectionController collectionView:_mockCollectionView cellForItemAtIndexPath:indexPath];
            }) should] raise];
        });
        
        it(@"throws without a configuration block", ^{
            NSString *cellIdentifier = @"identifier";
            
            SPYCollectionController *collectionController = [SPYCollectionController controllerWithItems:@[] identifier:cellIdentifier configurationBlock:nil selectionBlock:^(id cell, id item) {
                
            }];
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
            UICollectionViewCell *cell = [[UICollectionViewCell alloc] init];
            [[_mockCollectionView should] receive:@selector(dequeueReusableCellWithReuseIdentifier:forIndexPath:) andReturn:cell withArguments:cellIdentifier, indexPath];
            
            [collectionController collectionView:_mockCollectionView cellForItemAtIndexPath:indexPath];
        });
    });
    
    context(@"UICollectionViewDelegate", ^{
        __block id _mockCollectionView;
        
        beforeEach(^{
            _mockCollectionView = [KWMock mockForClass:[UICollectionView class]];
        });
        
        context(@"with a selection block", ^{
            __block SPYCollectionController *collectionController = nil;
            __block UICollectionViewCell *selectedCell = nil;
            __block id selectedItem = nil;
            
            NSArray *items = @[@"one", @"two", @"three", @"four"];
            beforeEach(^{
                collectionController = [SPYCollectionController controllerWithItems:items identifier:@"cellIdentifier" configurationBlock:^(id cell, id item) {
                    
                } selectionBlock:^(id cell, id item) {
                    selectedCell = cell;
                    selectedItem = item;
                }];
            });
            
            it(@"calls the selection block", ^{
                [[selectedCell should] beNil];
                [[selectedItem should] beNil];
                
                UICollectionViewCell *cell = [[UICollectionViewCell alloc] init];
                [[_mockCollectionView should] receive:@selector(cellForItemAtIndexPath:) andReturn:cell];
                
                NSIndexPath *indexPath = [NSIndexPath indexPathForItem:1 inSection:0];
                [collectionController collectionView:_mockCollectionView didSelectItemAtIndexPath:indexPath];
                
                [[selectedCell shouldNot] beNil];
                [[selectedItem shouldNot] beNil];
                [[selectedCell should] equal:cell];
                [[selectedItem should] equal:items[indexPath.item]];
            });
        });
        
        context(@"without a selection block", ^{
            __block SPYCollectionController *collectionController = nil;
            __block UICollectionViewCell *selectedCell = nil;
            __block id selectedItem = nil;
            
            NSArray *items = @[@"one", @"two", @"three", @"four"];
            beforeEach(^{
                collectionController = [SPYCollectionController controllerWithItems:items identifier:@"cellIdentifier" configurationBlock:^(id cell, id item) {
                    
                } selectionBlock:nil];
            });
            
            it(@"does nothing", ^{
                UICollectionViewCell *cell = [[UICollectionViewCell alloc] init];
                [[_mockCollectionView shouldNot] receive:@selector(cellForItemAtIndexPath:) andReturn:cell];
                
                NSIndexPath *indexPath = [NSIndexPath indexPathForItem:1 inSection:0];
                [collectionController collectionView:_mockCollectionView didSelectItemAtIndexPath:indexPath];
                
                [[selectedCell should] beNil];
                [[selectedItem should] beNil];
            });
        });
    });
    
});

SPEC_END

