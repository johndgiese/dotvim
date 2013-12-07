function section {
    echo $1
}

function errcheck {
    if [ !$? ]; then
        echo "ERROR"
        exit
    fi
}

section "Compiling YouCompleteMe"
cd bundle/YouCompleteMe
sh install.sh
cd ../..
errcheck
