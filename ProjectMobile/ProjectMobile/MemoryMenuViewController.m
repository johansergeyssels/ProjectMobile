//
//  MemoryMenuViewController.m
//  ProjectMobile
//
//  Created by johan on 20/05/14.
//  Copyright (c) 2014 johan. All rights reserved.
//

#import "MemoryMenuViewController.h"
#import "IManagedContextObjectContainer.h"

@interface MemoryMenuViewController ()

@end

@implementation MemoryMenuViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if(![segue.identifier isEqualToString:@"gotoPersons"]) {
        id<IManagedContextObjectContainer> container = segue.destinationViewController;
        container.context = self.context;
    }
}

@end
