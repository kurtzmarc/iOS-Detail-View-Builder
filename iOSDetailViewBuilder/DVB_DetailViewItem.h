//
//  Copyright 2013 Kurtz Consulting Services LLC.
//

#import <UIKit/UIKit.h>

#define kLabelTag           1
#define kTextFieldTag       2
#define kButtonTag          3
#define kActivityIndicator  4
#define kSwitchTag          5
#define kImageViewTag       6

#define GROUPED_CELL_WIDTH 300
#define CELL_PADDING 5

@class DVB_DetailViewBuilder, DVB_DetailViewDataManager;

@interface DVB_DetailViewItem : NSObject {
    
}

@property (nonatomic, strong) DVB_DetailViewDataManager* dataManager;
@property (nonatomic, strong) NSString* label;
@property (nonatomic, strong) NSString* key;
@property (nonatomic, strong) UITableViewController* tableViewController;
@property (nonatomic, strong) DVB_DetailViewBuilder* builder;
@property (nonatomic, copy) void(^onSelectCell)();
@property (nonatomic, copy) void(^onConfigureCell)(UITableViewCell*);
@property (nonatomic, copy) void(^onCellCreated)(UITableViewCell*);

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

- (UITableViewCell*) createStockCell;
@end
