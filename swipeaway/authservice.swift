//
//  authservice.swift
//  swipeaway
//
//  Created by Anish Alle on 1/28/26.
//

import Foundation
import AuthenticationServices
import Combine


var strLen = 32

func generateStr(length: Int) -> String {
    let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    return String((0..<length).map{ _ in letters.randomElement()! })
}


class AuthManager: NSObject, ObservableObject, ASWebAuthenticationPresentationContextProviding {
    var objectWillChange = ObservableObjectPublisher()
    
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor{
        let windowScene = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .first
        
            return ASPresentationAnchor(windowScene: windowScene!)
    }
    
    
  
    func runAuth() {
        let state = generateStr(length: strLen)
        guard let authURL = URL(string: "https://www.bungie.net/en/oauth/authorize?client_id=51471&response_type=code&state=\(state)") else { return }
        let scheme = "swipeaway-auth"
        
        let session = ASWebAuthenticationSession(url: authURL, callbackURLScheme: scheme) {callbackUrl, error in
            guard let callbackUrl = callbackUrl, error == nil else {
                print("Auth error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            let queryItems = URLComponents(string: callbackUrl.absoluteString)?.queryItems
            let token = queryItems?.filter({$0.name == "code"}).first?.value
            let state_req = queryItems?.filter({$0.name == "state"}).first?.value
            
            if state_req != state {
                print("State does not match")
            } else {
                print("State matches")
                print(callbackUrl)
                print("Access Token: \(token ?? "")")
            }
        }
        
        session.presentationContextProvider = self
        session.start()
        
    }

}

