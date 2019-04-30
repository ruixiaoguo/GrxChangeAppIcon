//
//  ViewController.m
//  GrxChangeAppIcon
//
//  Created by grx on 2019/4/30.
//  Copyright © 2019 grx. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, readwrite, strong) UIButton *changeIconBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.changeIconBtn];
    self.changeIconBtn.frame = CGRectMake(80, 250, 200, 50);
    [self.changeIconBtn addTarget:self action:@selector(changeIconBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self changeIconBtnClick];
    });
    
    
}

- (void)changeIconBtnClick{
    int x = arc4random() % 3;
    
    NSArray *iconRandomArr = @[@"AppIcon58x58-1",@"AppIcon58x58-2",@"AppIcon58x58-3"];
    NSLog(@"%@",iconRandomArr[x]);
    
    NSString *iconName = [NSString stringWithFormat:@"%@",iconRandomArr[x]];
    //    must be used from main thread only
    if (![[UIApplication sharedApplication] supportsAlternateIcons]) {
        //不支持动态更换icon
        return;
    }
    
    if ([iconName isEqualToString:@""] || !iconName) {
        iconName = nil;
    }
    [[UIApplication sharedApplication] setAlternateIconName:iconName completionHandler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"更换app图标发生错误了 ： %@",error);
        }
    }];
}

//MARK: -- UI懒加载 --
- (UIButton *)changeIconBtn{
    if (!_changeIconBtn) {
        _changeIconBtn = [[UIButton alloc]init];
        _changeIconBtn.backgroundColor = [UIColor blueColor];
        [_changeIconBtn setTitle:@"更换Iocn图标" forState:UIControlStateNormal];
        [_changeIconBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _changeIconBtn.layer.cornerRadius = 10;
    }
    return _changeIconBtn;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
