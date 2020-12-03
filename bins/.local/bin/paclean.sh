#! bash

#echo colors
REDC='\033[0;31m'
BLUEC='\033[0;34m'
GREENC='\033[0;32m'
NC='\033[0m'
remove_file="$HOME/.cache/paclean/remove_list"
keep_file="$HOME/.cache/paclean/keep_list"

if [ "$1" == "-r" ]; then
    echo "=>reseting all saved keep and remove"
    rm $remove_file
    rm $keep_file
    exit 0
elif [ "$1" == "-h" ]; then
    echo "-r to reset keep and remove list"
    echo "-h to print this page"
    exit 0
fi


# loading cached files

echo "=>preparing paclean..."
mkdir -p "$HOME/.cache/paclean"

if [ -f $keep_file ]; then
    echo "=>loading 'keep list' from cache..."
    keep_list=`cat $keep_file`
fi

if [ -f $remove_file ]; then
    echo "=>loading 'to remove list' from cache..."
    remove_list=`cat $remove_file`
fi

echo "=>Fetching all packages..."
pkg_list=$(comm -23 <(pacman -Qqett | sort) <(pacman -Qqg base -g base-devel | sort | uniq))


## printing packages and getting actions

function list_contains {
  local list="$1"
  local item="$2"
  if [[ $list =~ (^|[[:space:]])"$item"($|[[:space:]]) ]] ; then
    # yes, list include item
    result=0
  else
    result=1
  fi
  return $result
}

for pkg in $pkg_list
do
    if `list_contains "$keep_list" "$pkg"`; then
        continue
    fi

    if `list_contains "$remove_list" "$pkg"`; then
        continue
    fi

    echo "#$pkg#"
    echo -e "${GREENC}"$(pacman -Qs ^$pkg$)"${NC}"
    while true;
    do
        echo " "
        echo -e "${REDC}=>[r/k/i/e] for [remove/keep/more info/remove and exit] default to keep${NC}"
        printf "=> "
        read ans
        if [ $ans == "r" ]; then
            echo "removing"
            echo $pkg >> $remove_file
            break
        elif [ $ans == "i" ]; then
            echo -e "${BLUEC}*All info:"
            pacman -Qi $pkg
            echo -e "${NC}"
            pkg_list=($pkg "${pkg_list[@]}") # keeping to loop over again
        elif [ $ans == "e" ]; then
            break 2 # breat both loop jump to remove part
        else
            echo "keeping"
            echo $pkg >> $keep_file
            break
        fi
    done
done

## remove unneeded packages
echo "   "
echo "Loading all 'to remove' packages"
remove_list=`cat $remove_file` #update list again
for pkg in $remove_list
do
    sudo pacman -Rs $pkg --noconfirm
    sed -i '1d' $remove_file # remove this package from file
done

echo ""
echo "Finished removing"
