//
//  SPYViewController.m
//  SPYCollectionController
//
//  Created by Scott Petit on 11/9/13.
//  Copyright (c) 2013 Scott Petit. All rights reserved.
//

#import "SPYViewController.h"
#import "SPYCollectionController.h"

@interface SPYViewController ()

@property (nonatomic, strong) SPYCollectionController *collectionController;
@property (nonatomic, strong) UICollectionView *collectionView;

- (void)showCollectionView;

@end

static NSString * const cellIdentifier = @"cellIdentifier";

@implementation SPYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSArray *items = @[[UIColor redColor], [UIColor greenColor], [UIColor grayColor]];
    
    self.collectionController = [SPYCollectionController controllerWithItems:items identifier:cellIdentifier configurationBlock:^(id cell, UIColor *item) {
        [cell setBackgroundColor:item];
    } selectionBlock:^(id cell, id item) {
        [self.collectionView setBackgroundColor:item];
    }];
    
    [self showCollectionView];
}

- (void)showCollectionView
{
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
    self.collectionView.backgroundColor = [UIColor yellowColor];
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
    
    self.collectionView.dataSource = self.collectionController;
    self.collectionView.delegate = self.collectionController;
    
    [self.view addSubview:self.collectionView];
}


@end
