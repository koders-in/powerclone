#!bin/bash

# TODO => Update pulls on each branches if possible

cd "(dirname "$0")"  # Setting current directory to the calling folder
for remote in $@ 
do
  basename=$(basename $remote)
  reponame=${basenme%.*}
  echo $reponame
  mkdir -p $reponame
  cd $reponame
  branches=( $( git ls-remote --heads $remote | cut -f2) )
  for branch in "${branches[@]}"
  do
    bname=$( echo "$branch" | rev | cut -d/ -f1 | rev)
    mkdir -p $bname
    cd $bname
    git init
    git remote add -t $bname -f origin $remote
    git checkout $bname
    cd ..
  done
  cd ..
  echo "Powercloned in " # TODO => Add time
done

