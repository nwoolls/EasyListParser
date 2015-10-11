# EasyListParser

EasyListParser is an iOS Framework for creating Safari Content Blocker lists from EasyList filters.

## Usage

```swift
let easyListURI = "https://easylist-downloads.adblockplus.org/easyprivacy_nointernational.txt"
var blockerEntries: [ELBlockerEntry] = []
var blockerJson: String?
let maxEntries = 50000 // max allowed by Safari
let trustedDomains = ["www.reddit.com"]

if let easyListURL = NSURL(string: easyListURI) {
    do {
        let easyListContent = try String(contentsOfURL: easyListURL);
        blockerEntries = ELListParser.parse(easyListContent, maxEntries: maxEntries, trustedDomains: trustedDomains)
        blockerJson = try blockerEntries.serialize()
    } catch let error as NSError {
        print(error.localizedDescription)
    }
}
```

## Examples

* [Nope AdBlocker](https://itunes.apple.com/us/app/nope./id1043794194?ls=1&mt=8)

## References

* [AdBlock Plus Filters](https://adblockplus.org/filters)
* [AdBlock Plus Filter Cheat-Sheet](https://adblockplus.org/filter-cheatsheet)

## License

EasyListParser is released under the MIT license. See LICENSE for details.
