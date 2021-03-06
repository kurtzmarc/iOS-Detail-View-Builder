//
//  Copyright 2013 Kurtz Consulting Services LLC.
//

#import <UIKit/UIKit.h>

@class DVB_DetailViewGroup;
@class DVB_DetailViewItem;

@interface DVB_DetailViewBuilder : NSObject {
    NSMutableArray* _groupArray;
}

@property (nonatomic, strong) NSMutableArray* groupArray;

- (void) addDetailViewBuilderGroup:(DVB_DetailViewGroup*) detailViewBuilderGroup;
- (void) removeDetailViewItemAtIndexPath:(NSIndexPath*) index;
- (NSInteger) groupCount;
- (NSInteger) groupItemCount:(NSUInteger)section;
- (NSUInteger) indexForGroup:(DVB_DetailViewGroup*)group;
- (NSObject*) valueForIndexPath:(NSIndexPath*) index;
- (DVB_DetailViewItem*) itemForIndexPath:(NSIndexPath*) index;
- (DVB_DetailViewGroup*) groupForSection:(NSInteger) section;
- (NSString*) groupTitleForSection:(NSUInteger) section;
- (CGFloat) heightForIndexPath:(NSIndexPath *)indexPath;
- (NSIndexPath*) indexPathForItem:(DVB_DetailViewItem*) item;
- (void) requestEndEditing;
- (void) updateEditors;
@end
