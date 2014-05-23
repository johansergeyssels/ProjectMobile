//
//  HerinneringViewController.m
//  ProjectMobile
//
//  Created by KOEKOEKX Annelies (s) on 21/05/14.
//  Copyright (c) 2014 johan. All rights reserved.
//

#import "HerinneringViewController.h"
#import "HerinneringDetailViewController.h"
#import "HerinneringCollectionViewCell.h"

@interface HerinneringViewController ()

@end

@implementation HerinneringViewController

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
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.context rollback];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Herinnering"];
    NSError *error;
    self.herinneringen = [self.context executeFetchRequest:fetchRequest error:&error];
    [self.collectionView reloadData];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"addHerinnering"])
    {
        HerinneringDetailViewController *dest = segue.destinationViewController;
        dest.context = self.context;
        dest.herinnering = [NSEntityDescription insertNewObjectForEntityForName:@"Herinnering" inManagedObjectContext:self.context];
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.herinneringen.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HerinneringCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"herinneringCell" forIndexPath:indexPath];
    Herinnering *herinnering = [self.herinneringen objectAtIndex:indexPath.item];
    //NSURL *URL = [NSURL URLWithString:herinnering.fotourl];
    //[cell.image setImage:URL];
    cell.image.image = [[UIImage alloc] initWithData:herinnering.foto];
    return cell;
}

@end
