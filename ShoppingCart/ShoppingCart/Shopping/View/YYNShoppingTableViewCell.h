//
//  YYNShoppingTableViewCell.h
//  ShoppingCart
//
//  Created by czf1 on 17/4/1.
//  Copyright © 2017年 YYN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYNShoppingModel.h"

@interface YYNShoppingTableViewCell : UITableViewCell

@property (nonatomic, strong)YYNShoppingModel *model;/**数据**/

//@property (nonatomic, weak)id<YYNShoppingTableViewViewDelegate> customDelegate;

@property (nonatomic, strong)NSIndexPath *indexPath;

@property (nonatomic, copy)void(^selectBtnClickBlock)(BOOL);/**选择按钮**/
@property (nonatomic, copy)void(^reduceBtnClickBlock)();/**减少按钮**/
@property (nonatomic, copy)void(^addBtnClickBlock)();/**增加按钮**/


@end
