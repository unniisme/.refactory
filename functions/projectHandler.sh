
function projects () {

    PROJECTDIR="/media/unnii/unnii/Projects"

    if [ ! -d $PROJECTDIR ]; then
        echo "Mounting disk"
        disk
    fi

    cd $PROJECTDIR

    # Individual cases
    if [ "$@" == "Godot" ]; then
        Godot4 --path "$PROJECTDIR/BTP/fish-in-the-barrel/Fish-in-the-barrel" --editor
    fi
}
