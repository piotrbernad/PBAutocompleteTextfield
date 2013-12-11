//
//  PBACTextField.h
//  PBAutoCompleteTextField
//
//  Created by Piotr Bernad on 11.12.2013.
//  Copyright (c) 2013 Piotr Bernad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PBACTextField : UITextField

/**
 *  Property that holds set of NSString objects, which will be used to autocomplete text. You can sort array to determinate which values will prompt first.
 */
@property (nonatomic, strong) NSArray *autoCompleteValues;

/**
 *  To disabled/enabled autocomplete set this property
 */
@property (nonatomic, assign, getter = isAutoCompleteEnabled) BOOL autoCompleteEnabled;

/**
 *  Weak refrence to UITextFieldDelegate. Beacause of this class uses 'delegate' which is declared in UITextField class, set this property instead of classic delegate to handle UITextFieldDelegate protocol methods and hold autocomplete functionality. If you dont have to try to not override textField:shouldChangeCharactersInRange:replacementString: method.
 */
@property (nonatomic, weak) id <UITextFieldDelegate> textDelegate;

/**
 *  AutoComplete Text color.
 */
@property (nonatomic, strong) UIColor *autoCompleteTextColor;

/**
 *  Set to YES, to search in autoCompleteValues caseSensitive. Default is set to NO.
 */
@property (nonatomic, assign) BOOL caseSensitive;
@end