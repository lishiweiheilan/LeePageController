//
//  LeePageController.h
//  LeePageController
//
//  Created by admin on 2017/10/13.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LeePageController;

@protocol LeePageControllerDataSource <NSObject>

@required

/**
 返回分页数量
 */
- (NSInteger)numbersOfChildControllersInPageController:(LeePageController *)pageController;
/**
 返回控制器
*/
- (__kindof UIViewController *)pageController:(LeePageController *)pageController viewControllerAtIndex:(NSInteger)index;
/**
标题
 */
- (NSString *)pageController:(LeePageController *)pageController titleAtIndex:(NSInteger)index;

@optional
/**
 点击item触发
 */
-(void)selectItemWithIndex:(NSInteger )index;

@end


@interface LeePageController : UIViewController
@property(nonatomic,assign) CGFloat titleItemHeight;//item的高度
@property(nonatomic,assign) CGFloat titleItemWidth;//item的宽度
@property(nonatomic,assign) UIFont * titleFontSize;//字体大小 默认15号
@property(nonatomic,strong) UIFont * selectFontSize;//选中的字体大小
//@property(nonatomic,strong) NSMutableArray * controllers;
@property(nonatomic,strong) UIColor * selectColor;//选中颜色 默认红色
@property(nonatomic,strong) UIColor * normalColor;//默认颜色 默认黑色
@property(nonatomic,weak) id<LeePageControllerDataSource>dataSource;
@end
