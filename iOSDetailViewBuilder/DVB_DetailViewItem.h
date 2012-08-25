//
//  DVB_DetailViewItem.h
//  iOSDetailViewBuilder
//
//  Created by Marc Kurtz on 6/26/11.
//  Copyright 2011 Kurtz Consulting Services LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kLabelTag           1
#define kTextFieldTag       2
#define kButtonTag          3
#define kActivityIndicator  4
#define kSwitchTag          5
#define kImageViewTag       6

typedef void(^BlockAction)(void);
typedef void(^BooleanParameterAction)(BOOL);
typedef void(^CellBlock)(UITableViewCell* cell);

@class DVB_DetailViewBuilder, DVB_DetailViewDataManager;

@interface DVB_DetailViewItem : NSObject {
    
}

@property (nonatomic, strong) DVB_DetailViewDataManager* dataManager;
@property (nonatomic, strong) NSString* label;
@property (nonatomic, strong) NSString* key;
@property (nonatomic, strong) UITableViewController* tableViewController;
@property (nonatomic, strong) DVB_DetailViewBuilder* builder;
@property (nonatomic, copy) BlockAction onSelectCell;
@property (nonatomic, copy) CellBlock onConfigureCell;
@property (nonatomic, copy) CellBlock onCellCreated;

- (id)initWithLabel:(NSString *)labelString
    withDataManager:(DVB_DetailViewDataManager*) dataManager
            withKey:(NSString*) key
     withController:(UITableViewController*) controller
        withBuilder:(DVB_DetailViewBuilder*) builder;

- (CGFloat) height;

- (NSString*) cellIdentifier;
- (UITableViewCell*) createCell;
- (void) cellCreated:(UITableViewCell*) cell;
- (void) configureCell:(UITableViewCell*) cell;
- (void) didSelectCell:(NSIndexPath*)indexPath;
- (void) requestEndEditing;

- (UITableViewCell*) createStockCellWithDelegate:(id<UITextViewDelegate>) delegate isEditable:(BOOL) editable;
@end
