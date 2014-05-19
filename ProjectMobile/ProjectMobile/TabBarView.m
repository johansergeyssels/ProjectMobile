//
//  TabBarView.m
//  ProjectMobile
//
//  Created by johan on 19/05/14.
//  Copyright (c) 2014 johan. All rights reserved.
//

#import "TabBarView.h"
#import "ITabBarViewListener.h"

@implementation TabBarView
- (IBAction)homeClicked:(id)sender {
    [self.tabBarViewListener didClickButton:0];
}

- (IBAction)locationClicked:(id)sender {
    [self.tabBarViewListener didClickButton:3];
}

- (IBAction)memoryClicked:(id)sender {
    [self.tabBarViewListener didClickButton:1];
}

- (IBAction)aidClicked:(id)sender {
    [self.tabBarViewListener didClickButton:4];
}

- (IBAction)calendarClicked:(id)sender {
    [self.tabBarViewListener didClickButton:2];
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void) awakeFromNib {
    [[NSBundle mainBundle] loadNibNamed:@"TabBarView" owner:self options:nil];
    [self addSubview: self.view];
}

- (CGSize)sizeThatFits:(CGSize)size {
    CGSize auxSize = size;
    auxSize.height = self.view.frame.size.height;
    return auxSize;
}

@end
