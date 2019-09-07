#!/usr/bin/fish

# https://interrupt.memfault.com/blog/building-a-cli-for-firmware-projects

function cc
    set scriptdir (dirname (status --current-filename))
    # test for argument count and bail if none provided
    if test (count $argv) -eq 0
        echo "error: insufficient arguments" 1>&2
        cc help
        return 1
    end

    switch $argv[1]
        case help
            echo
            echo "usage:"
            echo "    help: display help/usage"
            echo "    repo"
            echo "    video"
        case repo
            firefox "https://github.com/fouric/cavern-chronicle"
        case video
            nohup mpv $HOME/ramdisk/Episode\ $argv[2]* 2>&1 >/dev/null &; disown
        case '*'
            echo "error: unrecognized option: " $argv[1] 1>&2
            cc help
    end
end

cc $argv
