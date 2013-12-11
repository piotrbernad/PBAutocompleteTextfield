//
//  PBACTextField.m
//  PBAutoCompleteTextField
//
//  Created by Piotr Bernad on 11.12.2013.
//  Copyright (c) 2013 Piotr Bernad. All rights reserved.
//

#import "PBACTextField.h"

@interface PBACTextField() <UITextFieldDelegate>
@property (nonatomic, strong) UILabel *autoCompleteLabel;
@property (nonatomic, strong) NSString *autoCompletePart;
@end

@implementation PBACTextField

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setDelegate:self];
    [self setCaseSensitive:NO];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (_autoCompletePart && ![_autoCompletePart isEqualToString:@""] && [string isEqualToString:@" "]) {
        
        NSString *currentText = textField.text;
        [self setText:[currentText stringByAppendingString:_autoCompletePart]];
        
        [_autoCompleteLabel removeFromSuperview];
        _autoCompleteLabel = nil;
        _autoCompletePart = nil;
        
        return NO;
    }
    
    NSString *futureText = [self.text stringByReplacingCharactersInRange:range withString:string];
    NSString *autocompletePart = [self stringToAutocompleteCurrentText:futureText];
    
    CGSize futureSize = [futureText sizeWithAttributes:@{NSFontAttributeName:self.font}];
    
    [self.autoCompleteLabel removeFromSuperview];
    [self.autoCompleteLabel setText:autocompletePart];
    [self.autoCompleteLabel setFrame:CGRectMake(futureSize.width, -3.0f, CGRectGetWidth(self.bounds) - futureSize.width, CGRectGetHeight(self.bounds))];
    
    [self.textInputView addSubview:self.autoCompleteLabel];
    
    _autoCompletePart = autocompletePart;
    

    if ([_textDelegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
        [_textDelegate textField:textField shouldChangeCharactersInRange:range replacementString:string];
    }
    
    return YES;
}

- (UILabel *)autoCompleteLabel {
    if (!_autoCompleteLabel) {
        _autoCompleteLabel = [[UILabel alloc] init];
        [_autoCompleteLabel setTextColor: self.autoCompleteTextColor ?:[UIColor lightGrayColor]];
        [_autoCompleteLabel setBackgroundColor:[UIColor clearColor]];
        [_autoCompleteLabel setTextAlignment:NSTextAlignmentLeft];
        [_autoCompleteLabel setFont:self.font];
    }
    return _autoCompleteLabel;
}

- (NSString *)stringToAutocompleteCurrentText:(NSString *)currentText {
    
    
    NSRange range = NSMakeRange(0, currentText.length);
    
    for (NSString *s in self.autoCompleteValues) {
        NSRange foundRange = _caseSensitive ? [s rangeOfString:currentText] : [[s lowercaseString] rangeOfString:[currentText lowercaseString]];
        if (NSEqualRanges(range, foundRange)) {
            return [s stringByReplacingCharactersInRange:foundRange withString:@""];
        }
    }
    
    return @"";
}

#pragma mark - Unused UITextField protocol methods 


- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if ([_textDelegate respondsToSelector:@selector(textFieldDidBeginEditing:)]) {
        [_textDelegate textFieldDidBeginEditing:textField];
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if ([_textDelegate respondsToSelector:@selector(textFieldShouldBeginEditing:)]) {
        [_textDelegate textFieldShouldBeginEditing:textField];
    }
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    if ([_textDelegate respondsToSelector:@selector(textFieldShouldEndEditing:)]) {
        return [_textDelegate textFieldShouldEndEditing:textField];
    }
    return NO;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if ([_textDelegate respondsToSelector:@selector(textFieldDidEndEditing:)]) {
       return [_textDelegate textFieldDidEndEditing:textField];
    }
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    if ([_textDelegate respondsToSelector:@selector(textFieldShouldClear:)]) {
        return [_textDelegate textFieldShouldClear:textField];
    }
    return NO;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([_textDelegate respondsToSelector:@selector(textFieldShouldReturn:)]) {
        [_textDelegate textFieldShouldReturn:textField];
    }
    return YES;
}


@end