//
//  Copyright 2013 Kurtz Consulting Services LLC.
//

@class DVB_DetailViewBuilder, DVB_DetailViewItem;

@interface DVB_DetailViewGroup : NSObject {

}

@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSString* footerText;
@property (nonatomic, weak) DVB_DetailViewBuilder* builder;
@property (nonatomic, strong) NSMutableArray* groupItemArray;

- (id)initWithTitle:(NSString *) title withBuilder:(DVB_DetailViewBuilder*) builder;
- (void) addDetailViewItem:(DVB_DetailViewItem*) detailViewItem;
- (void) removeDetailViewItemAtIndex:(NSInteger) index;
- (NSInteger) groupItemCount;
- (DVB_DetailViewItem*) itemForIndex:(NSInteger) index;
- (NSInteger) indexOfItem:(DVB_DetailViewItem*) item;
@end
