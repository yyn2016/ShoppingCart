//
//  YYNHandleModel.m
//  ShoppingCart
//
//  Created by czf1 on 17/4/1.
//  Copyright © 2017年 YYN. All rights reserved.
//

#import "YYNHandleModel.h"
#import "YYNShoppingModel.h"

@implementation YYNHandleModel

+ (instancetype)shareManage{
    
    static YYNHandleModel *model = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        model = [[YYNHandleModel alloc] init];
    });
    return model;
}


//所选商品总价
-(CGFloat)selectedTotalMoneyWithData:(NSMutableArray *)dataSource{
    CGFloat totalMoney = 0.00;
    for (NSMutableArray *arr in dataSource) {
        for (YYNShoppingModel *model in arr) {
            if (model.isSelected) {
                totalMoney += model.totalMoney;
            }
        }
    }
    return totalMoney;
}

//根据全选按钮的状态改天每个商品的选择状态
- (void)changeEveryProductStateWithData:(NSMutableArray *)dataSource andAllSelectBtnState:(BOOL)isSelectedAll{
    if (isSelectedAll) {
        for (NSMutableArray *arr in dataSource) {
            for (YYNShoppingModel *model in arr) {
                model.isSelected = YES;
            }
        }
    }else{
        for (NSMutableArray *arr in dataSource) {
            for (YYNShoppingModel *model in arr) {
                model.isSelected = NO;
            }
        }
    }
    
}


@end
