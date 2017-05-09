//
//  ViewController.m
//  Wave-Demo
//
//  Created by zyx on 17/5/3.
//  Copyright © 2017年 其妙. All rights reserved.
//

#import "ViewController.h"
#import "WaveView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    WaveView *wave = [[WaveView alloc] initWithFrame:CGRectMake(0, 200, self.view.bounds.size.width, 50)];
    [self.view addSubview:wave];
    
    [wave wave];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
