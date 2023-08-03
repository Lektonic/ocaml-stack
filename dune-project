(lang dune 3.9)

(name stack_machine)

(generate_opam_files true)

(source
 (github lektonic/ocaml-stack))

(authors "Lektonic")

(maintainers "Maintainer Name")

(license MIT)

(package
 (name stack_machine)
 (synopsis "A few stack machines to learn Ocaml")
 (description "This packages is purely for my own use. It's being used for me to learn Ocaml.")
 (depends ocaml dune)
 (tags
  ("stack machine" stack)))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/dune-files.html#dune-project
