//
//  Error.swift
//  ResumeMaker
//
//  Created by Narender Kumar on 29/04/2022.
//


import Foundation

extension Error {
    func toAppError() -> AppError {
        switch self {
        case is URLError: return .networking
        case is EncodingError: return .encoding
        case is DecodingError: return .decoding
        default: return .failure(self)
        }
    }
}
