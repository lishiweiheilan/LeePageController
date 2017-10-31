//
//  LeePageController.m
//  LeePageController
//
//  Created by admin on 2017/10/13.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "LeePageController.h"
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kRandomColor [UIColor colorWithRed:(arc4random() % 256)/255.0 green:(arc4random() % 256)/255.0 blue:(arc4random() % 256)/255.0 alpha:1];

@interface LeePageController ()<UIScrollViewDelegate>
@property(nonatomic,strong) UIScrollView * titlesScrollerView;
@property(nonatomic,strong) UIScrollView * vcScrollerView;
@property(nonatomic,strong) NSMutableArray * itemArr;
@property(nonatomic,strong) UIView * lineView;
@end

@implementation LeePageController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleItemHeight = 45;
    self.titleItemWidth = kScreenWidth / 5;
    self.selectColor = [UIColor redColor];
    [self buidingUI];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = YES;
}

-(void)buidingUI{
    [self.view addSubview:self.titlesScrollerView];
    [self.view addSubview:self.vcScrollerView];
    for (int i = 0 ; i < self.titlesArr.count; i++) {
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(self.titleItemWidth * i, 0, self.titleItemWidth, self.titleItemHeight)];
        button.tag = i;
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitle:@"拉拉" forState:UIControlStateNormal];
        [button setTitleColor:self.selectColor forState:UIControlStateSelected];
        [self.titlesScrollerView addSubview:button];
        [self.itemArr addObject:button];
        if (i==0)  button.selected = YES;
        [button addTarget:self action:@selector(titleItemClick:) forControlEvents:UIControlEventTouchDown];
    }
     [self.titlesScrollerView addSubview:self.lineView];
}

-(void)titleItemClick:(UIButton *)button{

    [self buttonIsSelectedWithIndex:button.tag];
    self.vcScrollerView.contentOffset = CGPointMake(button.tag * kScreenWidth, 0);
}



-(void)buttonIsSelectedWithIndex:(NSInteger )index{
    for (UIButton * button in self.itemArr) {
        if (button.tag == index) {
            button.selected = YES;
        }else{
            button.selected = NO;
        }
    }
}
#pragma mark -- scrollView代理方法

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView == self.vcScrollerView) {
        NSInteger index = scrollView.contentOffset.x / kScreenWidth;
        [self buttonIsSelectedWithIndex:index];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == self.vcScrollerView) {
        NSLog(@"偏移值比例%lf",scrollView.contentOffset.x / scrollView.contentSize.width);
        CGFloat offsetProportion = scrollView.contentOffset.x / scrollView.contentSize.width;
        CGPoint offset = self.titlesScrollerView.contentOffset;
        offset.x = self.titlesScrollerView.contentSize.width * offsetProportion;
        [self.titlesScrollerView setContentOffset:offset animated:YES];
        self.lineView.frame = CGRectMake(offset.x, self.titleItemHeight - 1, self.titleItemWidth, 1);
    }
    if (scrollView == self.titlesScrollerView) {
        if (self.titlesScrollerView.contentOffset.x < 0) {
            self.titlesScrollerView.contentOffset = CGPointMake(0, 0);
        }
        
        if (self.titlesScrollerView.contentOffset.x  > self.titlesScrollerView.contentSize.width - kScreenWidth ) {
            self.titlesScrollerView.contentOffset = CGPointMake(self.titlesScrollerView.contentSize.width - kScreenWidth , 0);
        }
    }
}

#pragma mark --懒加载
-(UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.titleItemHeight - 1, self.titleItemWidth, 1)];
        _lineView.backgroundColor = self.selectColor;
    }
    return _lineView;
}

-(NSMutableArray *)controllers{
    if (!_controllers) {
        _controllers = [NSMutableArray array];
        for (int i = 0 ; i < self.titlesArr.count; i++) {
            UIViewController * vc = [[UIViewController alloc] init];
            vc.view.backgroundColor = kRandomColor;
            [_controllers addObject:vc];
        }
    }
    return _controllers;
}

-(NSMutableArray *)itemArr{
    if (!_itemArr) {
        _itemArr = [NSMutableArray array];
    }
    return _itemArr;
}

-(UIScrollView *)titlesScrollerView{
    if (!_titlesScrollerView) {
        _titlesScrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.titleItemHeight)];
       
        _titlesScrollerView.backgroundColor = [UIColor whiteColor];
        _titlesScrollerView.contentSize = CGSizeMake(self.titleItemWidth * self.titlesArr.count, self.titleItemHeight);
        _titlesScrollerView.showsHorizontalScrollIndicator = NO;
        _titlesScrollerView.delegate = self;
    }
    return _titlesScrollerView;
}

-(UIScrollView *)vcScrollerView{
    if (!_vcScrollerView) {
        CGFloat height = self.view.frame.size.height - self.titleItemHeight;
        _vcScrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.titlesScrollerView.frame.origin.y + self.titleItemHeight, kScreenWidth, height)];
        _vcScrollerView.pagingEnabled = YES;
        _vcScrollerView.bounces = NO;
        _vcScrollerView.contentSize = CGSizeMake(kScreenWidth * self.titlesArr.count, self.titleItemHeight);
        _vcScrollerView.delegate =self;
//        _vcScrolle rView.showsHorizontalScrollIndicator = NO;
        for (int i = 0 ; i < self.controllers.count; i++) {
            UIViewController * vc = self.controllers[i];
            vc.view.frame = CGRectMake(kScreenWidth * i, 0, kScreenWidth, height);
            [_vcScrollerView addSubview:vc.view];
        }
    }
    return _vcScrollerView;
}

-(NSArray *)titlesArr{
    if (!_titlesArr) {
        _titlesArr = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7"];
    }
    return _titlesArr;
}

@end
