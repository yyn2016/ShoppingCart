//
//  YYNCartBottomView.m
//  ShoppingCart
//
//  Created by czf1 on 17/4/1.
//  Copyright © 2017年 YYN. All rights reserved.
//

#import "YYNCartBottomView.h"
#import "Masonry.h"

@interface YYNCartBottomView()


@property (nonatomic, strong)UIButton *calculateBtn;//结算按钮

@end

@implementation YYNCartBottomView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = [UIColor grayColor].CGColor;
        
        [self allSelectBtn];
        [self totlaMoneyLabel];
        [self calculateBtn];
    }
    return self;
}

#pragma mark - lazyLoading
- (UIButton *)allSelectBtn{
    if (!_allSelectBtn) {
        
        _allSelectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_allSelectBtn];
        [_allSelectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.leftMargin.equalTo(@12);
            make.width.equalTo(@80);
        }];
        
        [_allSelectBtn setImage:[UIImage imageNamed:@"xuanzhelianxiren_gou_n"] forState:UIControlStateNormal];
        [_allSelectBtn setImage:[UIImage imageNamed:@"xuanzelianxiren_gou"] forState:UIControlStateSelected];
        [_allSelectBtn setTitle:@"全选" forState:UIControlStateNormal];
        [_allSelectBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _allSelectBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        [_allSelectBtn addTarget:self action:@selector(allSelectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _allSelectBtn;
}

- (UILabel *)totlaMoneyLabel{
    if (!_totlaMoneyLabel) {
        _totlaMoneyLabel = [[UILabel alloc] init];
        [self addSubview:_totlaMoneyLabel];
        [_totlaMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_allSelectBtn.mas_right).with.offset(12);
            make.centerY.equalTo(self);
        }];
        self.totleStr = @"合计:¥0.00";
    }
    NSMutableAttributedString *abs = [[NSMutableAttributedString alloc] initWithString:self.totleStr];
    [abs addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(3, self.totleStr.length - 3)];
    _totlaMoneyLabel.attributedText = abs;
    return _totlaMoneyLabel;
}

- (UIButton *)calculateBtn{
    if (!_calculateBtn) {
        
        _calculateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_calculateBtn];
        [_calculateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).with.offset(0);
            make.centerY.equalTo(self);
            make.height.mas_equalTo(self);
            make.width.equalTo(@80);
        }];
        
        [_calculateBtn setTitle:@"去结算" forState:UIControlStateNormal];
        [_calculateBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _calculateBtn.backgroundColor = [UIColor redColor];
        [_calculateBtn addTarget:self action:@selector(calculateBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _calculateBtn;
}



#pragma mark - btnClick
- (void)allSelectBtnClick:(UIButton *)btn{
    btn.selected = !btn.selected;
    self.selectAllBtnClickBlock(btn.selected);
}

- (void)calculateBtnClick:(UIButton *)btn{
    
}


@end
