//
//  UITableView.swift
//  ResumeMaker
//
//  Created by Narender Kumar on 29/04/2022.
//


import UIKit

extension UITableView {
    
    func exportAsPDF(view: UIView, path: String) -> URL? {
        let priorBounds = bounds
        
        let fittedSize = sizeThatFits(
            CGSize(
                width: priorBounds.size.width,
                height: contentSize.height
            )
        )
        
        bounds = CGRect(
            x: 0,
            y: 0,
            width: fittedSize.width,
            height: fittedSize.height
        )
        
        let pdfPageBounds = CGRect(
            x :0,
            y: 0,
            width: frame.width,
            height: view.frame.height
        )
        
        let pdfData = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData, pdfPageBounds, nil)
        
        var pageOriginY: CGFloat = 0
        while pageOriginY < fittedSize.height {
            UIGraphicsBeginPDFPageWithInfo(pdfPageBounds, nil)
            UIGraphicsGetCurrentContext()!.saveGState()
            UIGraphicsGetCurrentContext()!.translateBy(x: 0, y: -pageOriginY)
            layer.render(in: UIGraphicsGetCurrentContext()!)
            UIGraphicsGetCurrentContext()!.restoreGState()
            pageOriginY += pdfPageBounds.size.height
            contentOffset = CGPoint(x: 0, y: pageOriginY)
        }
        UIGraphicsEndPDFContext()
        
        bounds = priorBounds
        return savePDF(path: path, data: pdfData)
    }
    
    private func savePDF(path: String, data: NSMutableData) -> URL? {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectoryURL = urls[0]
        let pdfURL = documentDirectoryURL.appendingPathComponent(path)
        if data.write(to: pdfURL, atomically: true) {
            return pdfURL
        } else {
            return nil
        }
    }
}
