[private]
build target:
  buildah build --layers -f container/Containerfile -t interactive:{{ target }} --target {{ target }} .

base: (build "base")

devenv: (build "devenv")

all: base devenv
