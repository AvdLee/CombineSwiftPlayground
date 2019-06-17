# A Swift Playground explaining the concepts of the new Combine framework
This playground will contain all operators available in Combine.

### Playgrounds require Xcode beta 2 and up
Xcode beta 1 didn't support using Combine in playgrounds. For this you need at least Xcode beta 2. MacOS Catalina is not required.

### Implemented operators:
_Credits to [this](https://github.com/freak4pc/rxswift-to-combine-cheatsheet) repo for the list of operators_

- [ ] eraseToAnyPublisher()
- [ ] eraseToAnySubject()
- [ ] assign(to:on:)
- [ ] buffer
- [ ] catch
- [ ] catch + just
- [ ] combineLatest, tryCombineLatest
- [ ] compactMap, tryCompactMap
- [ ] append, prepend
- [ ] debounce
- [ ] print
- [ ] delay
- [ ] removeDuplicates, tryRemoveDuplicates
- [ ] handleEvents
- [ ] output(at:), output(in:)
- [ ] filter, tryFilter
- [ ] first, tryFirst
- [ ] flatMap
- [ ] switchToLatest
- [ ] replaceEmpty(with:)
- [ ] ignoreOutput()
- [ ] Publishers.Just()
- [ ] map, tryMap
- [ ] merge, tryMerge
- [ ] multicast
- [ ] receive(on:)
- [ ] reduce, tryReduce
- [ ] retry, retry(3)
- [ ] scan, tryScan
- [ ] share
- [ ] dropFirst(3)
- [ ] drop(untilOutputFrom:)
- [ ] drop(while:), tryDrop(while:)
- [x] sink
- [ ] subscribe(on:)
- [ ] collect(3) 
- [ ] last
- [ ] throttle
- [ ] timeout
- [ ] collect()
- [ ] zip

## Interesting resources
Some interesting resources regarding Combine.

- https://medium.com/gett-engineering/rxswift-to-apples-combine-cheat-sheet-e9ce32b14c5b
