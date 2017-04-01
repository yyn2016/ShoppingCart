//
//  YYNCartBottomView.h
//  ShoppingCart
//
//  Created by czf1 on 17/4/1.
//  Copyright © 2017年 YYN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYNCartBottomView : UIView

//合计多少钱label
@property (nonatomic, strong)UILabel *totlaMoneyLabel;

//合计多少钱字符串
@property (nonatomic, copy)NSString *totleStr;

@property (nonatomic, copy)void(^selectAllBtnClickBlock)(BOOL);

@property (nonatomic, strong)UIButton *allSelectBtn;//全选按钮

@end
