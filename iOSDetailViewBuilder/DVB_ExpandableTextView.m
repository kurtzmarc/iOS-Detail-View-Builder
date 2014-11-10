//
//  Copyright 2013 Kurtz Consulting Services LLC.
//

#import "DVB_ExpandableTextView.h"

@implementation DVB_ExpandableTextView

@synthesize onContentSizeChanged = _onContentSizeChanged;

- (UIEdgeInsets) contentInset { return UIEdgeInsetsZero; }

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self addObserver:self forKeyPath:@"contentSize" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld) context:nil];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addObserver:self forKeyPath:@"contentSize" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld) context:nil];
    }
    return self;
}

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"contentSize"];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"contentSize"])
    {
        CGSize newSize = [[change objectForKey:NSKeyValueChangeNewKey] CGSizeValue];
        CGSize oldSize = [[change objectForKey:NSKeyValueChangeOldKey] CGSizeValue];
        UITextView* textView = (UITextView*)object;
        if (!CGSizeEqualToSize(newSize, oldSize))
        {
            if (self.onContentSizeChanged)
                self.onContentSizeChanged(textView);
        }
    }
}

@end
