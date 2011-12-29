//
//  DVB_DetailViewBuilder.h
//  Face Charts
//
//  Created by Marc Kurtz on 12/30/11.
//  Copyright 2011 Kurtz Consulting Services LLC. All rights reserved.
//

@class DVB_DetailViewGroup;
@class DVB_DetailViewItem;

@interface DVB_DetailViewBuilder : NSObject {
    NSMutableArray* _groupArray;
}

@property (nonatomic, strong) NSMutableArray* groupArray;

- (void) addDetailViewBuilderGroup:(DVB_DetailViewGroup*) detailViewBuilderGroup;
- (NSInteger) groupCount;
- (NSInteger) groupItemCount:(NSUInteger)section;
- (NSObject*) valueForIndexPath:(NSIndexPath*) index;
- (DVB_DetailViewItem*) itemForIndexPath:(NSIndexPath*) index;
- (NSString*) groupTitleForSection:(NSUInteger) section;
- (CGFloat) heightForIndexPath:(NSIndexPath *)indexPath;
- (NSIndexPath*) indexPathForItem:(DVB_DetailViewItem*) item;
- (void) requestEndEditing;
@end
