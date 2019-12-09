@echo off
echo "Updating Anaconda"
conda update --all -y
conda clean --all -y
echo on
