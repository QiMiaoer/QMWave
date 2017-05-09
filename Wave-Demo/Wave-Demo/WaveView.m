//
//  WaveView.m
//  Wave-Demo
//
//  Created by zyx on 17/5/3.
//  Copyright © 2017年 其妙. All rights reserved.
//

#import "WaveView.h"

@implementation WaveView {
    CGFloat _waveHeight;
    CGFloat _waveWidth;
    CADisplayLink *_waveDisplayLink;
    
    CGFloat _firstWaveX;
    CGFloat _secondWaveX;
    CGFloat _thirdWaveX;
    
    CAShapeLayer *_firstShapeLayer;
    CAShapeLayer *_secondShapeLayer;
    CAShapeLayer *_thirdShapeLayer;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _waveHeight = frame.size.height / 2;
        _waveWidth = frame.size.width;
        
        _firstWaveX = 0;
        _secondWaveX = frame.size.width / 4;
        _thirdWaveX = frame.size.width / 2;
        
        _firstShapeLayer = [CAShapeLayer layer];
        _secondShapeLayer = [CAShapeLayer layer];
        _thirdShapeLayer = [CAShapeLayer layer];
        [self.layer addSublayer:_firstShapeLayer];
        [self.layer addSublayer:_secondShapeLayer];
        [self.layer addSublayer:_thirdShapeLayer];
        _firstShapeLayer.fillColor = [self.firstWaveColor CGColor];
        _secondShapeLayer.fillColor = [self.secondWaveColor CGColor];
        _thirdShapeLayer.fillColor = [self.thirdWaveColor CGColor];
    }
    
    return self;
}

- (void)wave {
    _waveDisplayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(runWave)];
    [_waveDisplayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)runWave {
    _firstWaveX += self.firstWaveSpeed;
    _secondWaveX += self.secondWaveSpeed;
    _thirdWaveX += self.thirdWaveSpeed;
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGContextSetFillColorWithColor(context, [[[UIColor whiteColor] colorWithAlphaComponent:0.1] CGColor]);
    _firstShapeLayer.path = [self operationPath:path byWaveX:_firstWaveX];
    _secondShapeLayer.path = [self operationPath:path byWaveX:_secondWaveX];
    _thirdShapeLayer.path = [self operationPath:path byWaveX:_thirdWaveX];
    
    CGContextAddPath(context, path);
    CGContextFillPath(context);
    CGContextDrawPath(context, kCGPathStroke);
    
    CGPathRelease(path);
}

- (CGMutablePathRef)operationPath:(CGMutablePathRef)path byWaveX:(CGFloat)waveX {
    CGFloat y = 0;
    CGPathMoveToPoint(path, NULL, 0, 0);
    for (float x = 0; x <= _waveWidth; x++) {
        y = self.waveAmplitude * sinf((360 / _waveWidth) * (x * M_PI / 180) - waveX * M_PI / 180) + _waveHeight;
        CGPathAddLineToPoint(path, NULL, x, y);
    }
    CGPathAddLineToPoint(path, NULL, _waveWidth, self.frame.size.height);
    CGPathAddLineToPoint(path, NULL, 0, self.frame.size.height);
    
    return path;
}

- (void)stop {
    [_waveDisplayLink invalidate];
    _waveDisplayLink = nil;
    _firstWaveX = 0;
    _secondWaveX = self.frame.size.width / 4;
    _thirdWaveX = self.frame.size.width / 2;
}

- (CGFloat)waveAmplitude {
    if (!_waveAmplitude) {
        _waveAmplitude = 10;
    }
    return _waveAmplitude;
}

- (CGFloat)firstWaveSpeed {
    if (!_firstWaveSpeed) {
        _firstWaveSpeed = 1.0;
    }
    return _firstWaveSpeed;
}

- (CGFloat)secondWaveSpeed {
    if (!_secondWaveSpeed) {
        _secondWaveSpeed = 1.2;
    }
    return _secondWaveSpeed;
}

- (CGFloat)thirdWaveSpeed {
    if (!_thirdWaveSpeed) {
        _thirdWaveSpeed = 1.5;
    }
    return _thirdWaveSpeed;
}

- (UIColor *)firstWaveColor {
    if (!_firstWaveColor) {
        _firstWaveColor = [[UIColor cyanColor] colorWithAlphaComponent:0.5];
    }
    return _firstWaveColor;
}

- (UIColor *)secondWaveColor {
    if (!_secondWaveColor) {
        _secondWaveColor = [[UIColor cyanColor] colorWithAlphaComponent:0.3];
    }
    return _secondWaveColor;
}

- (UIColor *)thirdWaveColor {
    if (!_thirdWaveColor) {
        _thirdWaveColor = [[UIColor cyanColor] colorWithAlphaComponent:0.1];
    }
    return _thirdWaveColor;
}

@end
