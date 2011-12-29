//
//  DVB_DetailViewGroup.h
//  Face Charts
//
//  Created by Marc Kurtz on 6/26/11.
//  Copyright 2011 Kurtz Consulting Services LLC. All rights reserved.
//

@class DVB_DetailViewBuilder, DVB_DetailViewItem;

@interface DVB_DetailViewGroup : NSObject {

}

@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) DVB_DetailViewBuilder* builder;
@property (nonatomic, strong) NSMutableArray* groupItemArray;

- (id)initWithTitle:(NSString *) title withBuilder:(DVB_DetailViewBuilder*) builder;
- (void) addDetailViewItem:(DVB_DetailViewItem*) detailViewItem;
- (NSInteger) groupItemCount;
- (DVB_DetailViewItem*) itemForIndex:(NSInteger) index;
- (NSInteger) indexOfItem:(DVB_DetailViewItem*) item;
@end
