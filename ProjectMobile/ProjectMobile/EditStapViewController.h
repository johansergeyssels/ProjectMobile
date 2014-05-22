//
//  EditStapViewController.h
//  ProjectMobile
//
//  Created by johan on 22/05/14.
//  Copyright (c) 2014 johan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Stap.h"

@interface EditStapViewController : UIViewController<UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *stepText;
@property Stap *step;
@property UIImagePickerController *picker;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end
