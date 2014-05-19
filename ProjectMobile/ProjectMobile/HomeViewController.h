//
//  HomeViewController.h
//  ProjectMobile
//
//  Created by johan on 19/05/14.
//  Copyright (c) 2014 johan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ButtonClickListener.h"
@interface HomeViewController : UIViewController
@property (weak) id<ButtonClickListener> listener;

@end
