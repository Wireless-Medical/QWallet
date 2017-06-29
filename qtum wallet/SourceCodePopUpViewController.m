//
//  SourceCodePopUpViewController.m
//  qtum wallet
//
//  Created by Sharaev Vladimir on 27.06.17.
//  Copyright © 2017 PixelPlex. All rights reserved.
//

#import "SourceCodePopUpViewController.h"

@interface SourceCodePopUpViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *okButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation SourceCodePopUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTextView];
    [self setupForContent];
}

- (void)setupTextView {
    self.textView.layer.borderWidth = 1.0f;
    self.textView.layer.borderColor = customBlackColor().CGColor;
}

- (IBAction)actionCancel:(id)sender {
    if ([self.delegate respondsToSelector:@selector(cancelButtonPressed:)]) {
        [self.delegate cancelButtonPressed:self];
    }
}

- (IBAction)actionCopy:(id)sender {
    if ([self.delegate respondsToSelector:@selector(okButtonPressed:)]) {
        [self.delegate okButtonPressed:self];
    }
}

- (void)setupForContent {
    PopUpContent *content = [self content];
    [self.okButton setTitle:content.okButtonTitle forState:UIControlStateNormal];
    [self.titleLabel setText:content.titleString];
    [self.textView setText:content.messageString];
}

@end
