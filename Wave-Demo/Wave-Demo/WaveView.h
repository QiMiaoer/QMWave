//
//  WaveView.h
//  Wave-Demo
//
//  Created by zyx on 17/5/3.
//  Copyright © 2017年 其妙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaveView : UIView

/// 振幅  波浪速度
@property (nonatomic, assign) CGFloat waveAmplitude, firstWaveSpeed, secondWaveSpeed, thirdWaveSpeed;
/// 波浪颜色
@property (nonatomic, strong) UIColor *firstWaveColor, *secondWaveColor, *thirdWaveColor;

- (void)wave;

- (void)stop;

@end
