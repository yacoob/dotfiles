[private]
build target:
  podman build -f container/Containerfile -t interactive:{{ target }} --target {{ target }} .

base: (build "base")

devenv: (build "devenv")
