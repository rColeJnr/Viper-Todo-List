//
//  VtlError.swift
//  Viper Todo List
//
//  Created by rColeJnr on 01/09/24.
//

import Foundation

enum VtlError: Error {
    case InvalidJsonData
    case FailedToParse
    case FailedToSaveToCoreData
    case CouldNotSaveObject
}
