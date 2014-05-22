//
//  HerinneringViewController.h
//  ProjectMobile
//
//  Created by KOEKOEKX Annelies (s) on 21/05/14.
//  Copyright (c) 2014 johan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IManagedContextObjectContainer.h"

@interface HerinneringViewController : UIViewController<IManagedContextObjectContainer, UICollectionViewDataSource>
@property NSManagedObjectContext* context;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property NSMutableArray *herinneringen;
@end
