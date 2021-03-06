//
//  TabBarController.m
//  ProjectMobile
//
//  Created by johan on 19/05/14.
//  Copyright (c) 2014 johan. All rights reserved.
//

#import "TabBarController.h"
#import "ButtonClickListener.h"

@interface TabBarController ()

@end

@implementation TabBarController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (NSUInteger) supportedInterfaceOrientations {
    // Return a bitmask of supported orientations. If you need more,
    // use bitwise or (see the commented return).
    return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskPortraitUpsideDown;
}

- (UIInterfaceOrientation) preferredInterfaceOrientationForPresentation {
    // Return the orientation you'd prefer - this is what it launches to. The
    // user can still rotate. You don't have to implement this method, in which
    // case it launches in the current orientation
    return UIInterfaceOrientationPortrait;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tabBarView = ((TabBarView *)self.tabBar);
    self.tabBarView.tabBarViewListener = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didClickButton:(int)index {
    [self setSelectedIndex:index];
    [self.tabBarView.memoryButton setSelected:NO];
    [self.tabBarView.calendarButton setSelected:NO];
    [self.tabBarView.locationButton setSelected:NO];
    [self.tabBarView.aidButton setSelected:NO];
    
    [self.tabBarView setHidden:NO];
    switch (index) {
        case 0:
            [self.tabBarView setHidden:YES];
            break;
        case 1:
            [self.tabBarView.memoryButton setSelected:YES];
            break;
        case 2:
            [self.tabBarView.calendarButton setSelected:YES];
            break;
        case 3:
            [self.tabBarView.locationButton setSelected:YES];
            break;
        case 4:
            [self.tabBarView.aidButton setSelected:YES];
            break;
            
        default:
        break;
    }
}

@end
