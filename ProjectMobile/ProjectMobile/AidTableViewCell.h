//
//  AidTableViewCell.h
//  ProjectMobile
//
//  Created by Daan Theys on 21-05-14.
//  Copyright (c) 2014 johan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AidTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *image;
@property (strong, nonatomic) IBOutlet UILabel *naamLabel;
@property (strong, nonatomic) IBOutlet UILabel *FamilienaamLabel;
@property (strong,nonatomic) IBOutlet NSString *telefoon;

@end
