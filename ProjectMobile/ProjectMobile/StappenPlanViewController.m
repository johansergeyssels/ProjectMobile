//
//  StappenPlanViewController.m
//  ProjectMobile
//
//  Created by johan on 20/05/14.
//  Copyright (c) 2014 johan. All rights reserved.
//

#import "StappenPlanViewController.h"
#import "Stappenplan.h"

@interface StappenPlanViewController ()

@end

@implementation StappenPlanViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    Stappenplan *stepstones = [NSEntityDescription insertNewObjectForEntityForName:@"Stappenplan" inManagedObjectContext:self.context];
    stepstones.titel = @"test";
    NSError* error;
    if([self.context save:&error]) {
        NSLog(@"gelukt");
    }
    else
    {
        NSLog(@"mislukt");
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
