//
//  LocationAddPicker.m
//  ProjectMobile
//
//  Created by David Bueds on 24/05/14.
//  Copyright (c) 2014 johan. All rights reserved.
//

#import "LocationAddPicker.h"

@implementation LocationAddPicker

#pragma mark - Init
-(id)initWithStyle:(UITableViewStyle)style {
    if ([super initWithStyle:style] != nil) {
        
        //Initialize the array
        _locationArray = [NSMutableArray array];
        
        //Set up the array of colors.
        [_locationArray addObject:@"Huidige locatie"];
        [_locationArray addObject:@"Voer locatie in"];
        
        //Make row selections persist.
        self.clearsSelectionOnViewWillAppear = NO;
        
        //Calculate how tall the view should be by multiplying the individual row height
        //by the total number of rows.
        NSInteger rowsCount = [_locationArray count];
        NSInteger singleRowHeight = [self.tableView.delegate tableView:self.tableView heightForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        NSInteger totalRowsHeight = rowsCount * singleRowHeight;
        
        //Calculate how wide the view should be by finding how wide each string is expected to be
        CGFloat largestLabelWidth = 0;
        for (NSString *locationChoice in _locationArray) {
            //Checks size of text using the default font for UITableViewCell's textLabel.
            CGSize labelSize = [locationChoice sizeWithFont:[UIFont boldSystemFontOfSize:20.0f]];
            if (labelSize.width > largestLabelWidth) {
                largestLabelWidth = labelSize.width;
            }
        }
        
        //Add a little padding to the width
        CGFloat popoverWidth = largestLabelWidth + 100;
        
        //Set the property to tell the popover container how big this view will be.
        self.contentSizeForViewInPopover = CGSizeMake(popoverWidth, totalRowsHeight);
    }
    
    return self;
}

#pragma mark - View Lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_locationArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //aanmaken cell identificeren
    static NSString *CellIdentifier = @"Cell";
    //cell toewijzen
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //als de cell niet is aangemaakt een stijl geven
    if( cell == nil) {
        //cell alloceren en default stijl geven
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    //configureren van de cell
    cell.textLabel.text = [_locationArray objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    NSString *selectedLocationChoice = [_locationArray objectAtIndex:indexPath.row];
    
    //Create a variable to hold the selection, making its default color
    //something annoying and obvious so you can see if you've missed
    //a case here.
    UIColor *color = [UIColor orangeColor];
    
    //Set the color object based on the selected color name.
    if ([selectedColorName isEqualToString:@"Red"]) {
        color = [UIColor redColor];
    } else if ([selectedColorName isEqualToString:@"Green"]){
        color = [UIColor greenColor];
    } else if ([selectedColorName isEqualToString:@"Blue"]) {
        color = [UIColor blueColor];
    }
    
    //Notify the delegate if it exists.
    if (_delegate != nil) {
        [_delegate selectedColor:color];
    }
     */
}

@end
