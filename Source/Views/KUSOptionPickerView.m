//
//  KUSOptionPickerView.m
//  Kustomer
//
//  Created by Daniel Amitay on 12/29/17.
//  Copyright © 2017 Kustomer. All rights reserved.
//

#import "KUSOptionPickerView.h"
#import "KUSColor.h"

static const CGFloat kKUSOptionPickerViewMinimumHeight = 50.0;
static const CGFloat kKUSOptionPickerViewButtonPadding = 10.0;
static const CGFloat kKUSOptionPickerViewMinimumButtonHeight = kKUSOptionPickerViewMinimumHeight - kKUSOptionPickerViewButtonPadding * 2.0;
static const CGFloat kKUSOptionPickerViewMinimumButtonWidth = 100.0;

@interface KUSOptionPickerView () {
    UIView *_separatorView;
    UIActivityIndicatorView *_loadingView;

    NSArray<UIButton *> *_optionButtons;
}

@end

@implementation KUSOptionPickerView

#pragma mark - Class methods

+ (void)initialize
{
    if (self == [KUSOptionPickerView class]) {
        KUSOptionPickerView *appearance = [KUSOptionPickerView appearance];
        [appearance setBackgroundColor:[UIColor whiteColor]];
        [appearance setSeparatorColor:[KUSColor lightGrayColor]];
    }
}

#pragma mark - Lifecycle methods

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _separatorView = [[UIView alloc] init];
        _separatorView.userInteractionEnabled = NO;
        [self addSubview:_separatorView];

        _loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _loadingView.hidesWhenStopped = YES;
        [_loadingView startAnimating];
        [self addSubview:_loadingView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    _separatorView.frame = (CGRect) {
        .size.width = self.bounds.size.width,
        .size.height = 1.0
    };

    _loadingView.center = (CGPoint) {
        .x = self.bounds.size.width / 2.0,
        .y = self.bounds.size.height / 2.0
    };

    CGPoint buttonOffset = CGPointMake(kKUSOptionPickerViewButtonPadding, kKUSOptionPickerViewButtonPadding);
    CGFloat previousButtonHeight = 0.0;
    for (UIButton *button in _optionButtons) {
        CGSize buttonSize = [self _sizeForButton:button];
        CGFloat buttonMaxX = buttonOffset.x + buttonSize.width + kKUSOptionPickerViewButtonPadding;

        if (buttonMaxX > self.bounds.size.width) {
            buttonOffset.x = kKUSOptionPickerViewButtonPadding;
            buttonOffset.y += previousButtonHeight + kKUSOptionPickerViewButtonPadding;
        }

        button.frame = (CGRect) {
            .origin = buttonOffset,
            .size = buttonSize
        };
        buttonOffset.x += kKUSOptionPickerViewButtonPadding + buttonSize.width;
        previousButtonHeight = buttonSize.height;
    }
}

#pragma mark - Public methods

- (CGFloat)desiredHeight
{
    CGPoint buttonOffset = CGPointMake(kKUSOptionPickerViewButtonPadding, kKUSOptionPickerViewButtonPadding);
    CGFloat previousButtonHeight = 0.0;
    for (UIButton *button in _optionButtons) {
        CGSize buttonSize = [self _sizeForButton:button];
        CGFloat buttonMaxX = buttonOffset.x + buttonSize.width + kKUSOptionPickerViewButtonPadding;

        if (buttonMaxX > self.bounds.size.width) {
            buttonOffset.x = kKUSOptionPickerViewButtonPadding;
            buttonOffset.y += previousButtonHeight + kKUSOptionPickerViewButtonPadding;
        }
        buttonOffset.x += kKUSOptionPickerViewButtonPadding + buttonSize.width;
        previousButtonHeight = buttonSize.height;
    }
    return MAX(kKUSOptionPickerViewMinimumHeight, buttonOffset.y + previousButtonHeight + kKUSOptionPickerViewButtonPadding);
}

- (void)setOptions:(NSArray<NSString *> *)options
{
    _options = options;
    if (_options.count) {
        [_loadingView stopAnimating];
    } else {
        [_loadingView startAnimating];
    }
    [self _rebuildOptionButtons];
}

#pragma mark - Internal methods

- (CGSize)_sizeForButton:(UIButton *)button
{
    CGSize buttonSize = [button sizeThatFits:button.bounds.size];
    buttonSize.width = MAX(round(buttonSize.width) + kKUSOptionPickerViewButtonPadding * 2.0, kKUSOptionPickerViewMinimumButtonWidth);
    buttonSize.width = MIN(buttonSize.width, self.bounds.size.width - kKUSOptionPickerViewButtonPadding * 2.0);
    buttonSize.height = MAX(round(buttonSize.height) + kKUSOptionPickerViewButtonPadding, kKUSOptionPickerViewMinimumButtonHeight);
    return buttonSize;
}

- (void)_rebuildOptionButtons
{
    for (UIButton *button in _optionButtons) {
        [button removeFromSuperview];
    }

    NSMutableArray<UIButton *> *optionButtons = [[NSMutableArray alloc] initWithCapacity:self.options.count];

    UIColor *buttonColor = [[KUSColor blueColor] colorWithAlphaComponent:0.75];;
    for (NSString *option in self.options) {
        UIButton *button = [[UIButton alloc] init];
        button.backgroundColor = [UIColor colorWithWhite:0.975 alpha:1.0];
        button.layer.cornerRadius = 5.0;
        button.layer.masksToBounds = YES;
        button.layer.borderWidth = 1.0;
        button.layer.borderColor = buttonColor.CGColor;
        button.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [button setTitle:option forState:UIControlStateNormal];
        [button setTitleColor:buttonColor forState:UIControlStateNormal];
        [button addTarget:self action:@selector(_onButtonPress:) forControlEvents:UIControlEventTouchUpInside];
        [optionButtons addObject:button];
        [self addSubview:button];
    }

    _optionButtons = optionButtons;
    [self setNeedsLayout];
}

- (void)_onButtonPress:(UIButton *)button
{
    NSUInteger indexOfButton = [_optionButtons indexOfObject:button];
    if (indexOfButton != NSNotFound) {
        NSString *option = self.options[indexOfButton];
        if ([self.delegate respondsToSelector:@selector(optionPickerView:didSelectOption:)]) {
            [self.delegate optionPickerView:self didSelectOption:option];
        }
    }
}

#pragma mark - UIAppearance methods

- (void)setSeparatorColor:(UIColor *)separatorColor
{
    _separatorColor = separatorColor;
    _separatorView.backgroundColor = _separatorColor;
}

@end