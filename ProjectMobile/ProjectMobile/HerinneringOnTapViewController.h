//
//  HerinneringOnTapViewController.h
//  ProjectMobile
//
//  Created by KOEKOEKX Annelies (s) on 23/05/14.
//  Copyright (c) 2014 johan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Herinnering.h"

@interface HerinneringOnTapViewController : UIViewController<UIImagePickerControllerDelegate>


@property (weak, nonatomic) IBOutlet UILabel *Label;
@property (weak, nonatomic) IBOutlet UITextView *commentText;
@property Herinnering *herinnering;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end
