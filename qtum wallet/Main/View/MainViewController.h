//
//  MainViewController.h
//  qtum wallet
//
//  Created by HenryFan on 8/8/2018.
//  Copyright © 2018 QTUM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Presentable.h"
#import "MainTableSource.h"
#import "MainOutput.h"

@class ViewWithAnimatedLine;
@class MainViewControllerViewModel;

@interface MainViewController : UIViewController <Presentable, MainControllerDelegate, MainOutput>

@property (nonatomic, strong) MainTableSource *tableSource;
@property (nonatomic, weak) id <MainOutputDelegate> delegate;
@property (nonatomic, strong) MainViewControllerViewModel *viewModel;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (void)configTableView;

@end
