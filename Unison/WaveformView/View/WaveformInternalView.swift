//
//  WaveformInternalView.swift
//  Unison
//
//  Created by Dzmitry Shuysky on 9/14/20.
//  Copyright © 2020 Unison. All rights reserved.
//

import UIKit
import AVFoundation
import Accelerate

class WaveformInternalView: UIView {
    
    // - Aliases
    fileprivate typealias Samples = [Float]
    
    // - Constants
    private let segmentWidth: Int = 3
    private let interitemSpace: Int = 5
    private let segmentCornerRadius: CGFloat = 1.5
    
    // - Data
    private var samples: Samples? = nil
    
    // - Init
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
    }
    
}

// MARK: -
// MARK: - Draw

extension WaveformInternalView {
    
    override func draw(_ rect: CGRect) {
        let (_, r, numSegments) = getNumSegments()
        let horizontalMargin = segmentWidth < r ? (r - segmentWidth) / 2 : (segmentWidth / 2)
        
        let path = UIBezierPath()
        for segmentIndex in 0..<numSegments {
            let segmentRectX = horizontalMargin + segmentIndex * (segmentWidth + interitemSpace)
            let segmentRect = CGRect(x: segmentRectX, y: 0, width: segmentWidth, height: Int(rect.height))
            path.append(UIBezierPath(roundedRect: segmentRect, cornerRadius: segmentCornerRadius))
        }
        
        AppColor.lightGray.setFill()
        path.fill()
        drawSamples(rect, numSegments: numSegments, horizontalMargin: horizontalMargin)
    }
    
    private func drawSamples(_ rect: CGRect, numSegments: Int, horizontalMargin: Int) {
        guard let samples = samples, samples.count >= numSegments else { return }
        let path = UIBezierPath()
        
        for (segmentIndex, sample) in zip(0..<numSegments, samples) {
            let sample = sample > 0.1 ? sample : 0.1
            let segmentRectX = horizontalMargin + segmentIndex * (segmentWidth + interitemSpace)
            let segmentRectY = (1 - CGFloat(sample)) * rect.height / 2
            let segmentRect = CGRect(x: CGFloat(segmentRectX), y: segmentRectY, width: CGFloat(segmentWidth), height: rect.height * CGFloat(sample))
            path.append(UIBezierPath(roundedRect: segmentRect, cornerRadius: segmentCornerRadius))
        }
        
        AppColor.darkGray.setFill()
        path.fill()
    }
    
}

// MARK: -
// MARK: - Set

extension WaveformInternalView {
    
    func set(audioURL: URL) {
        let (_, _, numSegments) = getNumSegments()
        getPCMSamples(fromAudioWith: audioURL, numSamples: numSegments) { [weak self] samples in
            guard let self = self, let samples = samples else { return }
            self.samples = self.normalizeSamples(samples)
            self.layoutIfNeeded()
        }
    }
    
}

// MARK: -
// MARK: - Internal

fileprivate extension WaveformInternalView {

    private func getPCMSamples(fromAudioWith audioURL: URL, numSamples requestedNumSamples: Int,
                               completion: @escaping ((Samples?) -> Void)) {
        
        let buffer = getPCMBuffer(audioURL: audioURL)
        let sample_ptr = buffer?.floatChannelData?.pointee
        
        if let buffer = buffer, let sample_ptr = sample_ptr {
            let numSamples = Int(buffer.frameLength)
            let chunkSize = numSamples/requestedNumSamples
            
            var samples: Samples = []
            for chunkIndex in stride(from: 0, to: numSamples, by: chunkSize) {
                let bufferChunk_ptr = UnsafeBufferPointer(start: sample_ptr.advanced(by: chunkIndex), count: chunkSize)
                var sample: Float = 0
                vDSP_rmsqv(bufferChunk_ptr.baseAddress!, 1, &sample, vDSP_Length(bufferChunk_ptr.count))
                samples.append(sample)
            }
            completion(samples)
        }
        
    }
    
    private func getPCMBuffer(audioURL: URL) -> AVAudioPCMBuffer? {
        do {
            let audio = try AVAudioFile(forReading: audioURL)
            let audioLength = UInt32(audio.length)
            let audioFormat = AVAudioFormat(commonFormat: .pcmFormatFloat32,
                                            sampleRate: audio.fileFormat.sampleRate,
                                            channels: audio.fileFormat.channelCount,
                                            interleaved: false)
            
            if let format = audioFormat, let pcmBuffer = AVAudioPCMBuffer(pcmFormat: format, frameCapacity: audioLength) {
                try audio.read(into: pcmBuffer, frameCount: audioLength)
                return pcmBuffer
                
            } else { return nil }
        } catch { return nil }
    }
    
}

// MARK: -
// MARK: - Helpers

fileprivate extension WaveformInternalView {
    
    private func getNumSegments() -> (_quo: Int, _rem: Int, numSegments: Int) {
        let (q, r) = Int(bounds.width).quotientAndRemainder(dividingBy: segmentWidth + interitemSpace)
        let numSegments = segmentWidth < r ? q + 1 : q
        return (_quo: q, _rem: r, numSegments: numSegments)
    }
    
    private func normalizeSamples(_ samples: Samples) -> Samples {
        guard !samples.isEmpty else { return [] }
        let min_ = samples.min()!
        let max_ = samples.max()!
        return samples.map() { ($0 - min_) / max_ - min_ }
    }
    
}
