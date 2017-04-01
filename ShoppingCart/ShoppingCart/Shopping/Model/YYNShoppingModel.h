//
//  YYNShoppingModel.h
//  ShoppingCart
//
//  Created by czf1 on 17/4/1.
//  Copyright © 2017年 YYN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YYNShoppingModel : NSObject

@property (nonatomic, copy)NSString *img;/**图片**/

@property (nonatomic, copy)NSString *productDes;/**商品描述**/

@property (nonatomic, assign)NSInteger amount;/**商品数量**/

@property (nonatomic, assign)CGFloat totalMoney;/**单件商品总价**/
@property (nonatomic, assign)CGFloat singleMoney;/**商品单价总价**/

@property (nonatomic, copy)NSString *productCorlor;/**商品规格**/

@property (nonatomic, assign)BOOL isSelected;/**记录选中按钮的状态**/

@property (nonatomic, assign)CGFloat allTotalMoney;/**所有选中商品总价**/

@end
