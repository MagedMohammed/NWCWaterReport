//
//  Network.swift
//  NWCWaterReports
//
//  Created by Maged Omar on 8/31/20.
//  Copyright © 2020 NWC. All rights reserved.
//

import Foundation
import RTWebService
import AEXML

/*
 mobileNumber:0557686624
 token: AE180A91AB15DA07E053B978420A89D0
 complaintType:CM_LKGE
 cbu: TCBU
 deviceId: 2707dac77f7f131a
 osVersion: Android29 (10)
 appVersion:3.4.0
 comments:Testing
 xy:
 latlng:(21.268432487549934, 40.42749166377135)
 coordinatesSource: S
 image1:null
 image2:null
 image3:null
 image4:null
 */

class NetworkRequest{
    // Create XML Document
    static func request(){
        let soap = AEXMLDocument()
        let envelope = soap.addChild(name: "soap:Envelope",
                                     attributes: ["xmlns:xsi":"http://www.w3.org/2001/XMLSchema-instance",
                                                  "xmlns:xsd":"http://www.w3.org/2001/XMLSchema",
                                                  "xmlns:soap":"http://schemas.xmlsoap.org/soap/envelope/"])
        
        //let header = envelope.addChild(name: "soap:Header")
        let body = envelope.addChild(name: "soap:Body")
        let geoIp = body.addChild(name:"submitComplaint", attributes:["xmlns":"http://10.66.120.186/"])
        geoIp.addChild(name: "IPAddress", value: "124.41.219.215", attributes: [:])
        
        
        
        
        let soapPayload = RTPayload(parameter: ["soapdata" : soap.xml], parameterEncoding: .defaultUrl)
        let req1 = RTRequest.init(requestUrl: "http://10.66.120.186/waterreport/v3/myservice.asmx",
                                  requestMethod: .post,
                                  header: ["language":"en",
                                           "SOAPAction":"http://10.66.120.186/waterreport/v3/myservice.asmx?op=submitComplaint",
                                           "length": String(soap.xml.count),
                                           "Content-Type": "text/xml"],
                                  payload: soapPayload)
        
        
        
        
        
        RTWebService.soapCall(request: req1) { (response) in
            print("actual output ------------------------")
            switch response {
            case .success(let res):
                print("response value")
                print(res)
            case .failure(let error):
                print("error value")
                print(error)
                
            }
        }
    }
}

