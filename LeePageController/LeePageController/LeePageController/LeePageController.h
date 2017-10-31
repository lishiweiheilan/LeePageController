//
//  LeePageController.h
//  LeePageController
//
//  Created by admin on 2017/10/13.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeePageController : UIViewController
@property(nonatomic,strong) NSArray * titlesArr;//标题数组
@property(nonatomic,strong) NSArray * controllerArr;//控制器数组
@property(nonatomic,assign) CGFloat titleItemHeight;//item的高度
@property(nonatomic,assign) CGFloat titleItemWidth;//item的宽度
@property(nonatomic,assign) NSInteger titleFontSize;//字体大小
@property(nonatomic,strong) NSMutableArray * controllers;
@property(nonatomic,strong) UIColor * selectColor;
@end
