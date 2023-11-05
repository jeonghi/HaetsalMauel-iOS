project:
	tuist clean
	tuist fetch
	tuist generate --no-open && pod install && open Eum.xcworkspace

open: 
	tuist generate --no-open && pod install && open Eum.xcworkspace

asset:
	tuist generate