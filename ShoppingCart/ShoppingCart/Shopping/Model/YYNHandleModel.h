//
//  YYNHandleModel.h
//  ShoppingCart
//
//  Created by czf1 on 17/4/1.
//  Copyright © 2017年 YYN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YYNHandleModel : NSObject

+ (instancetype)shareManage;

//所选商品总价
-(CGFloat)selectedTotalMoneyWithData:(NSMutableArray *)dataSource;

//根据全选按钮的状态改天每个商品的选择状态
- (void)changeEveryProductStateWithData:(NSMutableArray *)dataSource andAllSelectBtnState:(BOOL)isSelectedAll;


@end
