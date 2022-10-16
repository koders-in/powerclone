#!bin/bash

# TODO => Update pulls on each branches if possible

for reponame in $@ 
do
  echo $reponame
  mkdir -p $reponame
  cd $reponame
  branches=( $( git ls-remote --heads $remote | cut -f2) )
  for branch in "${branches[@]}"
  do
    bname=$( echo "$branch" | rev | cut -d/ -f1 | rev)
    mkdir $bname
    cd $bname
    git init
    git remote add -t $bname -f origin $remote
    git checkout $bname
    cd ..
  done
  cd ..
  echo "Powerclone in " # TODO => Add time
done

