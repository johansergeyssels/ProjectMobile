//
//  TabBarController.h
//  ProjectMobile
//
//  Created by johan on 19/05/14.
//  Copyright (c) 2014 johan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ButtonClickListener.h"
#import "TabBarView.h"

@interface TabBarController : UITabBarController<UITabBarControllerDelegate, ButtonClickListener>
@property(weak) TabBarView *tabBarView;
@end
