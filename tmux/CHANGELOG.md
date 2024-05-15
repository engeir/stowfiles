# Changelog

## [0.2.0](https://github.com/engeir/stowfiles/compare/tmux-v0.1.0...tmux-v0.2.0) (2024-05-15)


### Features

* **nvim/tmux:** set up system copy using osc52 ([36983dc](https://github.com/engeir/stowfiles/commit/36983dc5238e93c3e6cf9c9bc37e7fcd90cd5895))
* **nvim:** add vim-tmux-navigator, using M-&lt;hjlk&gt; ([051ac4e](https://github.com/engeir/stowfiles/commit/051ac4ecbc1aa9b0ce6730b28c2aaba269ff26d2))
* **nvim:** finally make 3rd/image.nvim work ([b8b1519](https://github.com/engeir/stowfiles/commit/b8b1519966235140a61cb8def776a7389c4859d2))
* **tmux:** add tmux-resurrect plugin since I lost my sessions on my remote machine lol ([8af97eb](https://github.com/engeir/stowfiles/commit/8af97ebb20889bac0addcc6307140dc7925aa9fd))
* **tmux:** add vim-tmux-navigator, using M-&lt;hjlk&gt; ([051ac4e](https://github.com/engeir/stowfiles/commit/051ac4ecbc1aa9b0ce6730b28c2aaba269ff26d2))
* **tmux:** set the fish shell to default ([4ef639b](https://github.com/engeir/stowfiles/commit/4ef639bc8d52c6d3bc71c37ed91199199db2d968))
* **tmux:** toggle synced panes with &lt;prefix&gt;<c-x> ([a7bb068](https://github.com/engeir/stowfiles/commit/a7bb068d774efb6e8491c9fbb5885ef956d39a8d))


### Bug Fixes

* **tmux:** C-H also matches C-h, which I use in nvim ([c032b69](https://github.com/engeir/stowfiles/commit/c032b691add3258577e70e8679777dbfeb16ee36))
* **tmux:** only set fish if available ([470a44c](https://github.com/engeir/stowfiles/commit/470a44cce1afbb58e693635849a236b170481f01))
* **tmux:** use the -u flag to specify it should use custom config ([53d2827](https://github.com/engeir/stowfiles/commit/53d282761f87a76cd2c3ceb647b136480867bdd8))


### Miscellaneous

* **tmux:** add key binding to toggle status line ([ca37e1d](https://github.com/engeir/stowfiles/commit/ca37e1d6d59f0746b58dd7463df9d29aa450b250))
* **tmux:** adjust keymaps to use the home row more ([60eac7c](https://github.com/engeir/stowfiles/commit/60eac7cfd8cb612faef251419f20cfbe4c964712))
* **tmux:** lets also add tmux-continuum to automatically save every 15min ([928aba4](https://github.com/engeir/stowfiles/commit/928aba4af9b84a3ae2eac8921b4f19b3d59fa425))
* **tmux:** lets also automatically restore sessions when starting tmux ([1f58923](https://github.com/engeir/stowfiles/commit/1f58923bc571573e31d582c9c4fbff360eb7c6ef))
* **tumx:** add a break-pane keybind (&lt;prefix&gt;b) ([bf670dd](https://github.com/engeir/stowfiles/commit/bf670dd9efc2a0894b418050f3cd16cbf94b17c6))


### Styles

* **dprint:** format the repo with dprint during pre-commit ([6f5aef9](https://github.com/engeir/stowfiles/commit/6f5aef945cd85e9b82e4bada74599fbfab15fbb4)), closes [#33](https://github.com/engeir/stowfiles/issues/33)


### Continuous Integration

* **pre-commit:** run stylua from its official repo ([#41](https://github.com/engeir/stowfiles/issues/41)) ([5b2b282](https://github.com/engeir/stowfiles/commit/5b2b28261541a6976f312a9684294810a4d75520))
