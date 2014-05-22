//
//  HerinneringToevoegenViewController.h
//  ProjectMobile
//
//  Created by KOEKOEKX Annelies (s) on 21/05/14.
//  Copyright (c) 2014 johan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IManagedContextObjectContainer.h"
#import "Herinnering.h"
#import "IManagedContextObjectContainer.h"

@interface HerinneringDetailViewController : UIViewController<IManagedContextObjectContainer, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

{
    UIImagePickerController *imagePicker;
}

@property NSManagedObjectContext* context;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *Gallerij_btn;
@property (weak, nonatomic) IBOutlet UIButton *FotoNemen_btn;
@property (strong, nonatomic) IBOutlet UITextField *LabelText;
@property Herinnering *herinnering;
@end