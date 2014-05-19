//
//  ITabBarViewListener.h
//  ProjectMobile
//
//  Created by johan on 19/05/14.
//  Copyright (c) 2014 johan. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ITabBarViewListener <NSObject>
@required
- (void)didClickButton:(int)index;
@end
