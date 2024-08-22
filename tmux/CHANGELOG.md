# Changelog

## [1.16.2](https://github.com/engeir/stowfiles/compare/tmux-v1.16.1...tmux-v1.16.2) (2024-08-22)


### Miscellaneous

* **main:** release fish 1.16.3 ([#124](https://github.com/engeir/stowfiles/issues/124)) ([5799516](https://github.com/engeir/stowfiles/commit/57995166b1597d7e1fc2387e92309afc0a2b617f))

## [1.16.1](https://github.com/engeir/stowfiles/compare/tmux-v1.16.0...tmux-v1.16.1) (2024-08-21)


### Miscellaneous

* **tmux:** bootstrap TPM ([b843841](https://github.com/engeir/stowfiles/commit/b8438413d87474f7ba3afede3b44b958b7569ab0))

## [1.16.0](https://github.com/engeir/stowfiles/compare/tmux-v1.15.2...tmux-v1.16.0) (2024-08-11)


### Features

* **zsh:** update zsh and set it to be the default interactive shell ([89190c4](https://github.com/engeir/stowfiles/commit/89190c4d24db1d5c382fbd5153119f919a5cbfc8))


### Miscellaneous

* **bin,tmux:** add preview-window hidden flag ([b905621](https://github.com/engeir/stowfiles/commit/b90562135b5ba459d0ba27cc2f39322eed1c3223))
* **zsh:** run ssh keygen directly ([db14087](https://github.com/engeir/stowfiles/commit/db140877472330a659c6a05b5dda7ebf9b7cd9a3))

## [1.15.2](https://github.com/engeir/stowfiles/compare/tmux-v1.15.2...tmux-v1.15.2) (2024-06-19)


### Features

* **nvim/tmux:** set up system copy using osc52 ([36983dc](https://github.com/engeir/stowfiles/commit/36983dc5238e93c3e6cf9c9bc37e7fcd90cd5895))
* **nvim:** add vim-tmux-navigator, using M-&lt;hjlk&gt; ([051ac4e](https://github.com/engeir/stowfiles/commit/051ac4ecbc1aa9b0ce6730b28c2aaba269ff26d2))
* **nvim:** finally make 3rd/image.nvim work ([b8b1519](https://github.com/engeir/stowfiles/commit/b8b1519966235140a61cb8def776a7389c4859d2))
* **tmux:** add tmux-resurrect plugin since I lost my sessions on my remote machine lol ([8af97eb](https://github.com/engeir/stowfiles/commit/8af97ebb20889bac0addcc6307140dc7925aa9fd))
* **tmux:** add vim-tmux-navigator, using M-&lt;hjlk&gt; ([051ac4e](https://github.com/engeir/stowfiles/commit/051ac4ecbc1aa9b0ce6730b28c2aaba269ff26d2))
* **tmux:** set the fish shell to default ([4ef639b](https://github.com/engeir/stowfiles/commit/4ef639bc8d52c6d3bc71c37ed91199199db2d968))


### Bug Fixes

* **tmux:** C-H also matches C-h, which I use in nvim ([c032b69](https://github.com/engeir/stowfiles/commit/c032b691add3258577e70e8679777dbfeb16ee36))
* **tmux:** only set fish if available ([470a44c](https://github.com/engeir/stowfiles/commit/470a44cce1afbb58e693635849a236b170481f01))
* **tmux:** use the -u flag to specify it should use custom config ([53d2827](https://github.com/engeir/stowfiles/commit/53d282761f87a76cd2c3ceb647b136480867bdd8))


### Miscellaneous

* release 1.15.1 ([8ae5a50](https://github.com/engeir/stowfiles/commit/8ae5a506399c8574fd780fa48e6df75e7bf92946))
* release 1.15.2 ([a56e2b3](https://github.com/engeir/stowfiles/commit/a56e2b3e1a6a859ad6b0b3953832b88fd87ecfcb))
* release 1.15.2 ([35e368a](https://github.com/engeir/stowfiles/commit/35e368a1bf125ca33b6acc36d32f86ed88ca87be))
* release main ([#59](https://github.com/engeir/stowfiles/issues/59)) ([c0e742c](https://github.com/engeir/stowfiles/commit/c0e742c7eab4a42d0f40bcd12f5951e4072e56da))
* release main ([#60](https://github.com/engeir/stowfiles/issues/60)) ([081b923](https://github.com/engeir/stowfiles/commit/081b923192cff502520fd9861249bcb2a0ee7722))
* **tmux:** add key binding to toggle status line ([ca37e1d](https://github.com/engeir/stowfiles/commit/ca37e1d6d59f0746b58dd7463df9d29aa450b250))
* **tmux:** adjust keymaps to use the home row more ([60eac7c](https://github.com/engeir/stowfiles/commit/60eac7cfd8cb612faef251419f20cfbe4c964712))
* **tmux:** lets also add tmux-continuum to automatically save every 15min ([928aba4](https://github.com/engeir/stowfiles/commit/928aba4af9b84a3ae2eac8921b4f19b3d59fa425))
* **tmux:** lets also automatically restore sessions when starting tmux ([1f58923](https://github.com/engeir/stowfiles/commit/1f58923bc571573e31d582c9c4fbff360eb7c6ef))
* **tumx:** add a break-pane keybind (&lt;prefix&gt;b) ([bf670dd](https://github.com/engeir/stowfiles/commit/bf670dd9efc2a0894b418050f3cd16cbf94b17c6))


### Styles

* **dprint:** format the repo with dprint during pre-commit ([6f5aef9](https://github.com/engeir/stowfiles/commit/6f5aef945cd85e9b82e4bada74599fbfab15fbb4)), closes [#33](https://github.com/engeir/stowfiles/issues/33)


### Continuous Integration

* **pre-commit:** run stylua from its official repo ([#41](https://github.com/engeir/stowfiles/issues/41)) ([5b2b282](https://github.com/engeir/stowfiles/commit/5b2b28261541a6976f312a9684294810a4d75520))


### Documentation

* symlink CHANGELOG to README in packages ([45c3aac](https://github.com/engeir/stowfiles/commit/45c3aacf6c1c60ed559a8c394b4f4873fe9e806d))

## [1.15.2](https://github.com/engeir/stowfiles/compare/tmux-v1.15.2...tmux-v1.15.2) (2024-06-19)


### Features

* **nvim/tmux:** set up system copy using osc52 ([36983dc](https://github.com/engeir/stowfiles/commit/36983dc5238e93c3e6cf9c9bc37e7fcd90cd5895))
* **nvim:** add vim-tmux-navigator, using M-&lt;hjlk&gt; ([051ac4e](https://github.com/engeir/stowfiles/commit/051ac4ecbc1aa9b0ce6730b28c2aaba269ff26d2))
* **nvim:** finally make 3rd/image.nvim work ([b8b1519](https://github.com/engeir/stowfiles/commit/b8b1519966235140a61cb8def776a7389c4859d2))
* **tmux:** add tmux-resurrect plugin since I lost my sessions on my remote machine lol ([8af97eb](https://github.com/engeir/stowfiles/commit/8af97ebb20889bac0addcc6307140dc7925aa9fd))
* **tmux:** add vim-tmux-navigator, using M-&lt;hjlk&gt; ([051ac4e](https://github.com/engeir/stowfiles/commit/051ac4ecbc1aa9b0ce6730b28c2aaba269ff26d2))
* **tmux:** set the fish shell to default ([4ef639b](https://github.com/engeir/stowfiles/commit/4ef639bc8d52c6d3bc71c37ed91199199db2d968))


### Bug Fixes

* **tmux:** C-H also matches C-h, which I use in nvim ([c032b69](https://github.com/engeir/stowfiles/commit/c032b691add3258577e70e8679777dbfeb16ee36))
* **tmux:** only set fish if available ([470a44c](https://github.com/engeir/stowfiles/commit/470a44cce1afbb58e693635849a236b170481f01))
* **tmux:** use the -u flag to specify it should use custom config ([53d2827](https://github.com/engeir/stowfiles/commit/53d282761f87a76cd2c3ceb647b136480867bdd8))


### Miscellaneous

* release 1.15.1 ([8ae5a50](https://github.com/engeir/stowfiles/commit/8ae5a506399c8574fd780fa48e6df75e7bf92946))
* release 1.15.2 ([a56e2b3](https://github.com/engeir/stowfiles/commit/a56e2b3e1a6a859ad6b0b3953832b88fd87ecfcb))
* release 1.15.2 ([35e368a](https://github.com/engeir/stowfiles/commit/35e368a1bf125ca33b6acc36d32f86ed88ca87be))
* release main ([#59](https://github.com/engeir/stowfiles/issues/59)) ([c0e742c](https://github.com/engeir/stowfiles/commit/c0e742c7eab4a42d0f40bcd12f5951e4072e56da))
* **tmux:** add key binding to toggle status line ([ca37e1d](https://github.com/engeir/stowfiles/commit/ca37e1d6d59f0746b58dd7463df9d29aa450b250))
* **tmux:** adjust keymaps to use the home row more ([60eac7c](https://github.com/engeir/stowfiles/commit/60eac7cfd8cb612faef251419f20cfbe4c964712))
* **tmux:** lets also add tmux-continuum to automatically save every 15min ([928aba4](https://github.com/engeir/stowfiles/commit/928aba4af9b84a3ae2eac8921b4f19b3d59fa425))
* **tmux:** lets also automatically restore sessions when starting tmux ([1f58923](https://github.com/engeir/stowfiles/commit/1f58923bc571573e31d582c9c4fbff360eb7c6ef))
* **tumx:** add a break-pane keybind (&lt;prefix&gt;b) ([bf670dd](https://github.com/engeir/stowfiles/commit/bf670dd9efc2a0894b418050f3cd16cbf94b17c6))


### Styles

* **dprint:** format the repo with dprint during pre-commit ([6f5aef9](https://github.com/engeir/stowfiles/commit/6f5aef945cd85e9b82e4bada74599fbfab15fbb4)), closes [#33](https://github.com/engeir/stowfiles/issues/33)


### Continuous Integration

* **pre-commit:** run stylua from its official repo ([#41](https://github.com/engeir/stowfiles/issues/41)) ([5b2b282](https://github.com/engeir/stowfiles/commit/5b2b28261541a6976f312a9684294810a4d75520))


### Documentation

* symlink CHANGELOG to README in packages ([45c3aac](https://github.com/engeir/stowfiles/commit/45c3aacf6c1c60ed559a8c394b4f4873fe9e806d))

## 1.15.2 (2024-06-19)


### Features

* **nvim/tmux:** set up system copy using osc52 ([36983dc](https://github.com/engeir/stowfiles/commit/36983dc5238e93c3e6cf9c9bc37e7fcd90cd5895))
* **nvim:** add vim-tmux-navigator, using M-&lt;hjlk&gt; ([051ac4e](https://github.com/engeir/stowfiles/commit/051ac4ecbc1aa9b0ce6730b28c2aaba269ff26d2))
* **nvim:** finally make 3rd/image.nvim work ([b8b1519](https://github.com/engeir/stowfiles/commit/b8b1519966235140a61cb8def776a7389c4859d2))
* **tmux:** add tmux-resurrect plugin since I lost my sessions on my remote machine lol ([8af97eb](https://github.com/engeir/stowfiles/commit/8af97ebb20889bac0addcc6307140dc7925aa9fd))
* **tmux:** add vim-tmux-navigator, using M-&lt;hjlk&gt; ([051ac4e](https://github.com/engeir/stowfiles/commit/051ac4ecbc1aa9b0ce6730b28c2aaba269ff26d2))
* **tmux:** set the fish shell to default ([4ef639b](https://github.com/engeir/stowfiles/commit/4ef639bc8d52c6d3bc71c37ed91199199db2d968))


### Bug Fixes

* **tmux:** C-H also matches C-h, which I use in nvim ([c032b69](https://github.com/engeir/stowfiles/commit/c032b691add3258577e70e8679777dbfeb16ee36))
* **tmux:** only set fish if available ([470a44c](https://github.com/engeir/stowfiles/commit/470a44cce1afbb58e693635849a236b170481f01))
* **tmux:** use the -u flag to specify it should use custom config ([53d2827](https://github.com/engeir/stowfiles/commit/53d282761f87a76cd2c3ceb647b136480867bdd8))


### Miscellaneous

* release 1.15.1 ([8ae5a50](https://github.com/engeir/stowfiles/commit/8ae5a506399c8574fd780fa48e6df75e7bf92946))
* release 1.15.2 ([a56e2b3](https://github.com/engeir/stowfiles/commit/a56e2b3e1a6a859ad6b0b3953832b88fd87ecfcb))
* release 1.15.2 ([35e368a](https://github.com/engeir/stowfiles/commit/35e368a1bf125ca33b6acc36d32f86ed88ca87be))
* **tmux:** add key binding to toggle status line ([ca37e1d](https://github.com/engeir/stowfiles/commit/ca37e1d6d59f0746b58dd7463df9d29aa450b250))
* **tmux:** adjust keymaps to use the home row more ([60eac7c](https://github.com/engeir/stowfiles/commit/60eac7cfd8cb612faef251419f20cfbe4c964712))
* **tmux:** lets also add tmux-continuum to automatically save every 15min ([928aba4](https://github.com/engeir/stowfiles/commit/928aba4af9b84a3ae2eac8921b4f19b3d59fa425))
* **tmux:** lets also automatically restore sessions when starting tmux ([1f58923](https://github.com/engeir/stowfiles/commit/1f58923bc571573e31d582c9c4fbff360eb7c6ef))
* **tumx:** add a break-pane keybind (&lt;prefix&gt;b) ([bf670dd](https://github.com/engeir/stowfiles/commit/bf670dd9efc2a0894b418050f3cd16cbf94b17c6))


### Styles

* **dprint:** format the repo with dprint during pre-commit ([6f5aef9](https://github.com/engeir/stowfiles/commit/6f5aef945cd85e9b82e4bada74599fbfab15fbb4)), closes [#33](https://github.com/engeir/stowfiles/issues/33)


### Continuous Integration

* **pre-commit:** run stylua from its official repo ([#41](https://github.com/engeir/stowfiles/issues/41)) ([5b2b282](https://github.com/engeir/stowfiles/commit/5b2b28261541a6976f312a9684294810a4d75520))
