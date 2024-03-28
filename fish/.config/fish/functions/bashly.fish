function bashly --wraps='docker run --rm -it --user $(id -u):$(id -g) --volume "$PWD:/app" dannyben/bashly' --description 'alias bashly=docker run --rm -it --user $(id -u):$(id -g) --volume "$PWD:/app" dannyben/bashly'
  docker run --rm -it --user $(id -u):$(id -g) --volume "$PWD:/app" dannyben/bashly $argv

end
