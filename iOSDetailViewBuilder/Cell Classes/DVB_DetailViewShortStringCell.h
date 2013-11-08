//
//  DVB_DetailViewShortStringCell.h
//  iOSDetailViewBuilder
//
//  Copyright 2013 Kurtz Consulting Services LLC. All rights reserved.
//

#import "DVB_DetailViewItem.h"
#import <UIKit/UIKit.h>

@class DVB_DetailViewDataManager, DVB_DetailViewBuilder;

@interface DVB_DetailViewShortStringCell : DVB_DetailViewItem<UITextFieldDelegate>
{
    CGFloat _cellHeight;
}

- (id)initWithLabel:(NSString *) labelString
    withDataManager:(DVB_DetailViewDataManager*) dataManager
            withKey:(NSString*) key
     withController:(UITableViewController*) controller
        withBuilder:(DVB_DetailViewBuilder*) builder;

@property (nonatomic) UITextAutocapitalizationType autocapitalizationType;
@property (nonatomic) UITextAutocorrectionType autocorrectionType;
@property (nonatomic) BOOL enablesReturnKeyAutomatically;
@property (nonatomic) UIKeyboardAppearance keyboardAppearance;
@property (nonatomic) UIKeyboardType keyboardType;
@property (nonatomic) UIReturnKeyType returnKeyType;
@property (nonatomic, getter=isSecureTextEntry) BOOL secureTextEntry;
@property (nonatomic) UITextSpellCheckingType spellCheckingType;
@property (nonatomic, copy) void(^onTextChanged)(NSString*);

@end
