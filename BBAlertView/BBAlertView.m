//
// BBAlertView.m
//
// Copyright (c) 2012 Alessandro Calzavara
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

#import "BBAlertView.h"

@interface BBAlertView () <UIAlertViewDelegate>
@property (strong, nonatomic) UIAlertView *                 alerView;
@property (strong, nonatomic) NSString *                    alertTitle;
@property (strong, nonatomic) NSString *                    alertMessage;
@property (strong, nonatomic) NSString *                    cancelButtonTitle;
@property (strong, nonatomic) BBAlertViewButtonClickBlock   cancelButtonBlock;
@property (strong, nonatomic) NSMutableArray *              otherButtonsTitles;
@property (strong, nonatomic) NSMutableArray *              otherButtonsBlocks;
@end

static BBAlertView * currentAlertView = nil;

@implementation BBAlertView

#pragma mark - init

+ (BBAlertView *)alertWithTitle:(NSString *)title message:(NSString *)message
{
    return [[BBAlertView alloc] initWithTitle:title message:message];
}

- (id)initWithTitle:(NSString *)title message:(NSString *)message
{
    self = [super init];
    if (self)
    {
        self.alertTitle = title;
        self.alertMessage = message;
        
        self.otherButtonsBlocks = [NSMutableArray array];
        self.otherButtonsTitles = [NSMutableArray array];
    }
    
    return self;
}

////////////////////////////////////////////////////////////////////////////////
#pragma mark - Public API

- (void)addButtonWithTitle:(NSString *)title onTapDo:(BBAlertViewButtonClickBlock)block
{
    [self.otherButtonsTitles addObject:title];
    
    [self.otherButtonsBlocks addObject:(block != NULL) ? [block copy] : [NSNull null]];
}

- (void)setCancelButtonWithTitle:(NSString *)title onTapDo:(BBAlertViewButtonClickBlock)block
{
    self.cancelButtonTitle = title;
    
    self.cancelButtonBlock = (block != NULL) ? [block copy] : [NSNull null];
}

- (void)show
{
    currentAlertView = self; // keep it alive
    
    self.alerView = [[UIAlertView alloc] initWithTitle:self.alertTitle
                                               message:self.alertMessage
                                              delegate:self
                                     cancelButtonTitle:self.cancelButtonTitle
                                     otherButtonTitles:nil];

    [self.otherButtonsTitles enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        [self.alerView addButtonWithTitle:obj];
        
    }];
    
    [self.alerView show];
}

- (void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex animated:(BOOL)animated
{
    [self.alerView dismissWithClickedButtonIndex:buttonIndex animated:animated];
}

////////////////////////////////////////////////////////////////////////////////
#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSInteger realIndex = buttonIndex + ((self.cancelButtonTitle != nil) ? -1 : 0);
    
    if (realIndex == -1) // cancel button clicked
    {
        self.cancelButtonBlock();
    }
    else if (realIndex < [self.otherButtonsTitles count])
    {
        BBAlertViewButtonClickBlock block = self.otherButtonsBlocks[realIndex];
        block();
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    currentAlertView = nil; // it can be deallocated now
}

@end
