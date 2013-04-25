//
//  ViewController.m
//  LayerCake
//
//  Created by T. Andrew Binkowski on 4/24/13.
//  Copyright (c) 2013 T. Andrew Binkowski. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) NSArray *colors;
@end

@implementation ViewController

/*******************************************************************************
 * @method          viewDidLoad
 * @abstract
 * @description         
 *******************************************************************************/
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _colors = [NSArray arrayWithObjects:
                              [UIColor redColor],
                              [UIColor greenColor],
                              [UIColor blueColor],
                              [UIColor yellowColor],
                              [UIColor magentaColor],
                              [UIColor cyanColor],
                              [UIColor orangeColor],
                              [UIColor purpleColor],
                              [UIColor brownColor],
                              [UIColor whiteColor],
                              [UIColor lightGrayColor],
                              [UIColor darkGrayColor],
                              [UIColor blackColor],
                              nil];
}

/*******************************************************************************
 * @method          viewDidAppear:
 * @abstract
 * @description
 *******************************************************************************/
- (void)viewDidAppear:(BOOL)animated {

    // Color main view's layer
    self.view.layer.backgroundColor = [UIColor lightGrayColor].CGColor;

    // Add a sublayer to the view's layer
    CALayer *sublayer = [CALayer layer];
    sublayer.backgroundColor = [UIColor grayColor].CGColor;
    sublayer.frame = CGRectInset(self.view.frame, 10, 10);
    sublayer.cornerRadius = 10.0f;
    [self.view.layer addSublayer:sublayer];
    
    // Add a pattern of sublayers to the view's layer
    CALayer *sublayer2;
    for (int i = 0; i < self.colors.count; i++) {
        sublayer2 = [CALayer layer];
        UIColor *color = self.colors[i];
        sublayer2.backgroundColor = color.CGColor;
        sublayer2.frame = CGRectInset(self.view.frame, 10*i, 10*i);
        sublayer2.cornerRadius = i*10.0f;
        [self.view.layer addSublayer:sublayer2];
    }

    // Add a shadow to pretty up the red square
    //[self dressUpRedSquare];

    // Add an icon
    CALayer *icon = [CALayer layer];
    icon.frame = CGRectMake(0, 0, 200, 200);
    icon.position = self.view.center;
    icon.backgroundColor = [UIColor whiteColor].CGColor;
    icon.contents = (id)[UIImage imageNamed:@"TempleRun.jpeg"].CGImage;
    icon.borderWidth = 5.0f;
    icon.cornerRadius = 30.0f;
    icon.masksToBounds = YES;
    
    // Create the shadow
    CALayer *iconShadow = [CALayer layer];
    iconShadow.shadowColor = [UIColor blackColor].CGColor;
    iconShadow.shadowOpacity = 0.50f;
    iconShadow.shadowOffset = CGSizeMake(0, 10);
    iconShadow.shadowPath = [UIBezierPath bezierPathWithRoundedRect:icon.frame cornerRadius:icon.cornerRadius].CGPath;
    [self.view.layer addSublayer:iconShadow];
    
    [self.view.layer addSublayer:icon];
}

/*******************************************************************************
 * @method          didReceiveMemoryWarning
 * @abstract
 * @description
 *******************************************************************************/
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - View Appearance Methods
/*******************************************************************************
 * @method          dressUpRedSquare
 * @abstract
 * @description
 *******************************************************************************/
- (void)dressUpRedSquare {
    [self.redSquare bringSubviewToFront:self.view];
    CALayer *layer = self.redSquare.layer;
    layer.shadowColor = [[UIColor blackColor] CGColor];
    layer.shadowOffset = CGSizeMake(10, 10);
    layer.shadowRadius = 4.0f;
    layer.shadowOpacity = 0.80f;
    layer.masksToBounds = NO;

    // For performance draw shadow around view path
    layer.shadowPath = [UIBezierPath bezierPathWithRect:self.redSquare.bounds].CGPath;
    
    // Example code for shadows from nachbaur.com/blog/fun-shadow-effects-using-custom-calayer-shadowpaths
    //layer.shadowPath = [self renderRect:self.redSquare];
    //layer.shadowPath = [self renderTrapezoid:self.redSquare];
    //layer.shadowPath = [self renderEllipse:self.redSquare];
    //layer.shadowPath = [self renderPaperCurl:self.redSquare];
}

#pragma mark Shadow Paths
/*******************************************************************************
 * @method          renderRect:
 * @abstract        Render CGPath as rect
 * @description
 *******************************************************************************/
- (CGPathRef)renderRect:(UIView*)imgView {
	UIBezierPath *path = [UIBezierPath bezierPathWithRect:imgView.bounds];
	return path.CGPath;
}

/*******************************************************************************
 * @method          renderRect:
 * @abstract        Render CGPath as rect
 * @description
 *******************************************************************************/
- (CGPathRef)renderTrapezoid:(UIView*)imgView {
	CGSize size = imgView.bounds.size;
	
	UIBezierPath *path = [UIBezierPath bezierPath];
	[path moveToPoint:CGPointMake(size.width * 0.33f, size.height * 0.66f)];
	[path addLineToPoint:CGPointMake(size.width * 0.66f, size.height * 0.66f)];
	[path addLineToPoint:CGPointMake(size.width * 1.15f, size.height * 1.15f)];
	[path addLineToPoint:CGPointMake(size.width * -0.15f, size.height * 1.15f)];
    
	return path.CGPath;
}

/*******************************************************************************
 * @method          renderEllipse
 * @abstract        Render CGPath as ellipse
 * @description
 *******************************************************************************/
- (CGPathRef)renderEllipse:(UIView*)imgView {
	CGSize size = imgView.bounds.size;
	
	CGRect ovalRect = CGRectMake(0.0f, size.height + 5, size.width - 10, 15);
	UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:ovalRect];
	
	return path.CGPath;
}

/*******************************************************************************
 * @method          renderPaperCurl
 * @abstract        Render CGPath as paper curl
 * @description
 *******************************************************************************/
- (CGPathRef)renderPaperCurl:(UIView*)imgView {
	CGSize size = imgView.bounds.size;
	CGFloat curlFactor = 15.0f;
	CGFloat shadowDepth = 5.0f;
    
	UIBezierPath *path = [UIBezierPath bezierPath];
	[path moveToPoint:CGPointMake(0.0f, 0.0f)];
	[path addLineToPoint:CGPointMake(size.width, 0.0f)];
	[path addLineToPoint:CGPointMake(size.width, size.height + shadowDepth)];
	[path addCurveToPoint:CGPointMake(0.0f, size.height + shadowDepth)
			controlPoint1:CGPointMake(size.width - curlFactor, size.height + shadowDepth - curlFactor)
			controlPoint2:CGPointMake(curlFactor, size.height + shadowDepth - curlFactor)];
    
	return path.CGPath;
}



@end
