# Changelog

## [1.15.3](https://github.com/engeir/stowfiles/compare/mise-v1.15.2...mise-v1.15.3) (2024-06-19)


### Documentation

* symlink CHANGELOG to README in packages ([45c3aac](https://github.com/engeir/stowfiles/commit/45c3aacf6c1c60ed559a8c394b4f4873fe9e806d))

## 1.15.2 (2024-06-19)


### Bug Fixes

* **mise:** set GOPATH ([cb45b0a](https://github.com/engeir/stowfiles/commit/cb45b0afd13df9fc5e29b7667e6d8ce7e3d6b77c))
* **software:** gup is nice to have so all Go binaries are up to date ([7f761d9](https://github.com/engeir/stowfiles/commit/7f761d94345d51708b42a09087e620b0746038a9))
* **software:** remove jless from mise:ubi installation, already in cargo ([5fdab1a](https://github.com/engeir/stowfiles/commit/5fdab1ade025c1c89d4a41ff3cfba112c3a2ba02))


### Miscellaneous

* **helix:** add formatting support in markdown ([e7dc738](https://github.com/engeir/stowfiles/commit/e7dc7383b95e2c430d70b4205e4ae5dfdfd5bc64))
* **mise,go:** add lazydocker to default programs ([9917229](https://github.com/engeir/stowfiles/commit/9917229e47db7eb053890468cb9514f3de4c3071))
* **mise,nvim:** add ruby nvim host to default gems ([3352d53](https://github.com/engeir/stowfiles/commit/3352d53a9c631a422e84d90872f818263292a3f7))
* **mise/fish:** add alias x="mise x --" ([69e3069](https://github.com/engeir/stowfiles/commit/69e3069859dcdcb90c59271c57a218a4ad91ead0))
* **mise:** add ruby as an installed global ([f4f6487](https://github.com/engeir/stowfiles/commit/f4f648716796dda6828847067d3756830d160908))
* **mise:** always install the five latest python minor versions ([2c27bb8](https://github.com/engeir/stowfiles/commit/2c27bb8ea17f3c2f26721320296cfba2b3c506c1))
* **mise:** install age using ubi via mise ([003f599](https://github.com/engeir/stowfiles/commit/003f599ca6b00b7ead41e1e7164311fcf8a40725))
* **mise:** install tex via mise, and use tinytex ([86382fb](https://github.com/engeir/stowfiles/commit/86382fb6a0f5da8fa8d7e3ed0a1220650c1dd5a0))
* **mise:** place mise update commands after rust toolchain ([1b78cca](https://github.com/engeir/stowfiles/commit/1b78cca264e5b0d042dfc270b57ad20ac78c887a))
* **mise:** set prompt default answer to yes ([1b78cca](https://github.com/engeir/stowfiles/commit/1b78cca264e5b0d042dfc270b57ad20ac78c887a))
* **mise:** update file path and split up config ([b65d727](https://github.com/engeir/stowfiles/commit/b65d727de470e861b640c24b015c5cc533e2b988))
* **nnn:** use custom preview-tui2 plugin ([2432378](https://github.com/engeir/stowfiles/commit/2432378548daa55375de1860c6f84aa1e8201db5))
* **nvim:** small commenting update ([2ab8f2e](https://github.com/engeir/stowfiles/commit/2ab8f2ef71dbe91e64eeb2a3ccdad2e4baa16852))
* release 1.15.1 ([8ae5a50](https://github.com/engeir/stowfiles/commit/8ae5a506399c8574fd780fa48e6df75e7bf92946))
* release 1.15.2 ([a56e2b3](https://github.com/engeir/stowfiles/commit/a56e2b3e1a6a859ad6b0b3953832b88fd87ecfcb))
* release 1.15.2 ([35e368a](https://github.com/engeir/stowfiles/commit/35e368a1bf125ca33b6acc36d32f86ed88ca87be))
* **software:** install zoxide and simple-completion-language-server ([e7dc738](https://github.com/engeir/stowfiles/commit/e7dc7383b95e2c430d70b4205e4ae5dfdfd5bc64))
* **software:** remove gup and update installed ([4fd92b6](https://github.com/engeir/stowfiles/commit/4fd92b6ee5a1c7172b947aa2559b08a3678d721b))
* **software:** try "usage" and add mise as a software source ([611a9f1](https://github.com/engeir/stowfiles/commit/611a9f1e3ed33200f2ad31169c38cc099379ede1))
* **software:** update installed ([f95be25](https://github.com/engeir/stowfiles/commit/f95be25c523a5dac1ecbdb364047a21fc8e71952))
* **software:** update installed ([86dc3cc](https://github.com/engeir/stowfiles/commit/86dc3ccf3525617f43cde55e056b9d4f571f29a0))
* **software:** update installed ([c077472](https://github.com/engeir/stowfiles/commit/c077472c33e4a3e1a4c951f88f7628a3857b8125))
* **software:** update installed ([e5ea3e5](https://github.com/engeir/stowfiles/commit/e5ea3e53f981af7c72a59f33f7b306290254cd52))
* **software:** update installed ([acb2e30](https://github.com/engeir/stowfiles/commit/acb2e30b3d55983487dbd63c72c70333cc14f8eb))
* **software:** update installed (and add some rust CLIs) ([178b36a](https://github.com/engeir/stowfiles/commit/178b36a4456e998c364ec0f223a686089fbd8d57))
* **software:** update list of installed software ([0abdfc2](https://github.com/engeir/stowfiles/commit/0abdfc24d9ff5cad53974199cfccf2fbd2e737d3))


### Styles

* **dprint:** format the repo with dprint during pre-commit ([6f5aef9](https://github.com/engeir/stowfiles/commit/6f5aef945cd85e9b82e4bada74599fbfab15fbb4)), closes [#33](https://github.com/engeir/stowfiles/issues/33)
* **zsh:** format ([2432378](https://github.com/engeir/stowfiles/commit/2432378548daa55375de1860c6f84aa1e8201db5))


### Code Refactoring

* **mise:** install go itself and binaries using mise ([e3b1e4b](https://github.com/engeir/stowfiles/commit/e3b1e4b400db5b114a0877474e061135dde0a0c8))
* **mise:** specify env source file in the common config.toml file ([69e3069](https://github.com/engeir/stowfiles/commit/69e3069859dcdcb90c59271c57a218a4ad91ead0))
* **mise:** use mise to control env variables ([b743f47](https://github.com/engeir/stowfiles/commit/b743f47dc71f3d91c2d6ba57b05bf698206c1aa5))