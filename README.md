 # Segment plugin v4 (WIP)

Some time ago we came up with a plan to [prepare this package for the future](https://github.com/claimsforce-gmbh/flutter-segment/issues/46).
This branch is for making this plan a reality, together with our great community. Let's do this! 💪

## Goals

- Make flutter-segment a truly federated plugin by splitting the platform interface and web support into two additional packages.
  This should make the package easier to understand for contributors and will make adding support for additional platforms (MacOS, Windows) easier. (addresses [issue #24](https://github.com/claimsforce-gmbh/flutter-segment/issues/24))
- Move the existing integration for Amplitude and all future integrations to separate packages, e.g. for AppFlyer, Mixpanel and Firebase as there is already a demand for this.
  This will keep the main package small and will also make adding new integrations easier.
  Every integration package can provide a specific configuration and readme which will make it easy to work with for the user who can mix and match between the integrations. (addresses [issue #42](https://github.com/claimsforce-gmbh/flutter-segment/issues/42))
- Remove the configuration from AndroidManifest.xml / Info.plist and instead make the package purely configurable in Dart.
  This will make the package easier to understand and work with for users and will also help when adding support for additional platforms. (addresses [issue #22](https://github.com/claimsforce-gmbh/flutter-segment/issues/22))

## Status quo

- There are now separate packages. ✔️
- Plugin can be configured from Dart. ✔️
- Web support should already work. ✔️
- Android support is mostly done, now using Kotlin. 🚧
- iOS support still needs to be implemented in Swift. 🚧
- The biggest obstacle now is, **how to achieve the separation of integrations from the main package**. ❓

---

**We would really appreciate the help of all of you to push this package forward.**

If you want to help, please join [this issue](https://github.com/claimsforce-gmbh/flutter-segment/issues/46).
