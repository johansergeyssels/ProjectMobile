//
//  LocationToevoegenControllerViewController.h
//  ProjectMobile
//
//  Created by David Bueds on 20/05/14.
//  Copyright (c) 2014 johan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Locatie.h"
#import "IManagedContextObjectContainer.h"

@interface LocationToevoegenControllerViewController : UIViewController<IManagedContextObjectContainer>

@property NSManagedObjectContext* context;
@property Locatie *locatie;

@property (weak, nonatomic) IBOutlet UITextField *GemeenteTextField;
@property (weak, nonatomic) IBOutlet UITextField *StraatnaamTextField;
@property (weak, nonatomic) IBOutlet UITextField *HuisnummerTextField;
@property (weak, nonatomic) IBOutlet UITextField *BusTextField;
@property (weak, nonatomic) IBOutlet UITextField *InfoTextField;

- (IBAction)OpslaanButton:(id)sender;

@end
