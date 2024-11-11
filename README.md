# DisplayLinkModifier

This package adds a modifier for easily using the `CADisplayLink` in SwiftUI.

## Usage

````swift
import SwiftUI
import DisplayLinkModifier

struct MyTimeView: View {
	@Binding private var timeStamp: TimeInterval = 0
	private var startTime: TimeInterval
	
	init() {
		self.startTime = CACurrentMediaTime()
	}
	
	var body: some View {
		Text("Time elapsed: \(self.timeStamp - self.startTime)")
			.displayLink($timeStamp)
	}
	
}
````

# License

See license in LICENSE.