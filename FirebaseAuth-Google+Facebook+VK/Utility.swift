//
//  Utility.swift
//  MyDok
//
//  Created by User1 on 20.09.17.
//  Copyright © 2017 User1. All rights reserved.
//

import Foundation
import UIKit
//import Firebase





//func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage? {
//    
//    let scale = newWidth / image.size.width
//    let newHeight = image.size.height * scale
//    UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
//    image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
//    
//    let newImage = UIGraphicsGetImageFromCurrentImageContext()
//    UIGraphicsEndImageContext()
//    
//    return newImage
//}
//


//// IMG -> String
//func codedImg(img: UIImage)->String{
//    
//    guard let image = resizeImage(image: img , newWidth: 400) else { return ""}
//
//  
//    //сжатие картинки
//    guard let data = UIImageJPEGRepresentation(image,0.8) else {return ""}
//    
//        let base64String = data.base64EncodedString(options: NSData.Base64EncodingOptions.lineLength64Characters)
//    return base64String
//}
// //String -> IMG
//func decodeImg(stringImage : String )->UIImage {
//    
//    if stringImage != "" {
//        guard let decodedData = Data(base64Encoded: stringImage, options: NSData.Base64DecodingOptions.ignoreUnknownCharacters)
//            else {return  #imageLiteral(resourceName: "emptyPixel") }//logo
//        
//        let decodedImage = UIImage(data: decodedData)
//        return decodedImage!
//        
//    }else {return #imageLiteral(resourceName: "emptyPixel")}
//}





//    func createPDF(htmlData : String)->String {
//       // let html = "\(convertDataInHtml())"    //"<b>Hello\(nameOfPD) <i>World!</i></b> \(convertDataInHtml())<p>Generate PDF file from HTML in Swift</p>"
//        let fmt = UIMarkupTextPrintFormatter(markupText: htmlData)
//
//        // 2. Assign print formatter to UIPrintPageRenderer
//
//        let render = UIPrintPageRenderer()
//        render.addPrintFormatter(fmt, startingAtPageAt: 0)
//
//        // 3. Assign paperRect and printableRect
//
//        let page = CGRect(x: 0, y: 0, width: 595.2, height:841.8) //841.8) // A4, 72 dpi
//        let printable = page.insetBy(dx: 0, dy: 0)
//
//        render.setValue(NSValue(cgRect: page), forKey: "paperRect")
//        render.setValue(NSValue(cgRect: printable), forKey: "printableRect")
//
//        // 4. Create PDF context and draw
//
//        let pdfData = NSMutableData()
//          let rect = CGRect.zero
//        UIGraphicsBeginPDFContextToData(pdfData ,rect, nil)
//
//        for i in 1...render.numberOfPages {
//
//            UIGraphicsBeginPDFPage();
//            let bounds = UIGraphicsGetPDFContextBounds()
//           render.drawPage(at: i - 1, in: bounds)
//            
//            
//            
//            

            
//            // Draw existing page
//            (bounds as! CGContext).saveGState();
//            (bounds as! CGContext).scaleBy(x: 1, y: -1);
//            (bounds as! CGContext).translateBy(x: 0, y: page.size.height);
//            (bounds as! CGContext).drawPDFPage(page as! CGPDFPage);
//            (bounds as! CGContext).restoreGState();
            
//            // Draw image on top of page
//            let image = UIImage(named: "logo1")
//            
//         //   image?.draw(in: CGRectMake(100, 100, 100, 100))
//      // image?.draw(at: CGPoint(x: 100, y: 100))
//        image?.draw(in: CGRect(x: 200, y: 100, width: 200, height: 200), blendMode: CGBlendMode(rawValue: 1)!, alpha: 0.3)
//            // Draw red box on top of page
//            //UIColor.redColor().set()
//            //UIRectFill(CGRectMake(20, 20, 100, 100));
//            
//        }
//
//        UIGraphicsEndPDFContext();
//
//        // 5. Save PDF file
//
//        var documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
//     // documentsPath = "/Users/user1/Desktop/proj"
//        pdfData.write(toFile: "\(documentsPath)/1111.pdf", atomically: true)
//      //   print("saved success\(documentsPath)")
//        return "\(documentsPath)/file.pdf"
//    }



