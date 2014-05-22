//
//  AidTableViewCell.m
//  ProjectMobile
//
//  Created by Daan Theys on 21-05-14.
//  Copyright (c) 2014 johan. All rights reserved.
//

#import "AidTableViewCell.h"

@implementation AidTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
