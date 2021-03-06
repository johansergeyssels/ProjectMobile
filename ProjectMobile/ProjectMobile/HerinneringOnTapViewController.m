//
//  HerinneringOnTapViewController.m
//  ProjectMobile
//
//  Created by KOEKOEKX Annelies (s) on 23/05/14.
//  Copyright (c) 2014 johan. All rights reserved.
//

#import "HerinneringOnTapViewController.h"
#import "HerinneringDetailViewController.h"

@interface HerinneringOnTapViewController ()

@end

@implementation HerinneringOnTapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.context rollback];
    self.detailImage.image = [[UIImage alloc]initWithData: self.herinnering.foto];
    self.Label.text = self.herinnering.label;
    self.commentText.text = self.herinnering.comment;
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    HerinneringDetailViewController *dest = segue.destinationViewController;
    dest.herinnering = self.herinnering;
    dest.context = self.context;
    
}

@end
