//
//  PersoonDetailViewController.h
//  ProjectMobile
//
//  Created by Michael on 21/05/14.
//  Copyright (c) 2014 johan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBookUI/AddressBookUI.h>


@interface PersoonDetailViewController : UIViewController <ABPeoplePickerNavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property UIImage *image;
@end
