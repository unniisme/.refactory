runcode() {
    # Extract file extension
    ext="${1##*.}"

    # Compile and run based on file extension
    case "$ext" in
        py)
            # Run Python script
            python3 "$1"
            ;;
        c)
            # Compile C code
            gcc -o "${1%.*}" "$1" && ./"${1%.*}"
            rm -f "${1%.*}"{,.o}
            rm -f "$1"
            ;;
        cpp)
            # Compile C++ code
            g++ -o "${1%.*}" "$1" && ./"${1%.*}"
            rm -f "${1%.*}"{,.o}
            rm -f "$1"
            ;;
        hs)
            # Compile Haskell code
            ghc -o "${1%.*}" "$1" && ./"${1%.*}"
            rm -f "${1%.*}"{,.o}
            rm -f "${1%.*}.hi"
            ;;
        java)
            # Compile and run Java code
            javac "$1" && java "${1%.*}"
            rm -f "${1%.*}.class"
            ;;
        rs)
            # Compile and run Rust code
            rustc -o "${1%.*}" "$1" && ./"${1%.*}"
            rm -f "${1%.*}"{.rs,.rs.o}
            ;;
        *)
            echo "Unsupported file extension: $ext"
            return 1
            ;;
    esac
}
