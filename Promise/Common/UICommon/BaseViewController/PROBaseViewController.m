//
//  PROBaseViewController.m
//  Promise
//
//  Created by Hongwei Liu on 2021/4/4.
//

#import "PROBaseViewController.h"

@interface PROBaseViewController ()

@end

@implementation PROBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEditTap:)];
    [self.view addGestureRecognizer:tap];
}

- (void)endEditTap:(UITapGestureRecognizer*)sender {
    [self.view endEditing:YES];
}

@end
