function col --description 'Print N-th column (awk)'
    if test (count $argv) -ne 1
        echo "Usage: col N" >&2
        return 1
    end

    if not string match -qr '^[0-9]+$' -- $argv[1]
        echo "col: N must be a positive integer" >&2
        return 1
    end

    awk "{ print \$$argv[1] }"
end
