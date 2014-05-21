//
//  PersonenViewController.h
//  ProjectMobile
//
//  Created by Michael on 20/05/14.
//  Copyright (c) 2014 johan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBookUI/AddressBookUI.h>


@interface PersonenViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate, ABPeoplePickerNavigationControllerDelegate>


@property (weak, nonatomic) IBOutlet UICollectionView *personenCollectionView;

@end
