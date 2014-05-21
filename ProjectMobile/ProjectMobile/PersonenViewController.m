//
//  PersonenViewController.m
//  ProjectMobile
//
//  Created by Michael on 20/05/14.
//  Copyright (c) 2014 johan. All rights reserved.
//

#import "PersonenViewController.h"
#import "PersoonCell.h"

@interface PersonenViewController ()

@property NSMutableArray *PersoonImages;


@end

@implementation PersonenViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[self personenCollectionView ]setDataSource:self];
    [[self personenCollectionView ]setDelegate:self];

    self.PersoonImages = [[NSMutableArray alloc]initWithObjects:@"Man.jpeg", @"Doctor.jpeg", @"Son.jpeg", nil];
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
    
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.PersoonImages count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentiefier = @"Cell";
    PersoonCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentiefier forIndexPath: indexPath];
    [[cell persoonImage]setImage:[UIImage imageNamed:self.PersoonImages[indexPath.item]]] ;
    return cell;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}






/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
