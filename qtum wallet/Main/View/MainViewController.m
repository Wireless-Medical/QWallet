//
//  MainViewController.m
//  qtum wallet
//
//  Created by HenryFan on 8/8/2018.
//  Copyright © 2018 QTUM. All rights reserved.
//

#import "MainViewController.h"
#import "MainRequestManager.h"

@interface MainViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UILabel *availableLabel;
@property (weak, nonatomic) IBOutlet UIView *viewForHeaderInSecondSection;
@property (weak, nonatomic) IBOutlet UILabel *activityLabel;
@end

@implementation MainViewController

#pragma mark - Lifecycle

- (void)dealloc {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configTableView];
    [self configRefreshControl];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Public Methods

- (void)configTableView {
    self.tableView.tableFooterView = [UIView new];
    self.tableView.dataSource = self.tableSource;
    self.tableView.delegate = self.tableSource;
    self.tableSource.tableView = self.tableView;
    self.tableSource.controllerDelegate = self;
}

- (void)configRefreshControl {
}

- (void)refreshFromRefreshControl {
    dispatch_async (dispatch_get_main_queue (), ^{
        [self.refreshControl endRefreshing];
    });
    [self.delegate didReloadTableViewData];
}


#pragma mark - MainOutput

- (void)reloadTableView {
    [self.tableView reloadData];
}

- (void)failedToGetData {
    
}

- (void)failedToGetBalance {
    
}

- (void)startLoading {
    dispatch_async(dispatch_get_main_queue(), ^{
        [SLocator.popupService showLoaderPopUp];
    });
}

- (void)stopLoading {
    dispatch_async (dispatch_get_main_queue (), ^{
        [SLocator.popupService dismissLoader];
    });
}

#pragma mark - TableSourceDelegate

- (void)needShowHeader:(CGFloat)percent {
}

- (void)needHideHeader:(CGFloat)percent {
}

- (void)needShowHeaderForSecondSeciton {
    self.viewForHeaderInSecondSection.hidden = NO;
}

- (void)needHideHeaderForSecondSeciton {
    self.viewForHeaderInSecondSection.hidden = YES;
}

#pragma mark - IBAction

- (IBAction)actionButtonDidPress:(id)sender {
    [self.delegate didUploadFile];
}

#pragma mark - Accessors

- (MainViewControllerViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[MainViewControllerViewModel alloc] init];
    }
    return _viewModel;
}

@end
