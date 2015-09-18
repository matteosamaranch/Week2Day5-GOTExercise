//
//  ViewController.m
//  GOTCollectionView
//
//  Created by Ricardo Sánchez Sotres on 12/06/14.
//  Copyright (c) 2014 Ricardo Sanchez. All rights reserved.
//

#import "ViewController.h"

#import "GotModel.h"

#import "CollectionViewCell.h"

#import "Character.h"

#import "House.h"

#import "CollectionReusableView.h"

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) IBOutlet GotModel *model;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *layout;
@property (strong, nonatomic) UICollectionViewFlowLayout *horizonLayout;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.model loadModel];
    [self.collectionView registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"cell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"CollectionReusableView" bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"nombreCasa"];
    
    self.layout.headerReferenceSize = CGSizeMake(100, 100);
}

- (IBAction)segmentedControl:(UISegmentedControl *)sender
{
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [self.model.houses count];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    House *house = [self.model.houses objectAtIndex:section];
    return [house.characters count];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    House *house = [self.model.houses objectAtIndex:indexPath.section];
    CollectionReusableView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"nombreCasa" forIndexPath:indexPath];
    reusableView.labelName.text = house.name;
    
    return reusableView;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    House *house = [self.model.houses objectAtIndex:indexPath.section];
    Character *character = [house.characters objectAtIndex:indexPath.row];
    NSString *imageName = [NSString stringWithFormat:@"%@.jpg", character.image];
    UIImage *imageCharacter = [UIImage imageNamed:imageName];
    cell.characterImage.image = imageCharacter;

    return cell;
}

- (UICollectionViewFlowLayout *)horizontalLayout
{
    if (!_horizonLayout)
    {
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
