//
//  YYNShoppingTableViewCell.m
//  ShoppingCart
//
//  Created by czf1 on 17/4/1.
//  Copyright © 2017年 YYN. All rights reserved.
//

#import "YYNShoppingTableViewCell.h"
#import "Masonry.h"

@interface YYNShoppingTableViewCell ()

@property (nonatomic, strong)UIButton *selectBtn;/**选择按钮**/

@property (nonatomic, strong)UIImageView *productImageView;/**图片**/

@property (nonatomic, strong)UILabel *desLabel;/**商品描述label**/

@property (nonatomic, strong)UILabel *corlorLabel;/**颜色label**/

@property (nonatomic, strong)UILabel *totalMoneyLabel;/**总价label**/

@property (nonatomic, strong)UILabel *amountLabel;/**总数量label**/

@property (nonatomic, strong)UIButton *reduceBtn;/**减少按钮**/

@property (nonatomic, strong)UIButton *addBtn;/**增加按钮**/

@end

@implementation YYNShoppingTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _productImageView = [[UIImageView alloc] init];
        _desLabel = [[UILabel alloc] init];
        _corlorLabel = [[UILabel alloc] init];
        _totalMoneyLabel = [[UILabel alloc] init];
        _amountLabel = [[UILabel alloc] init];
        _reduceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:_selectBtn];
        [self.contentView addSubview:_productImageView];
        [self.contentView addSubview:_desLabel];
        [self.contentView addSubview:_corlorLabel];
        [self.contentView addSubview:_totalMoneyLabel];
        [self.contentView addSubview:_amountLabel];
        [self.contentView addSubview:_reduceBtn];
        [self.contentView addSubview:_addBtn];
        
        [self layoutAllElement];
    }
    return self;
}

- (void)layoutAllElement{
    [_selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.leftMargin.equalTo(@12);
    }];
    [_selectBtn setImage:[UIImage imageNamed:@"xuanzhelianxiren_gou_n"] forState:UIControlStateNormal];
    [_selectBtn setImage:[UIImage imageNamed:@"xuanzelianxiren_gou"] forState:UIControlStateSelected];
    [_selectBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //图片
    [_productImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.left.mas_equalTo(_selectBtn.mas_right).equalTo(@12);
        make.height.equalTo(@76);
        make.width.equalTo(@76);
    }];
    
    //商品描述
    [_desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@12);
        make.left.mas_equalTo(_productImageView.mas_right).equalTo(@12);
        make.right.mas_lessThanOrEqualTo(_totalMoneyLabel.mas_left).mas_offset(-5);
    }];
    _desLabel.numberOfLines = 2;
    _desLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    
    //商品总价
    [_totalMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@14);
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-12);
        make.width.equalTo(@80);
    }];
    _totalMoneyLabel.textAlignment = NSTextAlignmentRight;
    
    //商品颜色
    [_corlorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_desLabel.mas_bottom).mas_offset(12);
        make.left.mas_equalTo(_productImageView.mas_right).equalTo(@12);
        make.right.mas_lessThanOrEqualTo(_reduceBtn.mas_left).mas_offset(-5);
    }];
    _corlorLabel.numberOfLines = 1;
    _corlorLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    _corlorLabel.font = [UIFont systemFontOfSize:15];
    _corlorLabel.textColor = [UIColor grayColor];
    
    //增加按钮
    [_addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-14);
        make.rightMargin.equalTo(@(-12));
    }];
    [_addBtn setImage:[UIImage imageNamed:@"cart_addBtn_nomal"] forState:UIControlStateNormal];
    [_addBtn setImage:[UIImage imageNamed:@"cart_addBtn_highlight"] forState:UIControlStateSelected];
    [_addBtn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //商品数量
    [_amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_addBtn);
        make.right.mas_equalTo(_addBtn.mas_left).mas_offset(@(-10));
    }];
    _amountLabel.numberOfLines = 1;
    _amountLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    _amountLabel.font = [UIFont systemFontOfSize:15];
    _amountLabel.textColor = [UIColor grayColor];
    
    //减少按钮
    [_reduceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-14);
        make.right.mas_equalTo(_amountLabel.mas_left).mas_offset(@(-10));
    }];
    [_reduceBtn setImage:[UIImage imageNamed:@"cart_cutBtn_nomal"] forState:UIControlStateNormal];
    [_reduceBtn setImage:[UIImage imageNamed:@"cart_cutBtn_highlight"] forState:UIControlStateSelected];
    [_reduceBtn addTarget:self action:@selector(reduceBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setModel:(YYNShoppingModel *)model{
    _model = model;
    
    _selectBtn.selected = model.isSelected;
    _productImageView.image = [UIImage imageNamed:model.img];
    _desLabel.text = model.productDes;
    _totalMoneyLabel.text = [NSString stringWithFormat:@"%.2lf",model.totalMoney];
    _corlorLabel.text = model.productCorlor;
    _amountLabel.text = [NSString stringWithFormat:@"%ld",(long)model.amount];
}



#pragma mark - btnClick
- (void)selectBtnClick:(UIButton *)btn{
    btn.selected = !btn.selected;
    _model.isSelected = btn.selected;
    if (self.selectBtnClickBlock) {
        self.selectBtnClickBlock(btn.selected);
    }
}

- (void)reduceBtnClick:(UIButton *)btn{
    if (self.reduceBtnClickBlock) {
        self.reduceBtnClickBlock();
    }
    
}

- (void)addBtnClick:(UIButton *)btn{
    if (self.addBtnClickBlock) {
        self.addBtnClickBlock();
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
