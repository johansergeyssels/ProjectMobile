//
//  TabBarView.h
//  ProjectMobile
//
//  Created by johan on 19/05/14.
//  Copyright (c) 2014 johan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ButtonClickListener.h"

@interface TabBarView : UITabBar
@property (strong, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UIButton *homeButton;
@property (weak, nonatomic) IBOutlet UIButton *locationButton;
@property (weak, nonatomic) IBOutlet UIButton *memoryButton;
@property (weak, nonatomic) IBOutlet UIButton *aidButton;
@property (weak, nonatomic) IBOutlet UIButton *calendarButton;
@property id<ButtonClickListener> tabBarViewListener;

@end
