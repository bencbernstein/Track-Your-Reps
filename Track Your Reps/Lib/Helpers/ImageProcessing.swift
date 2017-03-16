///
/// ImageProcessing.swift
///

import QuartzCore
import UIKit


func cropCircularImage(for member: CongressMember) -> UIImage? {
    guard let memberImage = UIImage(named: member.id) else { return nil }
    let imageWidth = CGFloat(memberImage.size.width)
    // Crop from the bottom, because the face is in the upper half
    let square = cropBottom(image: memberImage, width: imageWidth)
    let radius = Float(imageWidth) / 2
    let circle = cropCircle(for: member, image: square, radius: radius)
    return circle
}

func cropBottom(image: UIImage, width: CGFloat) -> UIImage {
    let rect = CGRect(x: 0, y: 0, width: width, height: width)
    let imageRef = image.cgImage!.cropping(to: rect)!
    let croppedImage = UIImage(cgImage:imageRef)
    return croppedImage
}

func cropCircle(for member: CongressMember, image: UIImage, radius: Float) -> UIImage {
    let imageView: UIImageView = UIImageView(image: image)
    var layer: CALayer = CALayer()
    layer = imageView.layer
    
    layer.masksToBounds = true
    layer.cornerRadius = CGFloat(radius)
    
    // TODO: make border width proportional to radius, or make it an 'absolute value' that doesn't scale with image radius
    layer.borderWidth = 5
    layer.borderColor = member.partyColor().cgColor
    
    UIGraphicsBeginImageContext(imageView.bounds.size)
    layer.render(in: UIGraphicsGetCurrentContext()!)
    let roundedImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return roundedImage!
}

func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
    
    let scale = newWidth / image.size.width
    let newHeight = image.size.height * scale
    UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
    image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return newImage!
}
