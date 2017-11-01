//
//  ViewController.m
//  LeePageController
//
//  Created by admin on 2017/10/13.
//  Copyright © 2017年 admin. All rights reserved.
//
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kRandomColor [UIColor colorWithRed:(arc4random() % 256)/255.0 green:(arc4random() % 256)/255.0 blue:(arc4random() % 256)/255.0 alpha:1];
#import "ViewController.h"

#import "LeePageController.h"

@interface ViewController ()
@property(nonatomic,strong) NSArray * cateArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor redColor];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    LeePageController * vc = [[LeePageController alloc] init];
    [vc setDataSource:(id<LeePageControllerDataSource>)self];
//    vc.titleItemHeight = 45;
//    vc.titleItemWidth = kScreenWidth / 5;
//    vc.selectColor = [UIColor redColor];
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSInteger)numbersOfChildControllersInPageController:(LeePageController *)pageController{
    return self.cateArray.count;
}

- (__kindof UIViewController *)pageController:(LeePageController *)pageController viewControllerAtIndex:(NSInteger)index{
    
    UIViewController * vc = [UIViewController new];
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 100, 40)];
    label.text = [NSString stringWithFormat:@"第%zd个",index];
    [vc.view addSubview:label];
    vc.view.backgroundColor = kRandomColor;
    return vc;
}

- (NSString *)pageController:(LeePageController *)pageController titleAtIndex:(NSInteger)index{
    return self.cateArray[index][@"name"];
}

- (NSArray *)cateArray {
    if (!_cateArray) {
        //        _itemNames = @[@"最新",@"新闻",@"评测",@"导购",@"用车",@"技术",@"文化",@"改装",@"游记",];
        _cateArray = @[ @{@"category_id" : @104, @"name" : @"热点要闻1",},
                         @{@"category_id" : @104, @"name" : @"热点要闻2",},
                         @{@"category_id" : @104, @"name" : @"热点要闻3",},
                         @{@"category_id" : @104, @"name" : @"热点要闻4",},
                        @{@"category_id" : @109, @"name" : @"体彩新闻5",},
                        @{@"category_id" : @108, @"name" : @"赛事资讯6",},
                        @{@"category_id" : @116, @"name" : @"数字推荐7",},
                        @{@"category_id" : @110, @"name" : @"活动特辑8",}];
    }
    return _cateArray;
}



@end
