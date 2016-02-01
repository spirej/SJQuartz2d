//
//  ViewController.m
//  SJQuartz2d
//
//  Created by SPIREJ on 16/1/28.
//  Copyright © 2016年 SPIREJ. All rights reserved.
//

#import "ViewController.h"
#import "CustomView.h"

@interface ViewController ()
@property(nonatomic, retain)CustomView *customView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.customView = [[CustomView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    self.customView.image = [UIImage imageNamed:@"meinv"];
    [self.view addSubview:self.customView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"touchBrgan");
    
}

@end
