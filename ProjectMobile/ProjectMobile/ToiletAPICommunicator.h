//
//  ToiletAPICommunicator.h
//  ProjectMobile
//
//  Created by David Bueds on 20/05/14.
//  Copyright (c) 2014 johan. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ToiletAPICommunicator <NSObject>
- (void)receiveGroupToiletAPIJSON:(NSData *)objectNotation;
- (void)fetchingGroupToiletAPIFailedWithError:(NSError *)error;
@end
