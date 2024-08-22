# Changelog

## [1.17.3](https://github.com/engeir/stowfiles/compare/bspwm-v1.17.2...bspwm-v1.17.3) (2024-08-22)


### Miscellaneous

* **main:** release fish 1.16.3 ([#124](https://github.com/engeir/stowfiles/issues/124)) ([5799516](https://github.com/engeir/stowfiles/commit/57995166b1597d7e1fc2387e92309afc0a2b617f))

## [1.17.2](https://github.com/engeir/stowfiles/compare/bspwm-v1.17.1...bspwm-v1.17.2) (2024-08-22)


### Bug Fixes

* **polybar:** correct name of machine specific file ([c403a01](https://github.com/engeir/stowfiles/commit/c403a01b90f4fa265394cd06140cee21f370b82e))

## [1.17.1](https://github.com/engeir/stowfiles/compare/bspwm-v1.17.0...bspwm-v1.17.1) (2024-08-21)


### Miscellaneous

* **main:** release fish 1.16.3 ([#108](https://github.com/engeir/stowfiles/issues/108)) ([b608f2b](https://github.com/engeir/stowfiles/commit/b608f2b1682336443fad36a571b6358f571fffbc))

## [1.17.0](https://github.com/engeir/stowfiles/compare/bspwm-v1.16.2...bspwm-v1.17.0) (2024-08-21)


### Features

* **bspwm:** add rules for where certain programs should open ([c6dfc27](https://github.com/engeir/stowfiles/commit/c6dfc27d6a8db13d07ea58e0bb7e74974c5ccaf6))
* **bspwm:** fix dynamic monitor swap and re-set polybar ([794c111](https://github.com/engeir/stowfiles/commit/794c111a2dcebb6750c759e0433d8c63e753a79d))
* **polybar:** improved machine generalisation ([6061fe9](https://github.com/engeir/stowfiles/commit/6061fe9f73f271e2e9fea0e16e649d08f92a572b))
* **polybar:** use uv to run a script with dependencies ([2a96b49](https://github.com/engeir/stowfiles/commit/2a96b496ceb741bfafd0d34da886f78b8f7843f3))


### Bug Fixes

* **bspwm:** use $HOME, not hard coded path ([855655a](https://github.com/engeir/stowfiles/commit/855655a38ae77db1f19c0f356d94ef653e1dd0ad))


### Miscellaneous

* **main:** release bin 1.15.5 ([#104](https://github.com/engeir/stowfiles/issues/104)) ([402080e](https://github.com/engeir/stowfiles/commit/402080e75a7d67cc331643f06ee5fae8e109f603))
* **main:** release dprint 1.15.6 ([#107](https://github.com/engeir/stowfiles/issues/107)) ([c7aef97](https://github.com/engeir/stowfiles/commit/c7aef97e8d89050ffc4f204c4568dad35e143605))
* **main:** release mise 1.17.1 ([#101](https://github.com/engeir/stowfiles/issues/101)) ([c49c74a](https://github.com/engeir/stowfiles/commit/c49c74aaf922df1bd2822a14b399ed31ecdb70a1))
* **main:** release picom 1.15.3 ([#112](https://github.com/engeir/stowfiles/issues/112)) ([913aeae](https://github.com/engeir/stowfiles/commit/913aeaed2d48141469eadc647455672786b84e50))
* **main:** release tmux 1.16.1 ([#111](https://github.com/engeir/stowfiles/issues/111)) ([7ae9dfb](https://github.com/engeir/stowfiles/commit/7ae9dfbba446cf05d1379d79bb77b8712eed9d57))
* **main:** release X 1.15.5 ([#110](https://github.com/engeir/stowfiles/issues/110)) ([8acb2de](https://github.com/engeir/stowfiles/commit/8acb2dea2703d0c644dbc5cedde90d856bd70788))
* **main:** release zathura 1.16.0 ([#109](https://github.com/engeir/stowfiles/issues/109)) ([f012b63](https://github.com/engeir/stowfiles/commit/f012b63b5d9a080a6ff6f87f875049d8435ad863))
* **polybar:** remove resource intensive music module ([e3df5c0](https://github.com/engeir/stowfiles/commit/e3df5c0cb9a94eab715283339ffb410f7c58fe29))


### Styles

* **bspwm:** format with dprint ([d5f441d](https://github.com/engeir/stowfiles/commit/d5f441d383508b1ab8537e7c10d7470bc8ef9e52))

## [1.16.2](https://github.com/engeir/stowfiles/compare/bspwm-v1.16.1...bspwm-v1.16.2) (2024-08-12)


### Bug Fixes

* **bspwm:** if picom does NOT exist ... exit 0 ([c18db03](https://github.com/engeir/stowfiles/commit/c18db0354bb5061d1d401d6374e562daccfa117a))

## [1.16.1](https://github.com/engeir/stowfiles/compare/bspwm-v1.16.0...bspwm-v1.16.1) (2024-08-11)


### Code Refactoring

* **picom:** complete the rename from compton to picom ([5b81f8c](https://github.com/engeir/stowfiles/commit/5b81f8c9bb5b1c5a67ffbc178d07a7ca563b42d0))

## [1.16.0](https://github.com/engeir/stowfiles/compare/bspwm-v1.15.3...bspwm-v1.16.0) (2024-08-11)


### Features

* **compositor:** update name from compton to picom and add global opacity ([51e75b4](https://github.com/engeir/stowfiles/commit/51e75b498a81c24b1d2e2bdf5fbd074c53c541de))


### Bug Fixes

* **compositor:** inactive window opacity need mark-ovredir-focused = false ([0a5a581](https://github.com/engeir/stowfiles/commit/0a5a58150b2a5a98140b43a8e4671478c2092c98))


### Miscellaneous

* **arch:** add arch settings ([730a639](https://github.com/engeir/stowfiles/commit/730a639ab45e0c596a54a9128f1773058d8742d6))
* **picom:** add comment about opacity excludes ([3ebb8e5](https://github.com/engeir/stowfiles/commit/3ebb8e5b9f2a22f659a6fa000e87de10aa0f509b))
* **zsh:** run ssh keygen directly ([db14087](https://github.com/engeir/stowfiles/commit/db140877472330a659c6a05b5dda7ebf9b7cd9a3))

## [1.15.3](https://github.com/engeir/stowfiles/compare/bspwm-v1.15.2...bspwm-v1.15.3) (2024-06-19)


### Documentation

* symlink CHANGELOG to README in packages ([45c3aac](https://github.com/engeir/stowfiles/commit/45c3aacf6c1c60ed559a8c394b4f4873fe9e806d))

## 1.15.2 (2024-06-19)


### Features

* **alacritty:** add opacity control via sxhkd ([26259c5](https://github.com/engeir/stowfiles/commit/26259c53bce91ae84170b2ed49fb5ad97c8ca9ec))
* **bspwm:** add borderless mode ([ab22396](https://github.com/engeir/stowfiles/commit/ab22396abeb0caf0725b5fcbcd96fa0c443cc21e))
* **bspwm:** add bsptab to workflow ([f8354a5](https://github.com/engeir/stowfiles/commit/f8354a5df404f2e7c52b419262e482a731d06739))


### Bug Fixes

* **bin:** correct the path to Xresources file ([20b745e](https://github.com/engeir/stowfiles/commit/20b745e5b84448dfa2c713eeffe57933e49df39b))
* **fish:** use zsh as default on ubuntu, fish in tmux ([1e4ee0f](https://github.com/engeir/stowfiles/commit/1e4ee0fcff55fb2bf1804d290d61504d21d9f018))


### Miscellaneous

* **bspwm:** keep mappings to the home row ([d8e4c26](https://github.com/engeir/stowfiles/commit/d8e4c26637d83453027dead728a0159cba5bd012))
* **bspwm:** small change to rc file ([91286db](https://github.com/engeir/stowfiles/commit/91286dbc6d2388bbb4b97c30aeb734e01cd012db))
* release 1.15.1 ([8ae5a50](https://github.com/engeir/stowfiles/commit/8ae5a506399c8574fd780fa48e6df75e7bf92946))
* release 1.15.2 ([a56e2b3](https://github.com/engeir/stowfiles/commit/a56e2b3e1a6a859ad6b0b3953832b88fd87ecfcb))
* release 1.15.2 ([35e368a](https://github.com/engeir/stowfiles/commit/35e368a1bf125ca33b6acc36d32f86ed88ca87be))
* small changes ([9605f04](https://github.com/engeir/stowfiles/commit/9605f04e07b6e6d979295fa18c4bdb566bf6c918))
* **software:** run updater ([f4eba9d](https://github.com/engeir/stowfiles/commit/f4eba9d752480423c3c47c25492b84b5b82f4413))
* **software:** update python and ignore files ([386b6e4](https://github.com/engeir/stowfiles/commit/386b6e4d01225cf245ed86cf8be07f72c2e3668c))
* track colors ([9578d10](https://github.com/engeir/stowfiles/commit/9578d102f838a59573354ebb69ef1ebb09a00932))


### Styles

* **typo:** fix English grammar ([7c1d3be](https://github.com/engeir/stowfiles/commit/7c1d3be4b55fe51a3fb82a6f92f796c8a630a8ff))


### Code Refactoring

* **sxhkd:** stay closer to the home row ([1989883](https://github.com/engeir/stowfiles/commit/19898832793e75d9a17ea35eb155c28cb5a1e641))


### Continuous Integration

* **pre-commit:** run stylua from its official repo ([#41](https://github.com/engeir/stowfiles/issues/41)) ([5b2b282](https://github.com/engeir/stowfiles/commit/5b2b28261541a6976f312a9684294810a4d75520))
