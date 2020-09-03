//
//  Network.swift
//  NWCWaterReports
//
//  Created by Maged Omar on 8/31/20.
//  Copyright © 2020 NWC. All rights reserved.
//

import Foundation
import AlamofireSoap
import AEXML

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
    
    static func getOTP(mobile:String, callback:@escaping (_ message:String?, Error?)->()){
        AlamofireSoap.soapRequest("http://10.66.120.186/waterreport/v3/myservice.asmx", soapmethod: "RequestOtp", soapparameters: ["phonenumber":mobile], namespace: "http://schemas.xmlsoap.org/soap/envelope").responseString { response in
            if let xmlString = response.value{
                //                print("Request: \(response.value)")   // original url request
                do{
                    let xmlDoc = try AEXMLDocument(xml:xmlString)
                    let code = xmlDoc.root.first?.children.first?.children.first?.first?.children.first?.value ?? ""
                    callback(code,nil)
                    print(code)
                }catch(let error){
                    callback(nil,error)
                }
            }
        }
    }
    
    //"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\"><soap:Body><soap:RequestOtpResponse><soap:RequestOtpResult>AE659AF3BBEB8BE5E053B978420A47BE</soap:RequestOtpResult></soap:RequestOtpResponse></soap:Body></soap:Envelope>"
    
    
    
    
    static func submitComplaints(parameter:ComplaintsFormData, callback:@escaping (String?, Error?)->()){
        
        let parameters:[String:String] = [
            "mobileNumber":parameter.mobileNumber,
            "token": parameter.token,
            "complaintType":parameter.complaintsType,
            "cbu": "TCBU",
            "deviceId": parameter.deviceId ?? "",
            "osVersion": parameter.osVersion,
            "appVersion":parameter.appVersion ?? "",
            "comments":parameter.comments,
            "xy":parameter.xy,
            "latlng":parameter.latlng,
            "coordinatesSource":"S",
            "image1":"",
            "image2":"",
            "image3":"",
            "imaage4":"",
            "image4":""
        ]
        
        AlamofireSoap.soapRequest("http://10.66.120.186/waterreport/v3/myservice.asmx", soapmethod: "submitComplaint", soapparameters: parameters, namespace: "http://schemas.xmlsoap.org/soap/envelope").responseString { response in
            if let xmlString = response.value{
                //                print("Request: \(response.value)")   // original url request
                do{
                    let xmlDoc = try AEXMLDocument(xml:xmlString)
                    let code = xmlDoc.root.first?.children.first?.children.first?.first?.children.first?.value ?? ""
                    callback(code,nil)
                    print(code)
                }catch(let error){
                    callback(nil,error)
                }
            }
        }
    }
    
    static func authUser(mobil:String , code:String, deviceId:String, os:String, messageRef:String, callback: @escaping (String?, Error?)->()){
        
        let parameters:[String:String] = [
            "mobileNumber":mobil,
            "code" :code,
            "deviceId": deviceId,
            "os":os,
            "messageRef":messageRef
        ]
        
        
        AlamofireSoap.soapRequest("http://10.66.120.186/waterreport/v3/myservice.asmx", soapmethod: "authUser", soapparameters: parameters, namespace: "http://schemas.xmlsoap.org/soap/envelope").responseString { response in
            if let xmlString = response.value{
                //                print("Request: \(response.value)")   // original url request
                do{
                    let xmlDoc = try AEXMLDocument(xml:xmlString)
                    let code = xmlDoc.root.first?.children.first?.children.first?.first?.children.first?.value ?? ""
                    callback(code,nil)
                    print(code)
                }catch(let error){
                    callback(nil,error)
                }
            }
        }
    }
}
