//
//  Copyright 2013 Kurtz Consulting Services LLC.
//

#import <UIKit/UIKit.h>

@interface DVB_ExpandableTextView : UITextView

@property (nonatomic, copy) void (^onContentSizeChanged)(UITextView*);

@end
