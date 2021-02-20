//
//  SHA256Digest+String.swift
//  MoodUp
//
//  Created by Manuel Kunz on 20.02.21.
//

import Foundation
import CryptoKit

extension SHA256Digest {
	var hashString: String {
		compactMap { String(format: "%02x", $0) }.joined()
	}
}
