//
//  HulpViewController.h
//  ProjectMobile
//
//  Created by Daan Theys on 20-05-14.
//  Copyright (c) 2014 johan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IManagedContextObjectContainer.h"
#import <AddressBookUI/AddressBookUI.h>

@interface HulpViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, IManagedContextObjectContainer,ABPeoplePickerNavigationControllerDelegate>
@property NSManagedObjectContext* context;
@property (strong, nonatomic) IBOutlet UIImageView *contactAfbeelding;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *lastname;

@end
