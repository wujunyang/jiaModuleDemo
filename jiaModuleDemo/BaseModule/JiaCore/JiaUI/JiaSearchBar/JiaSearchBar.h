//
//  JiaSearchBar.h
//  jiaModuleDemo
//
//  Created by wujunyang on 16/10/11.
//  Copyright © 2016年 wujunyang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, JiaSearchBarIconAlign) {
    JiaSearchBarIconAlignLeft,
    JiaSearchBarIconAlignCenter
};
@class JiaSearchBar;
@protocol JiaSearchBarDelegate <UIBarPositioningDelegate>

@optional

-(BOOL)searchBarShouldBeginEditing:(JiaSearchBar *)searchBar;                      // return NO to not become first responder
- (void)searchBarTextDidBeginEditing:(JiaSearchBar *)searchBar;                     // called when text starts editing
- (BOOL)searchBarShouldEndEditing:(JiaSearchBar *)searchBar;                        // return NO to not resign first responder
- (void)searchBarTextDidEndEditing:(JiaSearchBar *)searchBar;                       // called when text ends editing
- (void)searchBar:(JiaSearchBar *)searchBar textDidChange:(NSString *)searchText;   // called when text changes (including clear)
- (BOOL)searchBar:(JiaSearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text; // called before text changes

- (void)searchBarSearchButtonClicked:(JiaSearchBar *)searchBar;                     // called when keyboard search button pressed
- (void)searchBarCancelButtonClicked:(JiaSearchBar *)searchBar;                     // called when cancel button pressed
// called when cancel button pressed
@end


@interface JiaSearchBar :  UIView<UITextInputTraits>

@property(nonatomic,assign) id<JiaSearchBarDelegate> delegate;              // weak reference. default is nil
@property(nonatomic,copy)   NSString               *text;                  // current/starting search text
@property(nonatomic,retain) UIColor                *textColor;
@property(nonatomic,retain) UIFont                 *textFont;
@property(nonatomic,copy)   NSString               *placeholder;           // default is nil
@property(nonatomic,retain) UIColor                *placeholderColor;
@property(nonatomic,retain) UIImage                *iconImage;
@property(nonatomic,retain) UIImage                *backgroundImage;

@property(nonatomic,retain) UIButton *cancelButton; //lazy


@property(nonatomic,assign) UITextBorderStyle       textBorderStyle;
@property(nonatomic)        UIKeyboardType          keyboardType;
@property(nonatomic)        JiaSearchBarIconAlign    iconAlign;     //text aligh model


@property (nonatomic, readwrite, retain) UIView *inputAccessoryView;
@property (nonatomic, readwrite, retain) UIView *inputView;

-(BOOL)resignFirstResponder;
-(void)setAutoCapitalizationMode:(UITextAutocapitalizationType)type;

@end
