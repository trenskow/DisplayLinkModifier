//
//  DisplayLink.swift
//  Tiny3DEngine
//
//  Created by Kristian Trenskow on 09/11/2024.
//

import SwiftUI

struct DisplayLinkView: UIViewRepresentable {

	class Coordinator {

		@Binding var timeStamp: TimeInterval
		@Binding var targetTimeStamp: TimeInterval

		init(
			timeStamp: Binding<TimeInterval>,
			targetTimeStamp: Binding<TimeInterval>
		) {
			self._timeStamp = timeStamp
			self._targetTimeStamp = targetTimeStamp
		}

		var displayLink: CADisplayLink? {
			didSet {
				if let displayLink {
					displayLink.add(
						to: .main,
						forMode: .common)
				} else {
					oldValue?.invalidate()
				}
			}
		}

		@objc func update(sender: CADisplayLink) {
			self.timeStamp = sender.timestamp
			self.targetTimeStamp = sender.targetTimestamp
		}

	}

	@Binding var timeStamp: TimeInterval
	@Binding var targetTimeStamp: TimeInterval
	private let preferredFramesPerSecond: Int

	init(
		timeStamp: Binding<TimeInterval>,
		targetTimeStamp: Binding<TimeInterval>,
		preferredFramesPerSecond: Int = 120
	) {
		self._timeStamp = timeStamp
		self._targetTimeStamp = targetTimeStamp
		self.preferredFramesPerSecond = preferredFramesPerSecond
	}

	func makeCoordinator() -> Coordinator {
		return Coordinator(
			timeStamp: $timeStamp,
			targetTimeStamp: $targetTimeStamp)
	}

	func makeUIView(context: Context) -> some UIView {

		let view = UIView(frame: .zero)

		view.backgroundColor = .clear

		context.coordinator.displayLink = CADisplayLink(
			target: context.coordinator,
			selector: #selector(context.coordinator.update(sender:)))

		context.coordinator.displayLink?.preferredFramesPerSecond = self.preferredFramesPerSecond

		return view

	}

	func updateUIView(_ uiView: UIViewType, context: Context) {	}

	static func dismantleUIView(_ uiView: UIViewType, coordinator: Coordinator) {
		coordinator.displayLink = nil
	}

}

struct DisplayLink: ViewModifier {

	@Binding var timeStamp: TimeInterval
	@Binding var targetTimeStamp: TimeInterval
	private let preferredFramesPerSecond: Int

	init(
		timeStamp: Binding<TimeInterval>,
		targetTimeStamp: Binding<TimeInterval>,
		preferredFramesPerSecond: Int
	) {
		self._timeStamp = timeStamp
		self._targetTimeStamp = targetTimeStamp
		self.preferredFramesPerSecond = preferredFramesPerSecond
	}

	func body(content: Content) -> some View {
		ZStack {
			DisplayLinkView(
				timeStamp: self.$timeStamp,
				targetTimeStamp: self.$targetTimeStamp,
				preferredFramesPerSecond: self.preferredFramesPerSecond)
			content
		}
	}
}

extension View {
	public func displayLink(
		timeStamp: Binding<TimeInterval>,
		targetTimeStamp: Binding<TimeInterval> = .constant(0),
		preferredFramesPerSecond: Int = 120
	) -> some View {
		self.modifier(DisplayLink(
			timeStamp: timeStamp,
			targetTimeStamp: targetTimeStamp,
			preferredFramesPerSecond: preferredFramesPerSecond))
	}
}
