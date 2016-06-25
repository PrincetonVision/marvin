#! /usr/bin/env bash
cd "$( dirname "${BASH_SOURCE[0]}" )"
curl -O http://vision.princeton.edu/marvin/3DShapeNets/modelnet40_r_12_v_30_train_images.tensor 
curl -O http://vision.princeton.edu/marvin/3DShapeNets/modelnet40_r_12_v_30_train_labels.tensor 
curl -O http://vision.princeton.edu/marvin/3DShapeNets/modelnet40_r_12_v_30_test_images.tensor 
curl -O http://vision.princeton.edu/marvin/3DShapeNets/modelnet40_r_12_v_30_test_labels.tensor 
cd -
