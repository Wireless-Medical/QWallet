//
//  PinViewController.h
//  qtum wallet
//
//  Created by Никита Федоренко on 13.12.16.
//  Copyright © 2016 Designsters. All rights reserved.
//

#import "PinController.h"
#import "CreatePinRootController.h"


@interface PinViewController : PinController

-(void)setCustomTitle:(NSString*) title;
-(void)actionIncorrectPin;


@end

