///
/// ImageProcessing.swift
///

import QuartzCore
import UIKit


func cropBottom(image: UIImage, width: CGFloat) -> UIImage {
    let rect = CGRect(x: 0, y: 0, width: width, height: width)
    let imageRef = image.cgImage!.cropping(to: rect)!
    let croppedImage = UIImage(cgImage:imageRef)
    return croppedImage
}

func cropCircle(image: UIImage, radius: Float) -> UIImage {
    let imageView: UIImageView = UIImageView(image: image)
    var layer: CALayer = CALayer()
    layer = imageView.layer
    
    layer.masksToBounds = true
    layer.cornerRadius = CGFloat(radius)
    
    UIGraphicsBeginImageContext(imageView.bounds.size)
    layer.render(in: UIGraphicsGetCurrentContext()!)
    let roundedImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return roundedImage!
}