//func startActivityIndicator(viewController: UIViewController) {
//    AppDelegate.activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
//    AppDelegate.activityIndicator.center = viewController.view.center
//    AppDelegate.activityIndicator.hidesWhenStopped = true
//    AppDelegate.activityIndicator.activityIndicatorViewStyle = .gray
//    viewController.view.addSubview(AppDelegate.activityIndicator)
//    AppDelegate.activityIndicator.startAnimating()
//}
//func stopActivityIndicator() {
//    AppDelegate.activityIndicator.stopAnimating()
//    UIApplication.shared.endIgnoringInteractionEvents()
//}






func isValidEmailAddress(emailAddressString: String) -> Bool {
    
    var returnValue = true
    let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
    
    do {
        let regex = try NSRegularExpression(pattern: emailRegEx)
        let nsString = emailAddressString as NSString
        let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))
        
        if results.count == 0
        {
            returnValue = false
        }
        
    } catch let error as NSError {
        print("invalid regex: \(error.localizedDescription)")
        returnValue = false
    }
    
    return  returnValue
}





//func dateNow(needTime : Bool)->String{
//    let date = NSDate()
//    let dateFormatter = DateFormatter()
//    if needTime{
//        dateFormatter.dateFormat = "MM-dd-yyyy hh:mm"
//    }else{
//        dateFormatter.dateFormat = "yyyy.MM.dd"
//    }
//    
//    let dateString = dateFormatter.string(from: date as Date)
//    //  print("Custom date format Sample 1 =  \(dateString)")
//    //Custom date format Sample 1 =  02-28-2016 11:41
//    // print("\(dateString)")
//    
//    return dateString
//}


////фонт для html
//func applyTraitsFromFont(_ f1: UIFont, to f2: UIFont) -> UIFont? {
//    let t = f1.fontDescriptor.symbolicTraits
//    if let fd = f2.fontDescriptor.withSymbolicTraits(t) {
//        return UIFont.init(descriptor: fd, size: 0)
//    }
//    return nil
//}//фонт для html end
//



func displayAlertMessage(messageToDisplay: String, viewController: UIViewController){
    let alertController = UIAlertController(title: "", message: messageToDisplay, preferredStyle: .alert)
    let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
           }
    alertController.addAction(OKAction)
    viewController.present(alertController, animated: true, completion:nil)
}

func displayActionSheet(_ viewController: UIViewController,_ acceptOkB: UIButton){
//    let myMutableUserAgreement = NSMutableAttributedString(
//        string: userAgreement,
//        attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 18.0)!])
//    
//    let userAgree = myMutableUserAgreement as String!
//    
    
    
    let myActionSheet = UIAlertController(title: "Пользовательское соглашение", message: userAgreement, preferredStyle: .actionSheet)
    
        //let margin:CGFloat = 8.0
    //let rect1 = CGRect(x: viewController.view.bounds.width - 300, y: viewController.view.bounds.height - 300, width: 100.0, height: 100.0)
    //let rect = CGRect(x: margin, y: margin, width: 100.0, height: 100.0)
    //var tableView = UITableView(frame: rect1)
    //tableView.delegate = self
    //tableView.dataSource = self
    //tableView.backgroundColor = UIColor.green
   // myActionSheet.view.addSubview(tableView)
    
    
    
    
    let acceptButton = UIAlertAction(title: "Я согласен", style: .default){
        (action: UIAlertAction) in
        acceptOkB.alpha = 0
        print("Согласен")
    }
    
    let cancelButton = UIAlertAction(title: "Не принимаю условия", style: .cancel)
    {
        (action: UIAlertAction) in
        acceptOkB.alpha = 1
        print("Не согласен")
    }
    
    myActionSheet.addAction(acceptButton)
    myActionSheet.addAction(cancelButton)
    
    viewController.present(myActionSheet, animated: true, completion:nil)
}




//func gettingHelpName (helpNameForSearch: String)-> String {
//    let folderURL = URL(fileURLWithPath: Bundle.main.resourcePath!)
//    var helpName = String()
//    do
//    {
//        let helpPath = try FileManager.default.contentsOfDirectory(at: folderURL, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
//        for help in helpPath
//        {
//            var myHelp = help.absoluteString
//            
//            
//            
//            if myHelp.contains(helpNameForSearch)
//            {
//                let findString = myHelp.components(separatedBy: "/")
//                myHelp = findString[findString.count-1]
//                helpName = myHelp.replacingOccurrences(of: "%20", with: " ")
//                
//                //print(mySong)
//                //songsName.append(mySong)
//            }
//        }
//        
//    } catch
//    {
//       
//    }
//    return helpName
//}


let userAgreement: String = "----------"
