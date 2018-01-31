//
//  LHCalendarViewLayout.m
//  LHCalendar
//
//  Created by lh on 17/1/9.
//  Copyright © 2017年 lh. All rights reserved.
//

#import "LHCalendarViewLayout.h"

@implementation LHCalendarViewLayout
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.headerReferenceSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 70);//头部视图的框架大小
        self.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width/7, [UIScreen mainScreen].bounds.size.width/7);//每个cell的大小
        self.sectionInset = UIEdgeInsetsMake([UIScreen mainScreen].bounds.size.width/14, 0, [UIScreen mainScreen].bounds.size.width/14, 0);//网格视图的/上/左/下/右,的边距
        self.minimumLineSpacing = [UIScreen mainScreen].bounds.size.width/14;//每列的最小间距
        self.minimumInteritemSpacing = 0;//每行的最小间距
        
    }
    return self;
}

- (NSArray *) layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray *superArray = [[super layoutAttributesForElementsInRect:rect] mutableCopy];
    
    NSMutableIndexSet *noneHeaderSections = [NSMutableIndexSet indexSet];
    for (UICollectionViewLayoutAttributes *attributes in superArray)
    {
        if (attributes.representedElementCategory == UICollectionElementCategoryCell)
        {
            [noneHeaderSections addIndex:attributes.indexPath.section];
        }
    }
    
    for (UICollectionViewLayoutAttributes *attributes in superArray)
    {
        if ([attributes.representedElementKind isEqualToString:UICollectionElementKindSectionHeader])
        {
            [noneHeaderSections removeIndex:attributes.indexPath.section];
        }
    }

    [noneHeaderSections enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop){
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:idx];

        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:indexPath];
        
        if (attributes)
        {
            [superArray addObject:attributes];
        }
    }];
    

    for (UICollectionViewLayoutAttributes *attributes in superArray) {
        
        if ([attributes.representedElementKind isEqualToString:UICollectionElementKindSectionHeader])
        {
            NSInteger numberOfItemsInSection = [self.collectionView numberOfItemsInSection:attributes.indexPath.section];
            NSIndexPath *firstItemIndexPath = [NSIndexPath indexPathForItem:0 inSection:attributes.indexPath.section];
            NSIndexPath *lastItemIndexPath = [NSIndexPath indexPathForItem:MAX(0, numberOfItemsInSection-1) inSection:attributes.indexPath.section];
            UICollectionViewLayoutAttributes *firstItemAttributes, *lastItemAttributes;
            if (numberOfItemsInSection>0)
            {
                firstItemAttributes = [self layoutAttributesForItemAtIndexPath:firstItemIndexPath];
                lastItemAttributes = [self layoutAttributesForItemAtIndexPath:lastItemIndexPath];
            }else
            {
                firstItemAttributes = [UICollectionViewLayoutAttributes new];
                CGFloat y = CGRectGetMaxY(attributes.frame)+self.sectionInset.top;
                firstItemAttributes.frame = CGRectMake(0, y, 0, 0);
                lastItemAttributes = firstItemAttributes;
            }
            
            CGRect rect = attributes.frame;
            
            CGFloat offset = self.collectionView.contentOffset.y ;

            CGFloat headerY = firstItemAttributes.frame.origin.y - rect.size.height - self.sectionInset.top;
            
            CGFloat maxY = MAX(offset,headerY);
            
            CGFloat headerMissingY = CGRectGetMaxY(lastItemAttributes.frame) + self.sectionInset.bottom - rect.size.height;
            rect.origin.y = MIN(maxY,headerMissingY);
            attributes.frame = rect;
            
            attributes.zIndex = 1024;
        }
    }
    return [superArray copy];;
}
- (BOOL) shouldInvalidateLayoutForBoundsChange:(CGRect)newBound {
    return YES;
}

@end
