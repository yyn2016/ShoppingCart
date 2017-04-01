//
//  YYNShoppingCartViewController.m
//  ShoppingCart
//
//  Created by czf1 on 17/4/1.
//  Copyright © 2017年 YYN. All rights reserved.
//

#import "YYNShoppingCartViewController.h"
#import "YYNCartBottomView.h"/**自定义底部视图**/
#import "YYNShoppingModel.h"/**数据**/

#import "YYNShoppingTableViewCell.h"
#import "YYNHandleModel.h"
#import "MBProgressHUD.h"


#define KScreenWidth [UIScreen mainScreen].bounds.size.width //当前屏宽
#define KScreenHeight [UIScreen mainScreen].bounds.size.height //当前屏高

static NSString *IdentifierCell = @"YYNShoppingTableViewCell";


@interface YYNShoppingCartViewController ()<UITableViewDelegate, UITableViewDataSource>{
    BOOL _isSelectAll;/**是否全选**/
}
@property (nonatomic, assign)CGFloat totalMoney;/**商品总价格**/

@property (nonatomic, strong)YYNCartBottomView *bottomView;/**底部视图**/

@property (nonatomic, strong)NSMutableArray *dataSource;/**数据源**/

@property (nonatomic, strong)UITableView *tableView;/**tableview**/

@end

@implementation YYNShoppingCartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"购物车";
    
    [self bottomView];
    [self tableView];
    [self.tableView reloadData];
}

#pragma mark - 数据源
- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _totalMoney = 0.00;
        _dataSource = [[NSMutableArray alloc] init];
        for (int i = 0; i < 20; i++) {
            YYNShoppingModel *model = [[YYNShoppingModel alloc] init];
            model.img = @"jishuchengguo_goumaijishu";
            model.productDes = [NSString stringWithFormat:@"测试数据测试数据测试数据%d",i];
            model.productCorlor = @"红色，M号";
            model.amount = 1;
            model.totalMoney = 100.00;
            model.singleMoney = 100.00;
            NSMutableArray *arr = [[NSMutableArray alloc] init];
            [arr addObject:model];
            [_dataSource addObject:arr];
        }
    }
    return _dataSource;
}

#pragma mark - 视图
- (YYNCartBottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[YYNCartBottomView alloc] initWithFrame:CGRectMake(0, KScreenHeight - 44, KScreenWidth, 44)];
        [self.view addSubview:_bottomView];
        
    }
    
#pragma mark - 全选按钮回调
    __weak typeof(self) weakSelf = self;
    _bottomView.selectAllBtnClickBlock = ^(BOOL isSelectAll){
        _isSelectAll = isSelectAll;
        //改变商品选择状态
        [[YYNHandleModel shareManage] changeEveryProductStateWithData:weakSelf.dataSource andAllSelectBtnState:isSelectAll];
        if (isSelectAll) {
            weakSelf.totalMoney = [[YYNHandleModel shareManage] selectedTotalMoneyWithData:weakSelf.dataSource];
            [weakSelf configSelectedTotalMoney:[NSString stringWithFormat:@"合计:¥%.02lf",weakSelf.totalMoney]];
        }else{
            weakSelf.totalMoney = 0.00;
            [weakSelf configSelectedTotalMoney:@"合计:¥0.00"];
        }
        
        [weakSelf.tableView reloadData];
    };
    
    return _bottomView;
}

#pragma mark - 商品的总价格赋值
//给合计label赋值
- (void)configSelectedTotalMoney:(NSString *)totalMoney{
    self.bottomView.totleStr = totalMoney;
    [self.bottomView totlaMoneyLabel];
}

#pragma mark - tableview
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, KScreenWidth, KScreenHeight - 44 - 64) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[YYNShoppingTableViewCell class] forCellReuseIdentifier:IdentifierCell];
        [self.view addSubview:_tableView];
        
    }
    return _tableView;
}

#pragma mark - tableview代理
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YYNShoppingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:IdentifierCell];
    YYNShoppingModel *model = self.dataSource[indexPath.section][indexPath.row];
    cell.model = model;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.indexPath = indexPath;
    
    //回调方法
    __weak typeof(self)weakSelf = self;
    cell.selectBtnClickBlock = ^(BOOL isSelected){//选择按钮回调
        model.isSelected = isSelected;
        if ((_isSelectAll && !isSelected) || (!_isSelectAll && !isSelected)) {
            _isSelectAll = NO;
            weakSelf.totalMoney -= model.totalMoney;
            weakSelf.bottomView.allSelectBtn.selected = isSelected;
            [weakSelf configSelectedTotalMoney:[NSString stringWithFormat:@"合计:¥%.02lf",weakSelf.totalMoney]];
            
        }else if(isSelected && !_isSelectAll){
            weakSelf.totalMoney += model.totalMoney;
            [weakSelf configSelectedTotalMoney:[NSString stringWithFormat:@"合计:¥%.02lf",weakSelf.totalMoney]];
            
        }
    };
    
    cell.reduceBtnClickBlock = ^(){//减少按钮回调
        if (model.amount == 1) {
            MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:weakSelf.view animated:YES];
            hub.mode = MBProgressHUDModeText;
            hub.bezelView.backgroundColor = [UIColor lightGrayColor];
            hub.label.text = @"不能再少了哦亲!";
            hub.label.textColor = [UIColor whiteColor];
            [hub hideAnimated:YES afterDelay:2];
        }else{
            model.amount--;
            model.totalMoney -= model.singleMoney;
            weakSelf.totalMoney -= model.singleMoney;
            [weakSelf configSelectedTotalMoney:[NSString stringWithFormat:@"合计:¥%.02lf",weakSelf.totalMoney]];
            NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:indexPath.section];
            [weakSelf.tableView reloadSections:indexSet withRowAnimation:NO];
        }
    };
    
    cell.addBtnClickBlock = ^(){//增加按钮回调
        model.amount++;
        model.totalMoney += model.singleMoney;
        weakSelf.totalMoney += model.singleMoney;
        [weakSelf configSelectedTotalMoney:[NSString stringWithFormat:@"合计:¥%.02lf",weakSelf.totalMoney]];
        NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:indexPath.section];
        [weakSelf.tableView reloadSections:indexSet withRowAnimation:NO];
        
    };
    
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataSource[section] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    editingStyle = UITableViewCellEditingStyleDelete;
    [self.dataSource removeObjectAtIndex:indexPath.section];
    self.totalMoney = [[YYNHandleModel shareManage] selectedTotalMoneyWithData:self.dataSource];
    [self configSelectedTotalMoney:[NSString stringWithFormat:@"合计:¥%.02lf",self.totalMoney]];
    [self.tableView reloadData];
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
