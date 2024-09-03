# Changelog

## [1.15.6](https://github.com/engeir/stowfiles/compare/bin-v1.15.5...bin-v1.15.6) (2024-09-03)


### Bug Fixes

* **bin:** use aerial-views dir to store wallpapers and set png and jpgs ([20c4bf2](https://github.com/engeir/stowfiles/commit/20c4bf25683f21e40206589410af28a72cdbdfd9))

## [1.15.5](https://github.com/engeir/stowfiles/compare/bin-v1.15.4...bin-v1.15.5) (2024-08-21)


### Bug Fixes

* **bin:** find wallpapers in $HOME ([36b9a29](https://github.com/engeir/stowfiles/commit/36b9a29e239a076fa2db90132b1dea15fe31fce6))
* **bin:** make toggle wallpaper to black work also on linux ([256ee3f](https://github.com/engeir/stowfiles/commit/256ee3fbc54ead6d69d2eda1211dd0883c7e43b1))


### Miscellaneous

* **bin:** use aerial-views wallpaper store ([fffcb7a](https://github.com/engeir/stowfiles/commit/fffcb7ae560be93b7d346c7a36f2d3aca9c27179))

## [1.15.4](https://github.com/engeir/stowfiles/compare/bin-v1.15.3...bin-v1.15.4) (2024-08-11)


### Miscellaneous

* **arch:** add arch settings ([730a639](https://github.com/engeir/stowfiles/commit/730a639ab45e0c596a54a9128f1773058d8742d6))
* **bin,tmux:** add preview-window hidden flag ([b905621](https://github.com/engeir/stowfiles/commit/b90562135b5ba459d0ba27cc2f39322eed1c3223))
* **gpg:** set up arch linux gpg keychain ([384657a](https://github.com/engeir/stowfiles/commit/384657ad233b13ad8023af3732f4855d70016522))
* **zsh:** run ssh keygen directly ([db14087](https://github.com/engeir/stowfiles/commit/db140877472330a659c6a05b5dda7ebf9b7cd9a3))

## [1.15.3](https://github.com/engeir/stowfiles/compare/bin-v1.15.2...bin-v1.15.3) (2024-06-19)


### Documentation

* symlink CHANGELOG to README in packages ([45c3aac](https://github.com/engeir/stowfiles/commit/45c3aacf6c1c60ed559a8c394b4f4873fe9e806d))

## 1.15.2 (2024-06-19)


### Features

* **bin:** add pomodoro to custom scripts ([d990bda](https://github.com/engeir/stowfiles/commit/d990bda03085bdc99f0c609da9e777a7a9901d33))
* **bin:** add screen record func and fix screen capture func ([ee101a2](https://github.com/engeir/stowfiles/commit/ee101a2b16ede2311460f80e70ebd4507a4731d3))
* **bin:** change all desktop wallpapers on mac ([aa013ef](https://github.com/engeir/stowfiles/commit/aa013efd9868a4e6bfa463e8003729995fa3b730))
* **bin:** if bspwm acts up, force kill the process ([beb5416](https://github.com/engeir/stowfiles/commit/beb5416cded88c579641833c6ae8d6ef7c25083f))
* **bin:** make tms script move to the location of the provided path ([815f22d](https://github.com/engeir/stowfiles/commit/815f22d60c37ba2da8e748995334d61773314b20))
* **bin:** tms, add ability to use different names on similar basename paths ([fc7b135](https://github.com/engeir/stowfiles/commit/fc7b135341f34605e53e9addbd6231ca0650a4aa))
* **bin:** use exit code in lcm (mount script) ([e355a6c](https://github.com/engeir/stowfiles/commit/e355a6c6e764fa7f42c4cf0da9147922862b1400))
* **bin:** video edit by ffmpeg scripts ([63ad1d2](https://github.com/engeir/stowfiles/commit/63ad1d24376e22f46aaf018641386e86a4e31963))
* **bin:** video edit script v2 ([3cb39bc](https://github.com/engeir/stowfiles/commit/3cb39bc93f6ca88163ad48b56b3de976da16d314))
* **mac:** wallpaper toggle and sketchybar toggle ([94dec00](https://github.com/engeir/stowfiles/commit/94dec0062d34354206b3f22ce27bd16fec61ace1))
* **mount:** expect script for mounting LaCie external hard disk ([a3f5161](https://github.com/engeir/stowfiles/commit/a3f5161f4563e992a94e8800163f2892d379a9a9))
* **nvim-installer:** script to install and run with appname ([21c2b40](https://github.com/engeir/stowfiles/commit/21c2b40d0a88f93c0e16dea543623966854a4b6b))
* **nvim:** in nvc, pass all args to nvim command ([1b3224e](https://github.com/engeir/stowfiles/commit/1b3224eff797da8278148d3c2aecbe1f5a3f954b))
* **starship,bin:** detect if rye, poetry or unknown python manager is used ([0bbefc6](https://github.com/engeir/stowfiles/commit/0bbefc638c193b9694b5af767878ff894cd0e762))
* **zsh:** auto fill ssh passphrases ([77df308](https://github.com/engeir/stowfiles/commit/77df30837261b70db1dfa9828e3f7b513d5ede52))


### Bug Fixes

* **bin:** better output format of video reduce command ([c0caab1](https://github.com/engeir/stowfiles/commit/c0caab168b4bb8cd11d98683bb8a933ace98c94e))
* **bin:** tms, check for existing session from output, not opposite ([5dc5151](https://github.com/engeir/stowfiles/commit/5dc51518184dff208ff679a5382592c71bb4e303))
* **nvc:** find init.lua if not in the root dir ([d862b70](https://github.com/engeir/stowfiles/commit/d862b70b01d4a900abfa02c04b3251ef0e556ce8))
* **osx:** blur on mac osx works now ([125e1c8](https://github.com/engeir/stowfiles/commit/125e1c854206655943722c1d47aaf371743d4b32))
* **ssh:** use keychain to get keys in fish ([68d015a](https://github.com/engeir/stowfiles/commit/68d015afbc9084076e19f249208a175682a9884e))
* **wallpaper:** copying to the same location uses wrong image ([c80c502](https://github.com/engeir/stowfiles/commit/c80c50269ff1ef1f118720cc676cda71fa8b1711))


### Miscellaneous

* **bin:** add all arguments to alacritty popup ([b7aceb3](https://github.com/engeir/stowfiles/commit/b7aceb369d24d9457366ce8fe721f461f01a82d7))
* **bin:** add blur to mac wallpaper script ([fdf9ac6](https://github.com/engeir/stowfiles/commit/fdf9ac60002b54b5428754f303cdbfb64e35a026))
* **bin:** add notification to lcm and add pomodoro ([46514a5](https://github.com/engeir/stowfiles/commit/46514a535c76a8d2d66f73eb7d9e61a0e1bc1dcb))
* **bin:** add small keylogger popup ([8b79235](https://github.com/engeir/stowfiles/commit/8b79235a6adb14ee20fdf507f7bc8cb58a6ee965))
* **bin:** less blurring of the wallpaper ([4a020d9](https://github.com/engeir/stowfiles/commit/4a020d907e1802cb3448cf676a2e9c29691d925f))
* **bin:** update tms FRAM directories and python settings for nvim ([0ce58ea](https://github.com/engeir/stowfiles/commit/0ce58ea3312da0c45fcfb3c6783e39d85e4e476d))
* **bin:** update to correct nvc script output ([ed15066](https://github.com/engeir/stowfiles/commit/ed150668acf282ab6ae29ba3f5de2284161ac47e))
* **bin:** wallpapers now get a blur on linux ([d59b536](https://github.com/engeir/stowfiles/commit/d59b53698f643323d0cea16a523d92748549aa46))
* comments and stuff ([8895a85](https://github.com/engeir/stowfiles/commit/8895a857636f818a417ca164cc1512597eb24949))
* **mise:** run compiler and latex behind mise (danger) ([e924ecd](https://github.com/engeir/stowfiles/commit/e924ecd82585d3a38b7af43608844839ccdaab75))
* **pandoc:** add custom option for shifting header level and change TOC generator ([ed06734](https://github.com/engeir/stowfiles/commit/ed067347ce1e4b4c5064488f92ff45e300a4bc5e))
* release 1.15.1 ([8ae5a50](https://github.com/engeir/stowfiles/commit/8ae5a506399c8574fd780fa48e6df75e7bf92946))
* release 1.15.2 ([a56e2b3](https://github.com/engeir/stowfiles/commit/a56e2b3e1a6a859ad6b0b3953832b88fd87ecfcb))
* release 1.15.2 ([35e368a](https://github.com/engeir/stowfiles/commit/35e368a1bf125ca33b6acc36d32f86ed88ca87be))
* **revealjs:** add id to reference list generator ([bd3f0e4](https://github.com/engeir/stowfiles/commit/bd3f0e4f325998403c70cf6108a99a4b6c2802fa))
* small changes ([14e6a6d](https://github.com/engeir/stowfiles/commit/14e6a6d4c80bce7107e39ef530ff46ef4880b097))
* **software:** run rclone update and add rclone source ([16dec0e](https://github.com/engeir/stowfiles/commit/16dec0ea2ea7963430ccccd44a7da4cf0f67fff7))
* **software:** update installed ([2206841](https://github.com/engeir/stowfiles/commit/220684102d4f1153824a2f5e0e8682ecd7b4d3d4))
* track changes ([11b9aa7](https://github.com/engeir/stowfiles/commit/11b9aa74055acc7eca78d0229069e4db32f99cc0))


### Styles

* **bin:** format compiler shell script ([6275ca4](https://github.com/engeir/stowfiles/commit/6275ca46dc94375d29e55002817be60145f372d8))
* **dprint:** format the repo with dprint during pre-commit ([6f5aef9](https://github.com/engeir/stowfiles/commit/6f5aef945cd85e9b82e4bada74599fbfab15fbb4)), closes [#33](https://github.com/engeir/stowfiles/issues/33)


### Code Refactoring

* **pyenv:** remove pyenv ([fae343f](https://github.com/engeir/stowfiles/commit/fae343f81db53f9236b6bbf037b6473c3bae2f0b))


### Continuous Integration

* **pre-commit:** run stylua from its official repo ([#41](https://github.com/engeir/stowfiles/issues/41)) ([5b2b282](https://github.com/engeir/stowfiles/commit/5b2b28261541a6976f312a9684294810a4d75520))
