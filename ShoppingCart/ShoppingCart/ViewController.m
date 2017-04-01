//
//  ViewController.m
//  ShoppingCart
//
//  Created by czf1 on 17/4/1.
//  Copyright © 2017年 YYN. All rights reserved.
//

#import "ViewController.h"
#import "YYNShoppingCartViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)intoShoppingBtnClick:(id)sender {
    YYNShoppingCartViewController *vc = [[YYNShoppingCartViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
