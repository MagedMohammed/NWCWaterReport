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
import Alamofire

/*
 "mobileNumber":"0557686624",
 "token": "AE180A91AB15DA07E053B978420A89D0",
 "complaintType":"CM_LKGE",
 "cbu": "TCBU",
 "deviceId": "2707dac77f7f131a",
 "osVersion": "Android29 (10)",
 "appVersion":"3.4.0",
 "comments":"Testing",
 "xy":"",
 "latlng":"(21.268432487549934, 40.42749166377135)",
 "coordinatesSource":"S",
 "image1":"",
 "image2":"",
 "image3":"",
 "imaage4":"",
 "image4":""
 */


struct DataPayload{
    var name:String
    var value:String
}

class NetworkRequest{
    
    static func getOTP(mobile:String){
        let soap = AEXMLDocument()
        let envelope = soap.addChild(name: "soap:Envelope",
                                     attributes: ["xmlns:xsi":"http://www.w3.org/2001/XMLSchema-instance",
                                                  "xmlns:xsd":"http://www.w3.org/2001/XMLSchema",
                                                  "xmlns:soap":"http://schemas.xmlsoap.org/soap/envelope/"])
        
        //let header = envelope.addChild(name: "soap:Header")
        let body = envelope.addChild(name: "soap:Body")
        let submitComplaints = body.addChild(name:"RequestOtp"/*this Service endpoint*/, attributes:["xmlns":"http://schemas.xmlsoap.org/soap/envelope/"])
        // This is parameters
        submitComplaints.addChild(name: "phonenumber", value: mobile, attributes: [:])
        // end of parameters
        
        let soapPayload = RTPayload(parameter: [ "soapdata" : soap.xml ], parameterEncoding: .defaultUrl)
        let req1 = RTRequest.init(requestUrl: "http://10.66.120.186/waterreport/v3/myservice.asmx",
                                  requestMethod: .post,
                                  header: ["language":"en",
                                           "SOAPAction":"http://schemas.xmlsoap.org/soap/envelope/RequestOtp"/*this Service url*/,
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
    
    
    // Create XML Document
    static func submitComplaints(parameter:ComplaintsFormData){
        let soap = AEXMLDocument()
        let envelope = soap.addChild(name: "soap:Envelope",
                                     attributes: ["xmlns:xsi":"http://www.w3.org/2001/XMLSchema-instance",
                                                  "xmlns:xsd":"http://www.w3.org/2001/XMLSchema",
                                                  "xmlns:soap":"http://schemas.xmlsoap.org/soap/envelope/"])
        
        //let header = envelope.addChild(name: "soap:Header")
        let body = envelope.addChild(name: "soap:Body")
        let submitComplaints = body.addChild(name:"submitComplaint", attributes:["xmlns":"http://schemas.xmlsoap.org/soap/envelope/"])
        // This is child from Body
        submitComplaints.addChild(name: "mobileNumber", value: "0557686624", attributes: [:])
        submitComplaints.addChild(name: "token", value: "AE180A91AB15DA07E053B978420A89D0", attributes: [:])
        submitComplaints.addChild(name: "complaintType", value: parameter.complaintsType , attributes: [:])
        submitComplaints.addChild(name: "cbu", value: "TCBU", attributes: [:])
        submitComplaints.addChild(name: "deviceId", value: parameter.deviceId, attributes: [:])
        submitComplaints.addChild(name: "osVersion", value: parameter.osVersion, attributes: [:])
        submitComplaints.addChild(name: "appVersion", value: parameter.appVersion, attributes: [:])
        submitComplaints.addChild(name: "comments", value: parameter.comments, attributes: [:])
        submitComplaints.addChild(name: "xy", value: "null", attributes: [:])
        submitComplaints.addChild(name: "latlng", value: parameter.latlng, attributes: [:])
        submitComplaints.addChild(name: "coordinatesSource", value: parameter.coordinatesSource, attributes: [:])
        //        submitComplaints.addChild(name: "image1", value: "null", attributes: [:])
        //        submitComplaints.addChild(name: "image2", value: "null", attributes: [:])
        //        submitComplaints.addChild(name: "image3", value: "null", attributes: [:])
        //        submitComplaints.addChild(name: "imaage4", value: "null", attributes: [:])
        //        submitComplaints.addChild(name: "image4", value: "null", attributes: [:])
        
        
        let soapPayload = RTPayload(parameter: [ "soapdata" : soap.xml ], parameterEncoding: .defaultUrl)
        let req1 = RTRequest.init(requestUrl: "http://10.66.120.186/waterreport/v3/myservice.asmx",
                                  requestMethod: .post,
                                  header: ["language":"en",
                                           "SOAPAction":"http://schemas.xmlsoap.org/soap/envelope/submitComplaint",
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
    
    static func authUser(parameter:ComplaintsFormData){
        let soap = AEXMLDocument()
        let envelope = soap.addChild(name: "soap:Envelope",
                                     attributes: ["xmlns:xsi":"http://www.w3.org/2001/XMLSchema-instance",
                                                  "xmlns:xsd":"http://www.w3.org/2001/XMLSchema",
                                                  "xmlns:soap":"http://schemas.xmlsoap.org/soap/envelope/"])
        
        //let header = envelope.addChild(name: "soap:Header")
        let body = envelope.addChild(name: "soap:Body")
        let submitComplaints = body.addChild(name:"authUser", attributes:["xmlns":"http://schemas.xmlsoap.org/soap/envelope/"])
        // This is child from Body
        submitComplaints.addChild(name: "mobileNumber", value: "0557686624", attributes: [:])
        submitComplaints.addChild(name: "code", value: "0557686624", attributes: [:])
        submitComplaints.addChild(name: "deviceId", value: "0557686624", attributes: [:])
        submitComplaints.addChild(name: "os", value: "0557686624", attributes: [:])
        submitComplaints.addChild(name: "messageRef", value: "0557686624", attributes: [:])
        
        
        let soapPayload = RTPayload(parameter: [ "soapdata" : soap.xml ], parameterEncoding: .defaultUrl)
        let req1 = RTRequest.init(requestUrl: "http://10.66.120.186/waterreport/v3/myservice.asmx",
                                  requestMethod: .post,
                                  header: ["language":"en",
                                           "SOAPAction":"http://schemas.xmlsoap.org/soap/envelope/authUser",
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
