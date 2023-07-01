//
//  SPOCTestViewController.h
//  SwiftProject
//
//  Created by flowerflower on 2022/11/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SPOCTestViewController : UIViewController

@end
typedef enum{
 VerticalAlignmentTop = 0, // default
 VerticalAlignmentMiddle,
 VerticalAlignmentBottom,
} VerticalAlignment;
@interface myUILabel : UILabel
{
@private
VerticalAlignment _verticalAlignment;
}
@property (nonatomic) VerticalAlignment verticalAlignment;

@end


NS_ASSUME_NONNULL_END
