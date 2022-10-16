#!bin/bash

# TODO => Update pulls on each branches if possible

start_time=$(date +%s)
cd "$(dirname "$0")"  # Setting current directory to the calling folder
for remote in $@ 
do
  # pwd
  basename=$(basename $remote)
  reponame=${basename%.*}
  mkdir -p $reponame
  cd $reponame
 branches=( $( git ls-remote --heads $remote | cut -f2) )
 for branch in "${branches[@]}"
 do
   bname=$( echo "$branch" | rev | cut -d/ -f1 | rev)
   # echo $bname
    mkdir -p $bname
    cd $bname
    git init
    git remote add -t $bname -f origin $remote
    git checkout $bname
    cd ..
 done
  cd ..
done
end_time=$(date +%s)
elapsed=$(( end_time - start_time ))
eval "echo Powercloned in: $(date -ud "@$elapsed" +'$((%s/3600/24)) days %H hr %M min %S sec')"

