//
//  ApplicationCoordinator.h
//  qtum wallet
//
//  Created by Никита Федоренко on 13.12.16.
//  Copyright © 2016 Designsters. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "AuthCoordinator.h"
#import "LoginCoordinator.h"

@protocol ApplicationCoordinatorDelegate <NSObject>

-(void)coordinatorDidAuth:(AuthCoordinator*)coordinator;
-(void)coordinatorDidLogin:(LoginCoordinator*)coordinator;
-(void)coordinatorDidCanceledLogin:(LoginCoordinator*)coordinator;


@end

@interface ApplicationCoordinator : NSObject <Coordinatorable, ApplicationCoordinatorDelegate>


-(void)start;
//flows
-(void)startAuthFlow;
-(void)startMainFlow;
-(void)startStartFlowWithAutorization:(BOOL) flag;
-(void)startWalletFlow;
-(void)startCreatePinFlowWithCompletesion:(void(^)()) completesion;
-(void)startChangePinFlow;

-(void)showWallet;
-(void)showExportBrainKeyAnimated:(BOOL)animated;

-(void)pushViewController:(UIViewController*) controller animated:(BOOL)animated;
-(void)setViewController:(UIViewController*) controller animated:(BOOL)animated;


+ (instancetype)sharedInstance;
- (id)init __attribute__((unavailable("cannot use init for this class, use sharedInstance instead")));
+ (instancetype)alloc __attribute__((unavailable("alloc not available, call sharedInstance instead")));
+ (instancetype) new __attribute__((unavailable("new not available, call sharedInstance instead")));

@end